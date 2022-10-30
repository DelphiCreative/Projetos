unit FMX.Helpers.Firedac;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;


type
  TFDConnectionHelper = class helper for TFDConnection
    public
      procedure BDBeforeConnect(Sender: TObject);
      procedure BDAfterConnect(Sender: TObject);
      constructor Create(AOwner :TComponent);
  end;

var
  BD :TFDConnection;
  BDQuery : TFDQuery;


implementation

uses
  System.IOUtils;
{ TFDConnectionHelper }

procedure TFDConnectionHelper.BDAfterConnect(Sender: TObject);
begin

end;

procedure TFDConnectionHelper.BDBeforeConnect(Sender: TObject);
begin
   DriverName := 'SQLite';
   Params.Database := TPath.Combine(TPath.GetDocumentsPath,Name+'.db');
end;

constructor TFDConnectionHelper.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   BeforeConnect := BDBeforeConnect;
end;

initialization
  BD := TFDConnection.Create(nil);
  BDQuery := TFDQuery.Create(nil);
  BDQuery.Connection := BD;

finalization
  BDQuery.Free;
  BD.Free;
end.
