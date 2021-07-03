unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.DBCtrls, Vcl.Mask, Vcl.Buttons, VCL.Firebase.Realtime;

type
  TFormMain = class(TForm)
    ImagemProduto: TImage;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBRichEdit1: TDBRichEdit;
    DBComboBox1: TDBComboBox;
    DBEdit3: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ProdutosGrid: TDBGrid;
    Shape1: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    RT : TRealtime;
    procedure CarregaCategoria;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses uContainer, VCL.Helpers, VCL.Image.Base64;


procedure TFormMain.CarregaCategoria;
begin
   DBComboBox1.Lista(Categorias);
end;

procedure TFormMain.DBEdit1Change(Sender: TObject);
begin
   ImagemProduto.Base64(Container.SQLite.ExecSQLScalar('SELECT  Base64 FROM imagem WHERE _id = "' +DBEdit1.Text+'"' ));
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
   ImagemProduto.Popup;
   Container.SQLite.Connected := True;
   ProdutosGrid.AutoSize;

   RT := TRealtime.Create('democursofirebase-default-rtdb','5UybNyF0LT2fx3mLQQsQypBF7AoM5vnH2q89WFsK');

end;

procedure TFormMain.SpeedButton1Click(Sender: TObject);
begin
   if Container.Produtos.State = dsBrowse then
      Container.Produtos.Append
   else if Container.Produtos.State in [dsInsert,dsEdit] then
      Container.Produtos.Post

end;

procedure TFormMain.SpeedButton2Click(Sender: TObject);
begin
   if Container.Produtos.State = dsBrowse then
      Container.Produtos.Delete
   else if Container.Produtos.State in [dsInsert,dsEdit] then
      Container.Produtos.Cancel
end;

end.
