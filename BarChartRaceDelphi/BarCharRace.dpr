program BarCharRace;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmMain},
  uBarChartManager in 'uBarChartManager.pas',
  FMX.Helper.FLowLayout in 'FMX.Helper.FLowLayout.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
