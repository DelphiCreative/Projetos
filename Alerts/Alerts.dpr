program Alerts;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Skia,
  uMain in 'uMain.pas' {Form1},
  FMX.Alerts in '..\HelpersUnits\FMX.Alerts.pas';

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
