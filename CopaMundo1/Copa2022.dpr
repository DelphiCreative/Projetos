program Copa2022;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form3},
  uContainer in 'uContainer.pas' {Container: TDataModule},
  FMX.Helpers.Layouts in '..\HelpersUnits\FMX.Helpers.Layouts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TContainer, Container);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
