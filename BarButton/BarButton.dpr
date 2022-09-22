program BarButton;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form2},
  FMX.Helpers.Button in '..\..\Aplicativos\Helpers\FMX.Helpers.Button.pas',
  FMX.Helpers.Firedac in '..\..\Aplicativos\Helpers\FMX.Helpers.Firedac.pas',
  FMX.Helpers.Image in '..\..\Aplicativos\Helpers\FMX.Helpers.Image.pas',
  FMX.Helpers.JSON in '..\..\Aplicativos\Helpers\FMX.Helpers.JSON.pas',
  FMX.Helpers.ListBox in '..\..\Aplicativos\Helpers\FMX.Helpers.ListBox.pas',
  FMX.Helpers.Layouts in '..\..\Aplicativos\Helpers\FMX.Helpers.Layouts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
