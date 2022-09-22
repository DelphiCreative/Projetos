unit uContainer;

interface

uses
  System.IOUtils,
  System.SysUtils, System.Classes, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.UI.Intf,
  FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Phys.SQLite;

type
  TFDConnectionHelper = class helper for TFDConnection
     function GetVersion :Integer;
     procedure ExecSQL(FDScript: TFDScript); overload;
  end;

type
  TContainer = class(TDataModule)
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDScript1: TFDScript;
    SQLite: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure SQLiteBeforeConnect(Sender: TObject);
    procedure SQLiteAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Container: TContainer;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TFDConnectionHelper }

procedure TFDConnectionHelper.ExecSQL(FDScript: TFDScript);
var
   VersaoAtual , I :Integer;
begin
   VersaoAtual := GetVersion;

   for I := VersaoAtual to FDScript.SQLScripts.Count -1 do begin
      try
         ExecSQL(FDScript.SQLScripts[I].SQl.Text);
      finally
         ExecSQL('UPDATE Versao SET VersaoDB = ' +Inttostr(I+1));
      end;
   end;

end;

function TFDConnectionHelper.GetVersion: Integer;
var
   versao :integer;
begin
   ExecSQL('CREATE TABLE IF NOT EXISTS Versao (VersaoDB INTEGER)');

   versao := ExecSQLScalar('SELECT VersaoDB FROM Versao');
   if versao = 0 then
      ExecSQL('INSERT INTO Versao (VersaoDB) VALUES (0)');

   Result := versao;

end;

procedure TContainer.DataModuleCreate(Sender: TObject);
begin
   SQLite.Connected := True;
end;

procedure TContainer.SQLiteAfterConnect(Sender: TObject);
begin
   TFDConnection(Sender).ExecSQL(FDScript1);
end;

procedure TContainer.SQLiteBeforeConnect(Sender: TObject);
begin
   TFDConnection(Sender).DriverName := 'SQLite';
   TFDConnection(Sender).Params.Database := TPath.Combine(TPAth.GetDocumentsPath,'contas.db');

end;

end.
