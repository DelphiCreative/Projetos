program CadastroBase64;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {FormMain},
  uContainer in 'uContainer.pas' {Container: TDataModule},
  VCL.Helpers in 'VCL.Helpers.pas',
  VCL.Image.Base64 in 'VCL.Image.Base64.pas',
  VCL.Firebase.Realtime in '..\..\Units\VCL.Firebase.Realtime.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TContainer, Container);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
