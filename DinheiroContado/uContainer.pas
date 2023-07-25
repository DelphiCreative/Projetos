unit uContainer;

interface

uses
  FMX.Dialogs, System.Variants,
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, System.IOUtils, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TFDConnectionHelper = class helper for TFDConnection
    function GetVersion: Integer;
    procedure ExecuteScriptsVersion(var FDScript: TFDScript);
  end;

type
  TFDScriptHelper = class helper for TFDScript
    function SQL(AIndex :Integer) :string;
  end;

type
  TContainer = class(TDataModule)
    SQLite: TFDConnection;
    FDScript1: TFDScript;
    tabCategorias: TFDQuery;
    tabContas: TFDQuery;
    tabLista: TFDQuery;
    FDScript2: TFDScript;
    tabConsulta: TFDQuery;
    tabExecute: TFDQuery;
    procedure SQLiteBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure SQLiteAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EditarCategoria(ID,Icone,IconeCor :String);
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


procedure TContainer.EditarCategoria(ID, Icone, IconeCor: String);
begin
   if ID <> '' then begin
      Container.TabExecute.Open('SELECT * FROM Categorias WHERE ID = '+ ID);
      Container.TabExecute.Edit;
      Container.TabExecute.FieldByName('Icone').AsString := Icone;
      Container.TabExecute.FieldByName('IconeCor').AsString := IconeCor;
      Container.tabExecute.Post;
   end;
end;

procedure TContainer.SQLiteAfterConnect(Sender: TObject);
begin
   SQLite.ExecuteScriptsVersion(FDScript1);
end;

procedure TContainer.SQLiteBeforeConnect(Sender: TObject);
var
   AppName: string;
begin
   AppName := ChangeFileExt(ExtractFileName(ParamStr(0)),'.db');
   TFDConnection(Sender).DriverName := 'SQLite';
   TFDConnection(Sender).Params.Database := TPath.Combine(TPath.GetDocumentsPath, AppName);
end;

{ TFDConnectionHelper }

procedure TFDConnectionHelper.ExecuteScriptsVersion(var FDScript: TFDScript);
var
  versionAtual,  I :Integer;
begin

  versionAtual := GetVersion;

  for I := versionAtual to FDScript.SQLScripts.Count - 1 do begin
     try
        ExecSQL(FDScript.SQLScripts.Items[I].SQL.Text);
     finally
        ExecSQL('UPDATE Versao SET VersaoBD ='+inttostr(I+1));
     end;
  end;

end;

function TFDConnectionHelper.GetVersion: Integer;
var
   versao :Variant;
begin

   ExecSQL('CREATE TABLE IF NOT EXISTS Versao (VersaoBD INTEGER);');

   try
      versao := ExecSQLScalar('SELECT VersaoBD FROM Versao');
      if not VarIsNull(versao) then begin
         if versao = 0 then begin
            ExecSQL('INSERT INTO Versao (VersaoBD) VALUES (0)');
            Result := 0;
         end else
            Result := (versao)
      end else
         Result := -1;
   except
      on E:Exception do begin
         raise Exception.Create('GetVersion ' + E.Message);
      end;
   end;

end;

{ TFDScriptHelper }

function TFDScriptHelper.SQL(AIndex: Integer): string;
begin
   result := SQLScripts.Items[AIndex].SQL.Text.Replace(#$D#$A,' ').Replace(#13#10,' ');
end;

end.

