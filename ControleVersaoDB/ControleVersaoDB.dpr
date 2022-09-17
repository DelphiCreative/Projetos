program ControleVersaoDB;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmMain},
  uContainer in 'uContainer.pas' {Container: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TContainer, Container);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
