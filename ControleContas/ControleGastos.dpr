program ControleGastos;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {fMain},
  uContainer in 'uContainer.pas' {Container: TDataModule},
  uCards in 'uCards.pas' {Form1},
  FMX.Functions in 'FMX.Functions.pas',
  FMX.Helpers.Image in '..\HelpersUnits\FMX.Helpers.Image.pas',
  FMX.Helpers.Layouts in '..\HelpersUnits\FMX.Helpers.Layouts.pas',
  FMX.Helpers.Rectangle in '..\HelpersUnits\FMX.Helpers.Rectangle.pas',
  FMX.Helpers.Text in '..\HelpersUnits\FMX.Helpers.Text.pas',
  FMX.Helpers.Shape in '..\HelpersUnits\FMX.Helpers.Shape.pas',
  FMX.Helpers.FloatAnimation in '..\HelpersUnits\FMX.Helpers.FloatAnimation.pas',
  uContas in 'uContas.pas',
  uChart in '..\HelpersUnits\uChart.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TContainer, Container);
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TFCard, FCard);
  Application.Run;
end.
