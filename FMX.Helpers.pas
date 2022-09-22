unit FMX.Helpers;

interface

uses
   System.Types, FMX.Ani,
   System.JSON,FMX.Layouts, FMX.Types, System.SysUtils,FMX.ImgList,
   FMX.TabControl,System.UITypes, System.Generics.Collections,
   FMX.Dialogs, FMX.Objects,FMX.Graphics,System.Classes, FMX.MultiResBitmap,
   System.Net.URLClient,System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TTabControlelper = class helper for TTabControl
    procedure BotaoClick(Sender :TObject);
    procedure BarButtons(Align :TAlignLayout = TAlignLayout.Top);
  end;

type
  TGridPanelLayoutHelper = class helper for TGridPanelLayout
     constructor Create(AOwner :TComponent;const Row, Col  :Integer); overload;
     procedure CreateGrid(const Row,Col:Integer);
  end;

type
  TRectangleHelper = class helper for TRectangle
     procedure LoadFromFile(const aFileName :string);
     procedure LoadFromURL(const aFileName :string);
  end;

type
   TBitmapHelper = class helper for TBitmap
     procedure LoadFromURL(const aFileName :string);
   end;

type
   TImageHelper = class helper for TImage
     procedure ImageByName(Name :String);
     function Size(const ASize :Single) :TImage;
     function AddText(aText:String): TImage;
     procedure LoadFromURL(const aFileName :string);
     procedure GeraQrCode;
   end;

type
  TJSONArrayHelper = class helper for TJSONArray
    function LoadFromURL(const aFileName :string):TJSONArray;
  end;

type
   TlayoutHelper = class helper for TLayout
     procedure Finish(Sender :TObject);
     procedure AnimaCard(Card :TRectangle); Overload;
     procedure AnimaCard(Card :TRectangle; aProperty :String); Overload;
end;


var
  ImageList :TImageList;


implementation

uses System.IOUtils;

var
   ListFoco :TObjectList<TRectangle>;
   ListIcone :TObjectList<TImage>;
   ListText : TObjectList<TText>;
{ TRectangleHelper }

procedure TRectangleHelper.LoadFromFile(const aFileName: string);
begin
   Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
   Self.Fill.Kind := TBrushKind.Bitmap;
   Self.Fill.Bitmap.Bitmap.LoadFromFile(aFileName);
end;

procedure TRectangleHelper.LoadFromURL(const aFileName: string);
var
   MyFile :TFileStream;
   NetHTTPClient : TNetHTTPClient;
begin

   Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
   Self.Fill.Kind := TBrushKind.Bitmap;

   TThread.CreateAnonymousThread(
   procedure()
   begin
      MyFile := TFileStream.Create(
                                 TPath.Combine(
                                 TPath.GetDocumentsPath,
                                 TPath.GetFileName(aFileName))
                                ,fmCreate);

      try
        NetHTTPClient := TNetHTTPClient.Create(nil);
        NetHTTPClient.Get(aFileName,MyFile);
      finally
        NetHTTPClient.DisposeOf;
      end;

      TThread.Synchronize(TThread.CurrentThread,
      procedure ()
      begin
         try
            Self.Fill.Bitmap.Bitmap.LoadFromStream(MyFile);
         except
            Self.Fill.Bitmap.Bitmap := nil;
         end;
         MyFile.DisposeOf;
      end);

   end).Start;

end;

{ TJSONArrayHelper }

function TJSONArrayHelper.LoadFromURL(const aFileName: string): TJSONArray;
var JsonStream :TStringStream;
    NetHTTPClient : TNetHTTPClient;
begin
   try
      JsonStream := TStringStream.Create;
      NetHTTPClient := TNetHTTPClient.Create(nil);

      NetHTTPClient.Get(aFileName,JsonStream);

      if TJSONObject.ParseJSONValue(JsonStream.DataString) is TJSONArray then
         Result := TJSONObject.ParseJSONValue(JsonStream.DataString) as TJSONArray
      else if TJSONObject.ParseJSONValue(JsonStream.DataString) is TJSONObject then
         Result := TJSONObject.ParseJSONValue('['+JsonStream.DataString+']') as TJSONArray;

   finally
      JsonStream.Free;
      NetHTTPClient.Free;

   end;
end;

{ TBitmapHelper }

procedure TBitmapHelper.LoadFromURL(const aFileName: string);
var
   MyFile :TFileStream;
   NetHTTPClient : TNetHTTPClient;
begin

   TThread.CreateAnonymousThread(
   procedure()
   begin
      MyFile := TFileStream.Create(
                                 TPath.Combine(
                                 TPath.GetDocumentsPath,
                                 //TPath.GetFileNameWithoutExtension(aFileName)+
                                 'qrcode.png' )
                                ,fmCreate);

      try
        NetHTTPClient := TNetHTTPClient.Create(nil);
        NetHTTPClient.Get(aFileName,MyFile);
      finally
        NetHTTPClient.DisposeOf;
      end;

      TThread.Synchronize(TThread.CurrentThread,
      procedure ()
      begin
         try
            Self.LoadFromStream(MyFile);
         except
            Self := nil;
         end;
         MyFile.DisposeOf;
      end);

   end).Start;

