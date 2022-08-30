program GoogleSheets4Delphi;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form1},
  GoogleSheets4Delphi_TLB in 'GoogleSheets4Delphi_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
