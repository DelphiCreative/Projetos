unit FMX.Functions;

interface

uses
{$IF DEFINED(android)}
  Androidapi.Helpers,
  FMX.Helpers.Android,
{$ENDIF}
  FMX.Ani,
  FMX.Controls,
  FMX.Types,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Layouts,
  FMX.Effects,
  System.UITypes;

procedure StatusBarColor(AColor: TAlphaColor); overload;

procedure StatusBarColor(Rectangles: array of TRectangle;
  AColor: TAlphaColor); overload;

procedure ShadowEffect(AShape: TShape);

implementation

uses uMain;

procedure StatusBarColor(AColor: TAlphaColor);
begin
{$IF DEFINED(android)}
  CallInUIThreadAndWaitFinishing(
    procedure
    begin
      TAndroidHelper.Activity.getWindow.setStatusBarColor(AColor);
    end);
{$ENDIF}
end;

procedure StatusBarColor(Rectangles: array of TRectangle; AColor: TAlphaColor);
var
  I: Integer;
begin
  for I := Low(Rectangles) to High(Rectangles) do
    Rectangles[I].Fill.Color := AColor;
  StatusBarColor(AColor);
end;

procedure ShadowEffect(AShape: TShape);
var
  Sombra: TShadowEffect;
begin
  Sombra := TShadowEffect.Create(AShape);
  AShape.AddObject(Sombra);
  Sombra.Distance := 2;
  Sombra.Direction := 45;
  Sombra.Softness := 0.1;
  Sombra.Opacity := 0.1;
  Sombra.ShadowColor := TAlphaColorRec.Black;
end;

end.
