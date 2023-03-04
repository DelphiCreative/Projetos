unit uCards;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls;

type
  TFCard = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Layout2: TLayout;
    imgIcone: TImage;
    Layout3: TLayout;
    txtDescricao: TText;
    txtValor: TText;
    Layout4: TLayout;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCard: TFCard;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

end.
