unit uCadastro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,System.JSON;

type
  TFCadastro = class(TForm)
    StyleBook1: TStyleBook;
    pnlProduto: TPanel;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    edtMarca: TEdit;
    edtEstoque: TEdit;
    edtPreco: TEdit;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner : TComponent; Codigo, Descricao, Marca, Estoque, Preco: string); overload;
  end;

var
  FCadastro: TFCadastro;

implementation

{$R *.fmx}

uses uMain;

procedure TFCadastro.Button2Click(Sender: TObject);
var
   Product :TJSONObject;
begin
   Product := TJSONObject.Create;

   if Trim(edtCodigo.Text) <> '' then
      Product.AddPair('idProduto',TJSONNumber.Create( edtCodigo.Text));

   Product.AddPair('descricao', edtDescricao.Text);
   Product.AddPair('marca', edtMarca.Text);
   Product.AddPair('estoque', TJSONNumber.Create(StrToIntDef(edtEstoque.Text,0)));
   Product.AddPair('preco', TJSONNumber.Create(StrToFloatDef(edtPreco.Text.Replace('R$ ','').Replace('.','') ,0)));

   try
     createOrUpdateProduct(Product,edtCodigo);
   finally
     Product.Free;
   end;

end;

procedure TFCadastro.Button3Click(Sender: TObject);
var
   Product :TJSONObject;
begin

   if Trim(edtCodigo.Text) <> '' then begin
      Product := TJSONObject.Create;
      Product.AddPair('idProduto',TJSONNumber.Create(edtCodigo.Text));

      try
        deleteProduct(Product);
      finally
        Product.Free;
      end;
   end;

   pnlProduto.Enabled := False;
end;

constructor TFCadastro.Create(AOwner: TComponent; Codigo, Descricao, Marca,
  Estoque, Preco: string);
begin
  inherited Create(AOwner);
  edtCodigo.Text := Codigo;
  edtDescricao.Text := Descricao;
  edtMarca.Text := Marca;
  edtEstoque.Text := Estoque;
  edtPreco.Text := Preco;
end;

end.
