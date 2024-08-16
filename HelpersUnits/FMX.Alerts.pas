unit FMX.Alerts;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Ani,
  FMX.Objects,
  FMX.Layouts;

type
  TAlertType = (atNone, atSuccessToast, atErrorToast, atBottomToast, atTopToast);

type
  TAlert = class
  private
    FForm: TForm;
    FMessage: string;
    FFontColor: TAlphaColor;
    FAColor: TAlphaColor;
    FBackgroundRect, FAlertRect, FLineRect: TRectangle;
    FArc: TArc;
    FLayout: TLayout;
    FText: TText;
    FAnimArc, FAnim1, FAnim2, FAnimExit: TFloatAnimation;
    FAlertType :TAlertType;
    FAlertRectHeight: Single;
    procedure SetAlertRectHeight(Value: Single);
    function GetAlertRectHeight: Single;
    procedure AnimateArcFinish(Sender: TObject);
    procedure Animate1Finish(Sender: TObject);
    procedure Animate2Finish(Sender: TObject);
    procedure AnimateExitFinish(Sender: TObject);
    function CreateBackgroundRect(AForm: TForm; AColor: TAlphaColor;
      AOpacity: Single; AAlign: TAlignLayout = TAlignLayout.Contents) : TRectangle;
    function CreateAlertRect(AForm: TForm;
      AColor: TAlphaColor = TAlphaColors.White; AWidth: Single = 250;
      AHeight: Single = 150; AAlign: TAlignLayout = TAlignLayout.Center) : TRectangle;
    function CreateAlertText(AParent: TControl; const AMessage: string;
      AFontSize: Single = 14; AFontColor: TAlphaColor = TAlphaColors.Black;
      AVertAlign: TTextAlign = TTextAlign.Leading): TText;
    procedure ConfigureAlertBottonAndTop(const APositionY: Single;
      const AStopValue2: Single;  AAlertType: TAlertType = atBottomToast); overload;
    procedure ConfigureAlertSuccessAndError(AAlertType: TAlertType = atErrorToast); overload;

  public
    constructor Create(AForm: TForm; const AMessage: string;
      AAlertType: TAlertType = atNone;
      AFontColor: TAlphaColor = TAlphaColors.Dimgrey; AColor: TAlphaColor = TAlphaColors.White);
    procedure ShowSuccessToast;
    procedure ShowErrorToast;
    procedure ShowBottomToast;
    procedure ShowTopToast;
    property AlertRectHeight: Single read GetAlertRectHeight write SetAlertRectHeight;
  end;

implementation

{ TAlert }

procedure TAlert.ShowTopToast;
begin
  ConfigureAlertBottonAndTop(-(FAlertRectHeight), -(FAlertRectHeight), atTopToast);
end;

procedure TAlert.SetAlertRectHeight(Value: Single);
begin
  FAlertRectHeight := Value;
end;

procedure TAlert.ShowBottomToast;
begin
  ConfigureAlertBottonAndTop(FForm.ClientHeight	 + FAlertRectHeight , FForm.ClientHeight );
end;

procedure TAlert.ConfigureAlertBottonAndTop(const APositionY: Single;
  const AStopValue2: Single; AAlertType: TAlertType = atBottomToast);
begin
  // Criar e configurar o fundo
  FBackgroundRect := CreateBackgroundRect(FForm, TAlphaColors.Black, 0.1);

  // Criar e configurar o layout
  FLayout := TLayout.Create(FForm);
  FLayout.Align := TAlignLayout.Client;
  FLayout.Size.Height := FForm.ClientHeight;
  FLayout.Size.Width := FForm.ClientWidth;
  FLayout.Size.PlatformDefault := False;
  FLayout.TabOrder := 0;
  FLayout.HitTest := False;
  FLayout.Parent := FForm;

  // Criar e configurar o retângulo do alerta
  FAlertRect := TRectangle.Create(FForm);
  FAlertRect.Fill.Color := FAColor;
  FAlertRect.Align := TAlignLayout.None;
  FAlertRect.Size.PlatformDefault := False;
  FAlertRect.Width := FLayout.Size.Width - 30;
  FAlertRect.Position.X := 15;
  FAlertRect.Height := FAlertRectHeight;
  FAlertRect.Position.Y := APositionY;
  FAlertRect.Stroke.Color := FAlertRect.Fill.Color;
  FAlertRect.YRadius := 10;
  FAlertRect.XRadius := 10;
  FAlertRect.Parent := FForm;

  // Criar e configurar o texto do alerta
  FText := CreateAlertText(FAlertRect, FMessage, 14, FFontColor, TTextAlign.Center);

  // Criar e configurar a animação de entrada
  FAnim1 := TFloatAnimation.Create(FAlertRect);
  FAnim1.Duration := 0.2;
  FAnim1.Interpolation := TInterpolationType.Exponential;
  FAnim1.PropertyName := 'Position.Y';
  FAnim1.StartValue := 0;

  if AAlertType = atTopToast then
     FAnim1.StopValue := 15
  else
     FAnim1.StopValue := FLayout.Height - FAlertRect.Height -15;

  FAnim1.StartFromCurrent := True;
  FAnim1.Parent := FAlertRect;
  FAnim1.Delay := 0.2;
  FAnim1.Start;

  // Criar e configurar a animação de saída
  FAnim2 := TFloatAnimation.Create(FAlertRect);
  FAnim2.Duration := 0.5;
  FAnim2.Interpolation := TInterpolationType.Exponential;
  FAnim2.OnFinish := AnimateExitFinish;
  FAnim2.PropertyName := 'Position.Y';
  FAnim2.StartValue := 0;
  FAnim2.StopValue := AStopValue2;
  FAnim2.StartFromCurrent := True;
  FAnim2.Parent := FAlertRect;
  FAnim2.Delay := 3;
  FAnim2.Start;
