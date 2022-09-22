program Telegram;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form3},
  FMX.Helpers.Button in '..\HelpersUnits\FMX.Helpers.Button.pas',
  FMX.Helpers.Firedac in '..\HelpersUnits\FMX.Helpers.Firedac.pas',
  FMX.Helpers.Image in '..\HelpersUnits\FMX.Helpers.Image.pas',
  FMX.Helpers.JSON in '..\HelpersUnits\FMX.Helpers.JSON.pas',
  FMX.Helpers.Layouts in '..\HelpersUnits\FMX.Helpers.Layouts.pas',
  FMX.Helpers.ListBox in '..\HelpersUnits\FMX.Helpers.ListBox.pas',
  FMX.Helpers in '..\HelpersUnits\FMX.Helpers.pas',
  FMX.Helpers.Rectangle in '..\HelpersUnits\FMX.Helpers.Rectangle.pas',
  FMX.Helpers.Shape in '..\HelpersUnits\FMX.Helpers.Shape.pas',
  FMX.Helpers.TabControl in '..\HelpersUnits\FMX.Helpers.TabControl.pas',
  FMX.Helpers.Text in '..\HelpersUnits\FMX.Helpers.Text.pas',
  FMX.JSON.Utils in '..\HelpersUnits\FMX.JSON.Utils.pas',
  FMX.Slides in '..\HelpersUnits\FMX.Slides.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
