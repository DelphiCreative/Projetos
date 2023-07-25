program DinheiroContado;

uses
  System.StartUpCopy,
  FMX.Forms,
  Skia.FMX,
  uMain in 'uMain.pas' {fMain},
  uContainer in 'uContainer.pas' {Container: TDataModule},
  uContas in 'uContas.pas',
  uCards in 'uCards.pas' {FCard},
  uSettings in 'uSettings.pas',
  Chart4Delphi in '..\HelpersUnits\Chart4Delphi.pas',
  FMX.Functions in '..\HelpersUnits\FMX.Functions.pas',
  FMX.Helpers.FloatAnimation in '..\HelpersUnits\FMX.Helpers.FloatAnimation.pas',
  FMX.Helpers.Image in '..\HelpersUnits\FMX.Helpers.Image.pas',
  FMX.Helpers.Layouts in '..\HelpersUnits\FMX.Helpers.Layouts.pas',
  FMX.Helpers.Text in '..\HelpersUnits\FMX.Helpers.Text.pas',
  FMX.Helpers.Shape in '..\HelpersUnits\FMX.Helpers.Shape.pas',
  FMX.Helpers in '..\HelpersUnits\FMX.Helpers.pas',
  uChart in '..\HelpersUnits\uChart.pas';

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TContainer, Container);
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
