unit uContainer;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite;

type
  TContainer = class(TDataModule)
    SQLite: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
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

procedure TContainer.SQLiteAfterConnect(Sender: TObject);
begin
   TFDConnection(Sender).ExecSQL('CREATE TABLE version( versao  )')
end;

procedure TContainer.SQLiteBeforeConnect(Sender: TObject);
begin
   TFDConnection(Sender).DriverName := 'SQLite';
   TFDConnection(Sender).Params.Database := 'appcontas.bd';
end;

end.
