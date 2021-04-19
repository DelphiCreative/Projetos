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
    procedure SQLiteBeforeConnect(Sender: TObject);
    procedure SQLiteAfterConnect(Sender: TObject);
    procedure ProdutosBeforeInsert(DataSet: TDataSet);
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
   System.IOUtils, uMain, VCL.Helpers;

function Categorias :String;
begin
   Result := Container.SQLite.ExecSQLScalar('SELECT COALESCE(Group_Concat(Categoria),"") Categorias FROM (SELECT Categoria FROM produtos GROUP BY Categoria)')
end;

procedure TContainer.ProdutosBeforeInsert(DataSet: TDataSet);
begin
   Form2.CarregaCategoria;
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
