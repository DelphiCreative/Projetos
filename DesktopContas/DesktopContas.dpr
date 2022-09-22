program DesktopContas;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmMain},
  uContainer in 'uContainer.pas' {Container: TDataModule},
  uLancarConta in 'uLancarConta.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TContainer, Container);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
