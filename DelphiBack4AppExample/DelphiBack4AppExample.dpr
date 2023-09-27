program DelphiBack4AppExample;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {FMain},
  AppConfig in 'AppConfig.pas',
  uCadastro in 'uCadastro.pas' {FCadastro},
  Helpers.Utils in 'Helpers.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFCadastro, FCadastro);
  Application.Run;
end.