end;

procedure TAlert.ConfigureAlertSuccessAndError(AAlertType: TAlertType = atErrorToast);
var
  sLayoutWidth :Single;
  sStopValue :Single;
  sPositionX :Single;
begin

  if AAlertType = atSuccessToast then begin
     sLayoutWidth := 15;
     sStopValue := 15;
     sPositionX := 15;
  end else begin
     sLayoutWidth := 30;
     sStopValue := 30;
     sPositionX := 0;
  end;

  // Fundo
  FBackgroundRect := CreateBackgroundRect(FForm, TAlphaColors.Black, 0.5);

  // Área do Aviso
  FAlertRect := CreateAlertRect(FForm);

  // Círculo
  FLayout := TLayout.Create(FAlertRect);
  FLayout.Align := TAlignLayout.Top;
  FLayout.Size.Height := 100;
  FLayout.Size.PlatformDefault := False;
  FLayout.TabOrder := 0;
  FLayout.Parent := FAlertRect;

  FArc := TArc.Create(FLayout);
  FArc.Align := TAlignLayout.Center;
  FArc.Size.Width := 50;
  FArc.Size.Height := 50;
  FArc.Size.PlatformDefault := False;
  FArc.Stroke.Color := FFontColor;
  FArc.Stroke.Thickness := 5;
  FArc.StartAngle := 200;
  FArc.EndAngle := 1;
  FArc.Parent := FLayout;

  // Animação do Círculo
  FAnimArc := TFloatAnimation.Create(FArc);
  FAnimArc.Duration := 0.5;
  FAnimArc.Interpolation := TInterpolationType.Exponential;
  FAnimArc.OnFinish := AnimateArcFinish;
  FAnimArc.PropertyName := 'EndAngle';
  FAnimArc.StartValue := 0;
  FAnimArc.StopValue := 360;
  FAnimArc.Parent := FArc;
  FAnimArc.Start;

  // Primeira Linha
  FLayout := TLayout.Create(FArc);
  FLayout.Position.X := 8;
  FLayout.Position.Y := 27;
  FLayout.RotationAngle := 45;

  if AAlertType = atErrorToast then
     FLayout.Align := TAlignLayout.Center;

  FLayout.Size.Width := sLayoutWidth;
  FLayout.Size.Height := 7;
  FLayout.Size.PlatformDefault := False;
  FLayout.TabOrder := 0;
  FLayout.Parent := FArc;

  FLineRect := TRectangle.Create(FLayout);
  FLineRect.Fill.Color := FFontColor;
  FLineRect.Size.Width := 0;
  FLineRect.Size.Height := 6;
  FLineRect.Size.PlatformDefault := False;
  FLineRect.Stroke.Color := FFontColor;
  FLineRect.XRadius := 3;
  FLineRect.YRadius := 3;
  FLineRect.Parent := FLayout;

  // Animação da Primeira Linha
  FAnim1 := TFloatAnimation.Create(FLineRect);
  FAnim1.Duration := 0.2;
  FAnim1.Interpolation := TInterpolationType.Exponential;
  FAnim1.OnFinish := Animate1Finish;
  FAnim1.PropertyName := 'Width';
  FAnim1.StartValue := 0;
  FAnim1.StopValue := sStopValue;
  FAnim1.Parent := FLineRect;

  // Segunda Linha
  FLayout := TLayout.Create(FArc);
  FLayout.Position.X := sPositionX;
  FLayout.Position.Y := 24;
  FLayout.RotationAngle := -45;

  if AAlertType = atErrorToast then
     FLayout.Align := TAlignLayout.Center;

  FLayout.Size.Width := 30;
  FLayout.Size.Height := 7;
  FLayout.Size.PlatformDefault := False;
  FLayout.TabOrder := 0;
  FLayout.Parent := FArc;

  FLineRect := TRectangle.Create(FLayout);
  FLineRect.Fill.Color := FFontColor;
  FLineRect.Size.Width := 0;
  FLineRect.Size.Height := 6;
  FLineRect.Size.PlatformDefault := False;
  FLineRect.Stroke.Color := FFontColor;
  FLineRect.XRadius := 3;
  FLineRect.YRadius := 3;
  FLineRect.Parent := FLayout;

  // Animação da Segunda Linha
  FAnim2 := TFloatAnimation.Create(FLineRect);
  FAnim2.Duration := 0.1;
  FAnim2.Interpolation := TInterpolationType.Exponential;
  FAnim2.OnFinish := Animate2Finish;
  FAnim2.PropertyName := 'Width';
  FAnim2.StartValue := 0;
  FAnim2.StopValue := FLayout.Size.Width;
  FAnim2.Parent := FLineRect;

  // Mensagem
  FText := CreateAlertText(FAlertRect, FMessage, 14, FFontColor, TTextAlign.Leading);

  // Animação de Saída
  FAnimExit := TFloatAnimation.Create(FAlertRect);
  FAnimExit.Duration := 2;
  FAnimExit.Interpolation := TInterpolationType.Exponential;
  FAnimExit.OnFinish := AnimateExitFinish;
  FAnimExit.PropertyName := 'Opacity';
  FAnimExit.StartValue := 1;
  FAnimExit.StopValue := 1;
  FAnimExit.Parent := FAlertRect;
