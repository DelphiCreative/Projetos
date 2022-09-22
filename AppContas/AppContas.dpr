program AppContas;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form2},
  uContainer in 'uContainer.pas' {Container: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TContainer, Container);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
