unit FMX.Helpers.TabControl;

interface

uses
 System.UITypes, System.Classes, System.SysUtils, System.Generics.Collections,
 FMX.Objects, FMX.TabControl, FMX.Types, FMX.Layouts;

type
  TTabControlelper = class helper for TTabControl
    procedure TabControlChange(Sender: TObject);
    procedure BotaoClick(Sender :TObject);
    procedure BarButtons(aBarColor : TAlphaColor = TAlphaColors.White;
                         aFocusColor : TAlphaColor = TAlphaColors.Cornflowerblue;
                         aUnFocusColor : TAlphaColor = TAlphaColors.Darkgrey;
                         Align :TAlignLayout = TAlignLayout.Top );
  end;


var
   ListFoco :TObjectList<TRectangle>;
   ListIcone :TObjectList<TImage>;
   ListText : TObjectList<TText>;

   BarColor  : TAlphaColor = TAlphaColors.White;
   FocusColor  : TAlphaColor = TAlphaColors.Cornflowerblue;
   UnFocusColor  : TAlphaColor = TAlphaColors.Darkgrey;

implementation

{ TTabControlelper }

uses FMX.Helpers.Layouts, FMX.Helpers.Image;


procedure TTabControlelper.BarButtons(aBarColor : TAlphaColor = TAlphaColors.White;
   aFocusColor : TAlphaColor = TAlphaColors.Cornflowerblue;
   aUnFocusColor : TAlphaColor = TAlphaColors.Darkgrey; Align :TAlignLayout = TAlignLayout.Top);
var
   I :Integer;
   Bar,BotaoFundo,Foco :TRectangle;
   Icone :TImage;
   Fundo :TLayout;
   Grid :TGridPanelLayout;
   Text :TText;
begin

   BarColor := aBarColor;
   FocusColor := aFocusColor;
   UnFocusColor := aUnFocusColor;

   Bar := TRectangle.Create(TFmxObject(Self.Parent));
   Bar.Align := Align;
   BAr.Height := 55;
   Bar.Fill.Color := BarColor;
   Bar.Stroke.Color := Bar.Fill.Color;
   TFmxObject(Self.Parent).AddObject(Bar);

   Self.TabPosition := TTabPosition.None;
   Self.GotoVisibleTab(0);
   Self.OnChange := TabControlChange;

   Grid := TGridPanelLayout.Create(Bar,1,Self.TabCount);
   Bar.AddObject(Grid);

   for I := 0 to Pred(Self.TabCount) do begin
      BotaoFundo := TRectangle.Create(Grid);
      BotaoFundo.Align := TAlignLayout.Client;
      BotaoFundo.Fill.Color := TAlphaColorRec.Null;
      BotaoFundo.Stroke.Color := BotaoFundo.Fill.Color;
      BotaoFundo.OnClick := BotaoClick;
      BotaoFundo.Tag := I;

      Fundo := TLayout.Create(BotaoFundo);
      Fundo.Align := TAlignLayout.Client;
      BotaoFundo.AddObject(Fundo);

      Icone := TImage.Create(Fundo);
      Icone.ImageByName(IntToStr(I));
      Icone.Height := 30;
      Icone.Tag := I;
      Icone.HitTest := False;
      Icone.Width := Icone.Height;
      Icone.Align := TAlignLayout.Center;
      Fundo.AddObject(Icone);

      ListIcone.Add(Icone);

      Text := TText.Create(BotaoFundo);
      Text.Text := Self.Tabs[I].Text;
      Text.Tag := I;
      Text.HitTest := False;
      Text.Width := 200;
      Text.TextSettings.HorzAlign := TTextAlign.Center;
      Text.Height := 20;
      Text.Align := Align;
      Text.Visible := False;
      ListText.Add(Text);

      Text.TextSettings.Font.Size := 10;
      BotaoFundo.AddObject(Text);

      Foco := TRectangle.Create(BotaoFundo);
      if Align = TAlignLayout.Bottom then
         Foco.Align := TAlignLayout.Top
      else
         Foco.Align := TAlignLayout.Bottom;

      Foco.Stroke.Thickness := 0;
      Foco.Height := 4;
      Foco.Tag := I;
      ListFoco.Add(Foco);

      if I = 0 then begin
        Foco.Fill.Color := FocusColor;
        Text.TextSettings.FontColor :=  Foco.Fill.Color;
      end  else begin
        Foco.Fill.Color := BarColor;
        Text.TextSettings.FontColor := UnFocusColor;
      end;

      Icone.Bitmap.ReplaceOpaqueColor(Text.TextSettings.FontColor);

      Foco.Stroke.Color := BotaoFundo.Fill.Color;
      BotaoFundo.AddObject(Foco);

      Grid.AddObject(BotaoFundo);

   end;

end;

procedure TTabControlelper.BotaoClick(Sender: TObject);
var I :Integer;
begin

   Self.Tag := TRectangle(Sender).Tag ;
   Self.GotoVisibleTab(Self.Tag ,TTabTransition.Slide);
   {ListFoco[Self.Tag].Fill.Color := BarColor;
   ListText[Self.Tag].TextSettings.FontColor := UnFocusColor;
   ListIcone[Self.Tag].Bitmap.ReplaceOpaqueColor(UnFocusColor);

   for I := 0 to ListFoco.Count -1 do  begin
      if ListFoco[I].Tag = TRectangle(Sender).Tag then begin
         ListFoco[I].Fill.Color :=  FocusColor;
         ListText[I].TextSettings.FontColor := ListFoco[I].Fill.Color;
         ListIcone[I].Bitmap.ReplaceOpaqueColor(ListFoco[I].Fill.Color);
         Self.GotoVisibleTab(ListFoco[I].Tag,TTabTransition.Slide);
         Self.Tag := TRectangle(Sender).Tag ;
      end else begin
         ListFoco[I].Fill.Color := BarColor;
         ListText[I].TextSettings.FontColor :=UnFocusColor;
         ListIcone[I].Bitmap.ReplaceOpaqueColor(UnFocusColor);
      end;
   end; }

end;

procedure TTabControlelper.TabControlChange(Sender: TObject);
var I :Integer;
begin

   ListFoco[Self.TabIndex].Fill.Color := BarColor;
   ListText[Self.TabIndex].TextSettings.FontColor := UnFocusColor;
   ListIcone[Self.TabIndex].Bitmap.ReplaceOpaqueColor(UnFocusColor);

   for I := 0 to ListFoco.Count -1 do  begin
      if ListFoco[I].Tag = TabIndex then begin
         ListFoco[I].Fill.Color :=  FocusColor;
         ListText[I].TextSettings.FontColor := ListFoco[I].Fill.Color;
         ListIcone[I].Bitmap.ReplaceOpaqueColor(ListFoco[I].Fill.Color);
      //   Self.GotoVisibleTab(TabIndex,TTabTransition.Slide);
         Self.Tag := TabIndex ;
      end else begin
         ListFoco[I].Fill.Color := BarColor;
         ListText[I].TextSettings.FontColor :=UnFocusColor;
         ListIcone[I].Bitmap.ReplaceOpaqueColor(UnFocusColor);
      end;
   end;


end;

initialization
   ListFoco := TObjectList<TRectangle>.Create;
   ListIcone := TObjectList<TImage>.Create;
   ListText := TObjectList<TText>.Create;



end.
