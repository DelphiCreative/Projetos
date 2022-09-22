unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.Mask, FireDAC.Comp.DataSet, PythonEngine;

type
  TForm2 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDQuery1Codigo: TFDAutoIncField;
    FDQuery1Nome: TStringField;
    FDQuery1Telefone: TStringField;
    FDQuery1Mensagem: TWideMemoField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DataSource1: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBMemo1: TDBMemo;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FDConnection1AfterConnect(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
   PythonEngine1.ExecStrings(Memo1.Lines);
end;

procedure TForm2.FDConnection1AfterConnect(Sender: TObject);
begin
   FDConnection1.ExecSQL('CREATE TABLE IF NOT EXISTS Mensagens (' +
                         'Codigo INTEGER PRIMARY KEY AUTOINCREMENT,'+
                         'Nome VARCHAR(50),'+
                         'Telefone VARCHAR(14),'+
                         'Mensagem TEXT )');
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
   FDConnection1.Params.Database := 'mensagem.db';
   FDConnection1.DriverName := 'SQLite';

   FDConnection1.Connected := True;

   FDQuery1.Open();
end;

end.
