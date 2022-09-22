program ControleContas;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form3},
  uContainer in 'uContainer.pas' {Container: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TContainer, Container);
  Application.Run;
end.
