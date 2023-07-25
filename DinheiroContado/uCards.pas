unit uCards;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, Skia, Skia.FMX,
  FMX.Effects, FMX.Ani;

type
  TFCard = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout4: TLayout;
    Image1: TImage;
    Image2: TImage;
    imgEditar: TImage;
    Layout5: TLayout;
    Rectangle3: TRectangle;
    B: TLayout;
    Layout7: TLayout;
    SkLabel1: TSkLabel;
    Circle1: TCircle;
    imgIcone: TImage;
    Circle2: TCircle;
    Image4: TImage;
    txtDescricao: TSkLabel;
    txtValor: TSkLabel;
    rctSelecionar: TRectangle;
    lblQRCodeRender: TSkLabel;
    btnSelecionar: TSpeedButton;
    ShadowEffect1: TShadowEffect;
    Layout6: TLayout;
    Rectangle1: TRectangle;
    Layout8: TLayout;
    Layout9: TLayout;
    Layout10: TLayout;
    RoundRect1: TRoundRect;
    RoundRect2: TRoundRect;
    Layout3: TLayout;
    Layout11: TLayout;
    rctCategoriaPorcItem: TRectangle;
    Layout12: TLayout;
    Layout13: TLayout;
    Layout14: TLayout;
    SkLabel2: TSkLabel;
    Layout15: TLayout;
    SkLabel3: TSkLabel;
    RoundRect3: TRoundRect;
    RoundRect4: TRoundRect;
    Layout17: TLayout;
    Circle3: TCircle;
    Image8: TImage;
    Layout16: TLayout;
    Rectangle2: TRectangle;
    Layout18: TLayout;
    Circle4: TCircle;
    Image3: TImage;
    Layout19: TLayout;
    SkLabel4: TSkLabel;
    Layout20: TLayout;
    Rectangle4: TRectangle;
    SkLabel5: TSkLabel;
    ShadowEffect2: TShadowEffect;
    SpeedButton1: TSpeedButton;
    Layout21: TLayout;
    Rectangle5: TRectangle;
    SkLabel6: TSkLabel;
    ShadowEffect3: TShadowEffect;
    SpeedButton2: TSpeedButton;
    procedure imgIconeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CardCategoriaPorc(ADescricao,APorc: String);
    constructor Create(AOwner : TComponent; ADesc: string; APorc: Real; AColor : TAlphaColor); overload;
  end;

var
  FCard: TFCard;

implementation

{$R *.fmx}

uses FMX.Helpers.Image, uMain;

procedure TFCard.CardCategoriaPorc(ADescricao, APorc: String);
begin


end;

constructor TFCard.Create(AOwner : TComponent; ADesc: string; APorc: Real; AColor : TAlphaColor);
begin
  inherited Create(AOwner);
  SkLabel3.Text := ADesc;
  SkLabel2.Text := IntToStr(Round(APorc)) + '%';
  RoundRect4.Fill.Color := AColor;
  Circle3.Fill.Color := AColor;

end;

procedure TFCard.imgIconeClick(Sender: TObject);
begin

   if imgIcone.Tag = 0 then begin
      imgIcone.ImageByName('ACEITAR');
      imgIcone.Tag := 1
   end else begin
      imgIcone.ImageByName(imgIcone.Hint);
      imgIcone.Tag := 0;
   end;
   fMain.MultiSelect;
end;

end.
