unit FMX.Slides;

interface

uses
   FMX.Gestures,
   FMX.Ani,FMX.Layouts,FMX.Types,System.UITypes,  FMX.Graphics,
   FMX.TabControl, FMX.Objects,FMX.Effects,FMX.StdCtrls,Data.DB,
   System.SysUtils;

type
   TLayoutHelper = class helper for TLayout
      procedure Slide(ADataSet : TDataSet; Duracao : Real = 3);
      procedure ProximoClick(Sender: TObject);
      procedure AnteriorClick(Sender: TObject);
      procedure AnimaFinish(Sender: TObject);
      procedure Proximo;
      procedure Anterior;

      procedure Gestos;
      procedure LayoutGesture(Sender :TObject;
        const EventInfo : TGestureEventInfo; var Handled : Boolean);

end;

implementation

var
  GestureManager : TGestureManager;

{ TLayoutHelper }

procedure TLayoutHelper.AnimaFinish(Sender: TObject);
begin

   if (TTabControl(FindComponent(Self.Name+'TabSlide')).TabCount -1) <>
      (TTabControl(FindComponent(Self.Name+'TabSlide')).TabIndex) then
       TTabControl(FindComponent(Self.Name+'TabSlide')).Next
   else
      TTabControl(FindComponent(Self.Name+'TabSlide')).GotoVisibleTab(0, TTabTransition.Slide,TTabTransitionDirection.Reversed );
   TFloatAnimation(Sender).Start;
end;

procedure TLayoutHelper.Anterior;
begin
   TTabControl(FindComponent(Self.Name+'TabSlide')).Previous;
end;

procedure TLayoutHelper.AnteriorClick(Sender: TObject);
begin
   Anterior;
end;

procedure TLayoutHelper.Gestos;
begin
   GestureManager := TGestureManager.Create(Self);
   GestureManager.Sensitivity := 10;
   Self.Touch.GestureManager := GestureManager;
   Self.Touch.StandardGestures := [TStandardGesture.sgLeft,TStandardGesture.sgRight];
   Self.OnGesture := LayoutGesture;
end;

procedure TLayoutHelper.LayoutGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
   if EventInfo.GestureID = sgiLeft then
      Proximo
   else if EventInfo.GestureID = sgiRight then
      Anterior;

end;

procedure TLayoutHelper.Proximo;
begin
  if (TTabControl(FindComponent(Self.Name+'TabSlide')).TabCount -1) <>
      (TTabControl(FindComponent(Self.Name+'TabSlide')).TabIndex) then
       TTabControl(FindComponent(Self.Name+'TabSlide')).Next
  else
      TTabControl(FindComponent(Self.Name+'TabSlide')).GotoVisibleTab(0);

end;

procedure TLayoutHelper.ProximoClick(Sender: TObject);
begin
   Proximo;
end;

procedure TLayoutHelper.Slide(ADataSet : TDataSet; Duracao : Real = 3);
var
   TabSlide : TTabControl;
   TabItem :TTabItem;
   Fundo :TRectangle;
   Proximo, Anterior :TSpeedButton;
   Sombra : TShadowEffect;
   Animacao :TFloatAnimation;
begin

   ADataSet.Open;
   Self.BeginUpdate;
   Self.HitTest := True;

   Gestos;

   TabSlide := TTabControl.Create(Self);
   Self.AddObject(TabSlide);
   TabSlide.HitTest := False;
   TabSlide.Align := TAlignLayout.Client;
   TabSlide.TabPosition := TTabPosition.None;
   TabSlide.Name := Self.Name+'TabSlide';

   ADataSet.First;
   while not ADataSet.Eof do begin
      TabItem := TTabItem.Create(TabSlide);
      TabItem.Text := 'Slide '+ inttostr(ADataSet.RecNo);

      Fundo := TRectangle.Create(TabItem);
      TabItem.AddObject(Fundo);
      Fundo.Fill.Color := TAlphaColorRec.White;
      Fundo.Stroke.Color := TAlphaColorRec.White;
      Fundo.Align := TAlignLayout.Client;
      Fundo.Margins.Top := 10;
      Fundo.Margins.Left := 10;
      Fundo.Margins.Right := 10;
      Fundo.Margins.Bottom := 10;
      Fundo.HitTest := False;

      Fundo.Fill.Bitmap.Bitmap.LoadFromFile(ADataSet.FieldByName('Imagem').AsString);
      Fundo.Fill.Kind := TBrushKind.Bitmap;
      Fundo.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;

      Fundo.YRadius := 5;
      Fundo.XRadius := 5;

      Sombra := TShadowEffect.Create(Fundo);
      Fundo.AddObject(Sombra);
      Sombra.Distance := 0.1;
      Sombra.Opacity := 0.1;


      TabSlide.AddObject(TabItem);
      ADataSet.Next;
   end;


   Proximo := TSpeedButton.Create(Self);
   Self.AddObject(Proximo);
   Proximo.BringToFront;
   Proximo.Text := '>';
   Proximo.Size.Height := 25;
   Proximo.Size.Width := 25;
   Proximo.Position.X := Self.Width - 30;
   Proximo.Position.Y := (Self.Height/2)- 15;
   Proximo.OnClick := ProximoClick;


   Anterior := TSpeedButton.Create(Self);
   Self.AddObject(Anterior);
   Anterior.BringToFront;
   Anterior.Text := '<';
   Anterior.Size.Height := 25;
   Anterior.Size.Width := 25;
   Anterior.Position.X := 5;
   Anterior.Position.Y := (Self.Height/2)- 15;
   Anterior.OnClick := AnteriorClick;


   Animacao := TFloatAnimation.Create(TabSlide);
   TabSlide.AddObject(Animacao);
   Animacao.Duration := Duracao;
   Animacao.PropertyName := 'Opacity';
   Animacao.StartValue := 1;
   Animacao.StopValue := 1;
   Animacao.OnFinish := AnimaFinish;
   Animacao.Start;

   Self.EndUpdate;


end;

end.
