unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.DBCtrls, Vcl.Mask, Vcl.Buttons;

type
  TForm2 = class(TForm)
    Image1: TImage;
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
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregaCategoria;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses uContainer, VCL.Helpers;

procedure TForm2.CarregaCategoria;
begin
   DBComboBox1.Lista(Categorias);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
   Container.SQLite.Connected := True;
   ProdutosGrid.AutoSize;
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
   if Container.Produtos.State = dsBrowse then
      Container.Produtos.Append
   else if Container.Produtos.State in [dsInsert,dsEdit] then
      Container.Produtos.Post

end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
begin
   if Container.Produtos.State = dsBrowse then
      Container.Produtos.Delete
   else if Container.Produtos.State in [dsInsert,dsEdit] then
      Container.Produtos.Cancel
end;

end.
