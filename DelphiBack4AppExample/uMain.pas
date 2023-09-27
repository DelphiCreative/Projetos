unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, System.JSON, FMX.Objects, FMX.ListBox,
  FMX.Layouts, System.Rtti, FMX.Grid.Style, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.ScrollBox, FMX.Grid, System.Generics.Collections,
  FMX.ComboEdit, FMX.Memo.Types, FMX.Memo, Skia, Skia.FMX, FMX.MultiView,
  FMX.Effects;

type
  TFMain = class(TForm)
    StyleBook1: TStyleBook;
    tabProduto: TFDMemTable;
    tabProdutoID: TLargeintField;
    tabProdutoDescricao: TStringField;
    tabProdutoMarca: TStringField;
    tabProdutoEstoque: TIntegerField;
    tabProdutoPreco: TCurrencyField;
    VertScrollBox1: TVertScrollBox;
    Z: TPanel;
    Label5: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    btnLimpar: TButton;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SkSvg1: TSkSvg;
    CalloutRectangle1: TCalloutRectangle;
    Layout4: TLayout;
    Layout1: TLayout;
    Label9: TLabel;
    edtUserName: TEdit;
    Label10: TLabel;
    edtPassword: TEdit;
    Layout2: TLayout;
    Label11: TLabel;
    edtEmail: TEdit;
    Label12: TLabel;
    edtTelefone: TEdit;
    btnSignUp: TButton;
    Label13: TLabel;
    Layout3: TLayout;
    btnLogin: TButton;
    Label14: TLabel;
    ShadowEffect1: TShadowEffect;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Layout5: TLayout;
    Rectangle1: TRectangle;
    Panel1: TPanel;
    Label18: TLabel;
    edtDescricao: TEdit;
    Label19: TLabel;
    edtDescricaoCondicao: TComboEdit;
    Label20: TLabel;
    edtMarca: TEdit;
    Label21: TLabel;
    edtMarcaCondicao: TComboEdit;
    Label7: TLabel;
    edtOrder: TComboEdit;
    Label6: TLabel;
    edtLimite: TComboEdit;
    Label8: TLabel;
    edtPage: TEdit;
    btnGetProductList: TButton;
    Panel2: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGetProductListClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Label14Click(Sender: TObject);
    procedure Label13Click(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnSignUpClick(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FormList :  TObjectList<TForm>;
    PanelList : TObjectList<TPanel>;
    procedure ParseJSON(const json: string);

  end;

function createOrUpdateProduct(const AJson: TJSONObject; AEdit: TEdit = nil): string;
function deleteProduct(const AJson: TJSONObject): string;
procedure Log(const AValue :String); overload;
procedure Log(const JSON :TJSONObject); overload;

function SendData(AplicationID, RestApiKey: WideString; JsonData: TJSONObject; ClouFunction: WideString): WideString; stdcall; external 'ParseServerDLL.dll';
function SignUp(AplicationID, RestApiKey :WideString; UserName, Password: string; JsonData: TJSONObject = nil): string; stdcall; external 'ParseServerDLL.dll';
function LogIn(AplicationID, RestApiKey :WideString; UserName, Password: string): string; stdcall; external 'ParseServerDLL.dll';

var
  FMain: TFMain;
  panelCount :Integer;
  SessionToken :String;

implementation

{$R *.fmx}

uses AppConfig, uCadastro, Helpers.Utils;

procedure Log(const AValue :String);
begin
   FMain.Memo1.Lines.Text :=  AValue.JsonFormat + #13#13 +  FMain.Memo1.Lines.Text;
end;

procedure Log(const JSON :TJSONObject); overload;
begin
   Log(Json.Format);
end;

function createOrUpdateProduct(const AJson: TJSONObject; AEdit: TEdit = nil): string;
var produto :string;
begin

   Log(AJson.Format);

   produto := SendData(ApplicationID, RestApiKey, AJson,'createOrUpdateProduct');

   Log(produto);

   if Assigned(AEdit) then begin
      AEdit.Text := produto.FindJsonValue('idProduto');
   end;
end;

function deleteProduct(const AJson: TJSONObject): string;
begin

   //Parse.SendData(AJson,'destroyProduct') ;
   Log(SendData(ApplicationID, RestApiKey, AJson,'deleteProduct'));

end;

procedure TFMain.Button1Click(Sender: TObject);
var
   Row: Integer;
   Panel: TPanel;
begin
   for Panel in PanelList do
      Panel.Position.Y := Panel.Position.Y + Panel.Height;

   FCadastro := TFCadastro.Create(Self);

   FCadastro.pnlProduto.Position.Y := 10;
   FCadastro.pnlProduto.Position.X := 0;

   VertScrollBox1.AddObject(FCadastro.pnlProduto);
   PanelList.Add(FCadastro.pnlProduto);

end;

procedure TFMain.btnGetProductListClick(Sender: TObject);
var
   Query :TJSONObject;
begin
   Query := TJSONObject.Create;

   if edtDescricao.Text <> '' then begin
      if edtDescricaoCondicao.ItemIndex = 1 then
         Query.AddPair('descricao', edtDescricao.Text+'%')
      else if edtDescricaoCondicao.ItemIndex = 2 then
         Query.AddPair('descricao', '%'+edtDescricao.Text+'%')
      else
         Query.AddPair('descricao', edtDescricao.Text);
   end;

   if edtMarca.Text <> '' then begin
      if edtMarcaCondicao.ItemIndex = 1 then
         Query.AddPair('marca', edtMarca.Text+'%')
      else if edtMarcaCondicao.ItemIndex = 2 then
         Query.AddPair('marca', '%'+edtMarca.Text+'%')
      else
         Query.AddPair('marca', edtMarca.Text);
   end;

   Query.AddPair('page', TJSONNumber.Create(StrToIntDef(edtPage.Text,0)));
   Query.AddPair('limit', TJSONNumber.Create(StrToIntDef(edtLimite.Text,5)));
   Query.AddPair('orderBy', edtOrder.text);

   Log(Query);

   ParseJson(SendData(ApplicationID, RestApiKey, Query,'getProductList'));

end;

procedure TFMain.btnSignUpClick(Sender: TObject);
var
   User :TJSONObject;
begin
   User := TJSONObject.Create;
   User.AddPair('email', edtEmail.Text);
   User.AddPair('telefone',edtTelefone.Text);

   Log(User);

   Log(SignUp(ApplicationID, RestApiKey, edtUserName.Text,edtPassword.text,User));

end;

procedure TFMain.btnLimparClick(Sender: TObject);
begin
   PanelList.Clear;
end;

procedure TFMain.btnLoginClick(Sender: TObject);
begin
   var user := LogIn(ApplicationID, RestApiKey, edtUserName.Text, edtPassword.Text);

   Label16.Text := user.FindJsonValue('username');
   Label17.Text := user.FindJsonValue('objectId');

end;

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FormList.Free;
   PanelList.Free;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin

   FormList := TObjectList<TForm>.Create;
   FormList.OwnsObjects := True;
   PanelList :=  TObjectList<TPanel>.Create;

   Layout5.Visible := False;
   Layout2.Visible := False;
   Layout3.Visible := not Layout2.Visible;
end;

procedure TFMain.Label13Click(Sender: TObject);
begin
   Layout2.Visible := False;
   CalloutRectangle1.Height := 256;
   Layout3.Visible := not Layout2.Visible;
end;

procedure TFMain.Label14Click(Sender: TObject);
begin
   Layout2.Visible := True;
   CalloutRectangle1.Height := 356;
   Layout3.Visible := not Layout2.Visible;
end;

procedure TFMain.Label8Click(Sender: TObject);
var
   Panel: TPanel;
   Y :Real;
begin

   Y := 0;
   for Panel in PanelList do begin
      if Panel.Enabled then begin
         Panel.Position.Y := Y ;
         y := Panel.Height + Y;
      end;

      Panel.Visible := Panel.Enabled
   end;

end;

procedure TFMain.ParseJSON(const json: string);
var
   jsonValue: TJsonValue;
   jsonArray: TJsonArray;
   jsonObject: TJsonObject;
   i: Integer;
begin

   PanelList.Clear;

   jsonValue := TJsonObject.ParseJSONValue(json);

   Memo1.Lines.Text := jsonValue.Format();

   if jsonValue.TryGetValue<TJsonArray>('result', jsonArray) then begin
      for i := 0 to jsonArray.Count - 1 do begin
         jsonObject := jsonArray.Items[i] as TJsonObject;

         FCadastro := TFCadastro.Create(Self,jsonObject.GetValue('idProduto').Value,
                                             jsonObject.GetValue('descricao').Value,
                                             jsonObject.GetValue('marca').Value,
                                             jsonObject.GetValue('estoque').Value,
                                             jsonObject.GetValue('preco').Value);

         FCadastro.pnlProduto.Position.Y := (i *  FCadastro.pnlProduto.Height) + 10;
         FCadastro.pnlProduto.Position.X := 0;
         VertScrollBox1.AddObject(FCadastro.pnlProduto);
         PanelList.Add(FCadastro.pnlProduto);
      end;
   end;

   jsonValue.Free;
end;

procedure TFMain.SpeedButton1Click(Sender: TObject);
begin
   Layout5.Visible := not Layout5.Visible;
end;

end.