end;

{ TGridPanelLayoutHelper }

constructor TGridPanelLayoutHelper.Create(AOwner :TComponent;const Row, Col  :Integer);
begin
   inherited Create(AOwner);
   Self.Align := TAlignLayout.Client;
   CreateGrid(Row, Col );


end;

procedure TGridPanelLayoutHelper.CreateGrid(const Row, Col: Integer);
var I :Integer;
begin

   Self.RowCollection.BeginUpdate;
   Self.ColumnCollection.BeginUpdate;

   for I := 0 to Self.ControlsCount -1 do
      Self.Controls[0].Free;

   Self.RowCollection.Clear;
   Self.ColumnCollection.Clear;

   for I := 0 to Row -1 do begin
      Self.RowCollection.Add;
      Self.RowCollection.Items[i];
      Self.RowCollection.Items[I].Value := 100;
      Self.RowCollection.Items[I].SizeStyle := TGridPanelLayout.TSizeStyle.Percent;
   end;


   for I := 0 to Col -1 do begin
      Self.ColumnCollection.Add;
      Self.ColumnCollection.Items[i];
      Self.ColumnCollection.Items[I].Value := 100;
      Self.ColumnCollection.Items[I].SizeStyle := TGridPanelLayout.TSizeStyle.Percent;
   end;

   Self.ColumnCollection.EndUpdate;
   Self.RowCollection.EndUpdate;
end;

{ TImageHelper }

function TImageHelper.AddText(aText: String): TImage ;
begin
   Hint := Hint + atext;
   Result := Self;
end;

procedure TImageHelper.GeraQrCode;
begin
   Bitmap.LoadFromURL(Hint);
end;

procedure TImageHelper.ImageByName(Name: String);
var
   Item : TCustomBitmapItem;
   Size :TSize;
begin
   if ImageList.BitmapItemByName(Name,Item,Size) then
      Self.Bitmap := Item.MultiResBitmap.Bitmaps[1.0]

end;

procedure TImageHelper.LoadFromURL(const aFileName: string);
begin
   Bitmap.LoadFromURL(aFileName);
end;

function TImageHelper.Size(const ASize: Single) :TImage ;
begin
   Hint := 'https://chart.apis.google.com/chart?cht=qr&chs='+ InttoStr(Trunc(aSize))+'x'+InttoStr(Trunc(aSize))+'&';
   Result := Self;
end;

{ TTabControlelper }

procedure TTabControlelper.BarButtons(Align: TAlignLayout);
var
   I :Integer;
   Bar,BotaoFundo,Foco :TRectangle;
   Icone :TImage;
   Fundo :TLayout;
   Grid :TGridPanelLayout;
   Text :TText;
begin
   Bar := TRectangle.Create(TFmxObject(Self.Parent));
   Bar.Align := Align;
   BAr.Height := 60;
   Bar.Fill.Color := TAlphaColorRec.Black;
   Bar.Stroke.Color := Bar.Fill.Color;
   TFmxObject(Self.Parent).AddObject(Bar);

   Self.TabPosition := TTabPosition.None;
   Self.GotoVisibleTab(0);

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
      Icone.Height := 20;
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
        Foco.Fill.Color := TAlphaColorRec.Cornflowerblue;
        Text.TextSettings.FontColor :=  Foco.Fill.Color;
      end  else begin
        Foco.Fill.Color := TAlphaColorRec.Black;
        Text.TextSettings.FontColor :=TAlphaColorRec.Darkgray;
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

  ListFoco[Self.Tag].Fill.Color := TAlphaColorRec.Black;
  ListText[Self.Tag].TextSettings.FontColor := TAlphaColorRec.Darkgray;
  ListIcone[Self.Tag].Bitmap.ReplaceOpaqueColor(TAlphaColorRec.Darkgray);

 // Self.BeginUpdate;
  for I := 0 to ListFoco.Count -1 do  begin
     if ListFoco[I].Tag = TRectangle(Sender).Tag then begin
        ListFoco[I].Fill.Color := TAlphaColorRec.Cornflowerblue;
        ListText[I].TextSettings.FontColor :=ListFoco[I].Fill.Color;
        ListIcone[I].Bitmap.ReplaceOpaqueColor(ListFoco[I].Fill.Color);
        Self.GotoVisibleTab(ListFoco[I].Tag,TTabTransition.Slide);
        Self.Tag :=   TRectangle(Sender).Tag ;
     end else begin
        ListFoco[I].Fill.Color := TAlphaColorRec.Black;
        ListText[I].TextSettings.FontColor := TAlphaColorRec.Darkgray;
        ListIcone[I].Bitmap.ReplaceOpaqueColor(TAlphaColorRec.Darkgray);
     end;
  end;
//  Self.EndUpdate;


end;

