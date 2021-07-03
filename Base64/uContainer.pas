unit uContainer;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TContainer = class(TDataModule)
    SQLite: TFDConnection;
    SQLiteDriver: TFDPhysSQLiteDriverLink;
    ProdutosSource: TDataSource;
    Produtos: TFDQuery;
    CategoriasSource: TDataSource;
    Categorias: TFDQuery;
    Imagem: TFDQuery;
    procedure SQLiteBeforeConnect(Sender: TObject);
    procedure SQLiteAfterConnect(Sender: TObject);
    procedure ProdutosBeforeInsert(DataSet: TDataSet);
    procedure ProdutosAfterPost(DataSet: TDataSet);
    procedure ProdutosBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function Categorias :String;

var
  Container: TContainer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
   System.IOUtils, uMain, VCL.Helpers, VCL.Image.Base64;

function Categorias :String;
begin
   Result := Container.SQLite.ExecSQLScalar('SELECT COALESCE(Group_Concat(Categoria),"") Categorias FROM (SELECT Categoria FROM produtos GROUP BY Categoria)')
end;

procedure TContainer.ProdutosAfterPost(DataSet: TDataSet);
begin
   Imagem.Open('SELECT * FROM imagem WHERE _id = ' + Produtos.Fields[0].AsString);
   if Imagem.RecordCount = 0 then
      Imagem.Append
   else
      Imagem.Edit;

   Imagem.FieldByName('_id').AsString :=  Produtos.Fields[0].AsString;
   Imagem.FieldByName('Base64').AsString := FormMain.ImagemProduto.Base64;
   Imagem.Post;


   FormMain.RT
     .Collection('catalogo').Collection(Produtos.FieldByName('Categoria').AsString)
     .Key(Produtos.Fields[0].AsString)
     .AddPair('_id',Produtos.FieldByName('_id').AsString)
     .AddPair('produto',Produtos.FieldByName('Produto').AsString)
     .AddPair('descricao',Produtos.FieldByName('Descricao').AsString)
     .AddPair('categoria',Produtos.FieldByName('Categoria').AsString)
     .AddPair('destaque',Produtos.FieldByName('Destaque').AsBoolean)
     .AddPair('valor',Produtos.FieldByName('Valor').AsCurrency)
     .Update;

  FormMain.RT
     .Collection('imagens')
      .Key(Produtos.Fields[0].AsString)
      .AddPair('_id',Produtos.FieldByName('_id').AsString)
      .AddPair('base64', Imagem.FieldByName('Base64').AsString)
     .Update;

end;

procedure TContainer.ProdutosBeforeDelete(DataSet: TDataSet);
begin
   FormMain.RT
     .Collection('produtos')
     .Key(Produtos.Fields[0].AsString).Delete;

   FormMain.RT
     .Collection('imagens')
      .Key(Produtos.Fields[0].AsString).Delete;
end;

procedure TContainer.ProdutosBeforeInsert(DataSet: TDataSet);
begin
   FormMain.CarregaCategoria;
end;

procedure TContainer.SQLiteAfterConnect(Sender: TObject);
begin
   TFDConnection(Sender).ExecSQL('CREATE TABLE IF NOT EXISTS produtos ('+
                                 ' _id       INTEGER PRIMARY KEY AUTOINCREMENT, '+
                                 ' Produto   VARCHAR(50),'+
                                 ' Descricao VARCHAR(100),'+
                                 ' Categoria VARCHAR(50),'+
                                 ' Destaque  BOOLEAN,'+
                                 ' Valor     DECIMAL(15,2));');

   TFDConnection(Sender).ExecSQL('CREATE TABLE IF NOT EXISTS imagem ('+
                                 ' _id       INTEGER PRIMARY KEY AUTOINCREMENT, '+
                                 ' Base64    TEXT);');

   Produtos.Open('SELECT * FROM produtos');

end;

procedure TContainer.SQLiteBeforeConnect(Sender: TObject);
begin
   TFDConnection(Sender).Params.DriverID := 'SQLite';
   TFDConnection(Sender).Params.Database := TPath.Combine(TPath.GetDocumentsPath, 'catalogo.db');
end;

end.
