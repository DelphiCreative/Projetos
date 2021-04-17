program Slides;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form2},
  FMX.Slides in 'FMX.Slides.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
