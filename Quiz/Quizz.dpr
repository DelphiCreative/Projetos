program Quizz;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form2},
  Firebase.Realtime in '..\..\Aplicativos\Units\Firebase.Realtime.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
