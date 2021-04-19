program CadastroBase64;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form2},
  uContainer in 'uContainer.pas' {Container: TDataModule},
  VCL.Helpers in 'VCL.Helpers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TContainer, Container);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
