unit uContainer;

interface

uses
  System.IOUtils,
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite, FireDAC.Comp.Script,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TFDConnectionHelper = class helper for TFDConnection
     function GetVersion :Integer;
     procedure ExecSQL(FDScript: TFDScript); overload;
  end;


type
  TContainer = class(TDataModule)
    SQLite: TFDConnection;
    ScriptDB: TFDScript;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure SQLiteBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
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

procedure TContainer.DataModuleCreate(Sender: TObject);
begin
   SQLite.Connected := True;
end;

procedure TContainer.SQLiteAfterConnect(Sender: TObject);
begin
   TFDConnection(Sender).ExecSQL(ScriptDB);
end;

procedure TContainer.SQLiteBeforeConnect(Sender: TObject);
begin
   TFDConnection(Sender).DriverName := 'SQLite';
   TFDConnection(Sender).Params.Database := TPath.Combine(TPAth.GetDocumentsPath,'ControleVersaoDB.db');
end;

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

end.