{ TlayoutHelper }

procedure TlayoutHelper.AnimaCard(Card: TRectangle);
var FloatHeight, FloatWidth, FloatOpacity, FloatPositionX : TFloatAnimation;
begin
   Card.Align := TAlignLayout.Center;
   Card.Stroke.Thickness := 0;
   Card.Height := 10;
   Card.Width := 10;

   if Self.ControlsCount = 1 then begin
      FloatPositionX := TFloatAnimation.Create(Self.Controls[0]);
      Self.Controls[0].AddObject(FloatPositionX);

      FloatPositionX.Duration := 0.3;
      FloatPositionX.PropertyName := 'Position.X';
      FloatPositionX.StartValue := 0;

      if Tag = 0  then begin
         FloatPositionX.StopValue := Self.Width * -1;
         Tag := 1;
      end else begin
         FloatPositionX.StopValue := Self.Width * 2;
         Tag := 0;
      end;

      FloatPositionX.OnFinish := Finish;

      FloatOpacity := TFloatAnimation.Create(Self.Controls[0]);
      Self.Controls[0].AddObject(FloatOpacity);
      FloatOpacity.Duration := 0.3;
      FloatOpacity.PropertyName := 'Opacity';
      FloatOpacity.StartValue := 1;
      FloatOpacity.StopValue := 0;

      FloatOpacity.Start;
      FloatPositionX.Start;

   end;



   Self.AddObject(Card);

   FloatHeight := TFloatAnimation.Create(Card);
   Card.AddObject(FloatHeight);
   FloatHeight.Duration := 0.3;
   FloatHeight.PropertyName := 'Size.Height';
   FloatHeight.StartValue := 0;
   FloatHeight.StopValue := Self.Height - 10;

   FloatWidth := TFloatAnimation.Create(Card);
   Card.AddObject(FloatWidth);
   FloatWidth.Duration := 0.3;
   FloatWidth.PropertyName := 'Size.Width';
   FloatWidth.StartValue := 0;
   FloatWidth.StopValue := Self.Width - 10;

   FloatOpacity := TFloatAnimation.Create(Card);
   Card.AddObject(FloatOpacity);
   FloatOpacity.Duration := 0.3;
   FloatOpacity.PropertyName := 'Opacity';
   FloatOpacity.StartValue := 0;
   FloatOpacity.StopValue := 1;

   FloatOpacity.Start;
   FloatWidth.Start;
   FloatHeight.Start;

end;

procedure TlayoutHelper.AnimaCard(Card: TRectangle; aProperty: String);
var FloatPositionX, FloatOpacity :TFloatAnimation;
begin
   Card.Height := Self.Height;
   Card.Width := Self.Width - 10;
   Card.Align := TAlignLayout.None;
   Card.Stroke.Thickness := 0;
   Card.Opacity := 0;

   if aProperty = 'left' then
      Card.Position.X  := Self.Width
   else
      Card.Position.X  := Self.Width * -1;

   if Self.ControlsCount = 1 then begin
      FloatPositionX := TFloatAnimation.Create(Self.Controls[0]);
      Self.Controls[0].AddObject(FloatPositionX);

      FloatPositionX.Duration := 0.3;
      FloatPositionX.PropertyName := 'Position.X';
      FloatPositionX.StartValue := 0;

      if aProperty = 'left' then begin
         FloatPositionX.StopValue := Self.Width * -1;
      end else begin
         FloatPositionX.StopValue := Self.Width * 2;
      end;

      FloatPositionX.OnFinish := Finish;

      FloatOpacity := TFloatAnimation.Create(Self.Controls[0]);
      Self.Controls[0].AddObject(FloatOpacity);
      FloatOpacity.Duration := 0.3;
      FloatOpacity.PropertyName := 'Opacity';
      FloatOpacity.StartValue := 1;
      FloatOpacity.StopValue := 0;

      FloatOpacity.Start;
      FloatPositionX.Start;
   end;

   Self.AddObject(Card);

   FloatPositionX := TFloatAnimation.Create(Card);
   Card.AddObject(FloatPositionX);
   FloatPositionX.Duration := 0.3;
   FloatPositionX.PropertyName := 'Position.X';
   FloatPositionX.StartFromCurrent := True;
   FloatPositionX.StopValue := 10;

   FloatOpacity := TFloatAnimation.Create(Card);
   Card.AddObject(FloatOpacity);
   FloatOpacity.Duration := 0.3;
   FloatOpacity.PropertyName := 'Opacity';
   FloatOpacity.StartValue := 0;
   FloatOpacity.StopValue := 1;

   FloatOpacity.Start;

   FloatPositionX.Start;




end;

procedure TlayoutHelper.Finish(Sender: TObject);
begin
   Self.Controls[0].free;
end;

initialization
   ListFoco := TObjectList<TRectangle>.Create;
   ListIcone := TObjectList<TImage>.Create;
   ListText := TObjectList<TText>.Create;

   ImageList := TImageList.Create(nil);


end.