end;

constructor TAlert.Create(AForm: TForm; const AMessage: string;
  AAlertType: TAlertType = atNone; AFontColor: TAlphaColor = TAlphaColors.Dimgrey; AColor: TAlphaColor = TAlphaColors.White);
begin
  FForm := AForm;
  FMessage := AMessage;
  FAlertType := AAlertType;
  FFontColor := AFontColor;
  FAColor :=  AColor;

  FAlertRectHeight := 50;

  // Executa o procedimento correspondente ao tipo de alerta
  case FAlertType of
    atSuccessToast: ShowSuccessToast;
    atErrorToast: ShowErrorToast;
    atBottomToast: ShowBottomToast;
    atTopToast: ShowTopToast;
    // Se for atNone, não faz nada
  end;
end;

function TAlert.CreateBackgroundRect(AForm: TForm; AColor: TAlphaColor;
  AOpacity: Single; AAlign: TAlignLayout): TRectangle;
begin
  Result := TRectangle.Create(AForm);
  Result.Fill.Color := AColor;
  Result.Align := AAlign;
  Result.Size.PlatformDefault := False;
  Result.Stroke.Color := Result.Fill.Color;
  Result.Opacity := AOpacity;
  Result.Parent := AForm;
end;

function TAlert.GetAlertRectHeight: Single;
begin
  Result := FAlertRectHeight;
end;

function TAlert.CreateAlertRect(AForm: TForm; AColor: TAlphaColor = TAlphaColors.White; AWidth: Single = 250; AHeight: Single = 150; AAlign: TAlignLayout = TAlignLayout.Center): TRectangle;
begin
  Result := TRectangle.Create(AForm);
  Result.Fill.Color := FAColor;
  Result.Align := AAlign;
  Result.Size.PlatformDefault := False;
  Result.Width := AWidth;
  Result.Height := AHeight;
  Result.Stroke.Color := FAColor;
  Result.YRadius := 10;
  Result.XRadius := 10;
  Result.Parent := AForm;
end;

function TAlert.CreateAlertText(AParent: TControl; const AMessage: string;
  AFontSize: Single; AFontColor: TAlphaColor; AVertAlign: TTextAlign): TText;
begin
  Result := TText.Create(AParent);
  Result.Align := TAlignLayout.Client;
  Result.Size.PlatformDefault := False;
  Result.TextSettings.Font.Size := AFontSize;
  Result.TextSettings.FontColor := AFontColor;
  Result.TextSettings.VertAlign := AVertAlign;
  Result.Text := AMessage;
  Result.Parent := AParent;
end;

procedure TAlert.AnimateArcFinish(Sender: TObject);
begin
  FAnim1.Start;
end;

procedure TAlert.Animate1Finish(Sender: TObject);
begin
  FAnim2.Start;
end;

procedure TAlert.Animate2Finish(Sender: TObject);
begin
  FAnimExit.Start;
end;

procedure TAlert.AnimateExitFinish(Sender: TObject);
begin
  FAlertRect.DisposeOf;
  FBackgroundRect.DisposeOf;
  Free;
end;

procedure TAlert.ShowSuccessToast;
begin
  ConfigureAlertSuccessAndError(TAlertType.atSuccessToast)
end;

procedure TAlert.ShowErrorToast;
begin
  ConfigureAlertSuccessAndError;
end;

end.
