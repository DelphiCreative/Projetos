unit FMX.Helpers.Rectangle;

interface

uses
   System.JSON,
   System.Classes, System.UITypes, FMX.Effects,
   System.Net.URLClient,System.Net.HttpClient, System.Net.HttpClientComponent,
   FMX.Graphics, FMX.Objects, FMX.Types;

type
  TRectangleHelper = class helper for TRectangle

     function Top(ASize :Single) :TRectangle;
     function Left(ASize :Single) :TRectangle;
     function Bottom(ASize :Single) :TRectangle;
     function Right(ASize :Single) :TRectangle;
     function MarginAll(ASize :Single):TRectangle; overload;
     function PaddingAll(ASize :Single):TRectangle; overload;
     function SizeH(H :Real) :TRectangle; overload;
     function SizeW(H :Real) :TRectangle; overload;
     function PositionXY(APositionX,APositionY :Single) :TRectangle;

     procedure LoadFromFile(const aFileName :string);
     procedure LoadFromURL(const aFileName :string);
     procedure Color(aColor :TAlphaColor);
     procedure Sombrear;


     constructor Create(AOwner :TComponent; AlignLayout : TAlignLayout;
       aColor :TAlphaColor) overload;

     constructor Create(AOwner :TComponent; AlignLayout : TAlignLayout;
       aHint : string = '' ) overload;

     constructor Create(AOwner :TComponent; aColor :TAlphaColor) overload;

     constructor Create(AOwner :TComponent; aText :String;
        aFontSize:Single; aFontColor,ABackgroundColor :TAlphaColor) overload;

  end;

implementation

uses

System.IOUtils, FMX.Helpers.Text, FMX.Helpers.Image;
{ TRectangleHelper }

constructor TRectangleHelper.Create(AOwner: TComponent;
  AlignLayout: TAlignLayout; aHint : string = '');
begin
   inherited Create(AOwner);
   Align := AlignLayout;
   Hint := aHint;
   TFMXObject(AOwner).AddObject(Self);
   Padding.Top := 5;
   Padding.Left := 5;
   Padding.Right := 5;
   Padding.Bottom := 5;
   Size.PlatformDefault := False;
   Fill.Color := TAlphaColorRec.White;
   Stroke.Color := TAlphaColorRec.White;
   HitTest := False;
end;

constructor TRectangleHelper.Create(AOwner: TComponent;
  AlignLayout: TAlignLayout; aColor: TAlphaColor);
begin
   inherited Create(AOwner);
   Align := AlignLayout;
   TFMXObject(AOwner).AddObject(Self);
   Padding.Top := 2;
   Padding.Left := 2;
   Padding.Right := 2;
   Padding.Bottom := 2;
   Size.PlatformDefault := False;
   Fill.Color := aColor;
   Stroke.Color :=aColor;
   Sombrear;
end;

constructor TRectangleHelper.Create(AOwner: TComponent; aColor: TAlphaColor);
begin
   inherited Create(AOwner);
   TFMXObject(AOwner).AddObject(Self);
   Size.PlatformDefault := False;
   Color(aColor);
   HitTest := False;
end;

function TRectangleHelper.Bottom(ASize: Single): TRectangle;
begin
   Margins.Bottom := ASize;
   Result := Self;
end;

procedure TRectangleHelper.Color(aColor: TAlphaColor);
begin
   Fill.Color := aColor;
   Stroke.Color := aColor;
end;

constructor TRectangleHelper.Create(AOwner :TComponent; aText :String;
  aFontSize:Single; aFontColor,ABackgroundColor :TAlphaColor) overload;
var T :TText;
    Icone :TImage;
begin
  inherited Create(AOwner);
  TFMXObject(AOwner).AddObject(Self);
  Fill.Color := ABackgroundColor;
  Stroke.Color := Fill.Color;

  T := TText.Create(Self);
  T.Text := aText;
  T.Align := TAlignLayout.Center;
  T.TextSettings.FontColor := aFontColor;
  T.TextSettings.Font.Size := aFontSize ;
  T.Width := 1000;
  T.AutoSize := True;
  //  R.AddObject(T);
  Height := T.Height + 50;
  Width := T.Width + 50;

  Icone := TImage.Create(Self,aText,
                         TAlignLayout.Client);
  Icone.WrapMode := TImageWrapMode.Center;

  AddObject(T);
  AddObject(Icone);

end;

function TRectangleHelper.Left(ASize: Single): TRectangle;
begin
   Margins.Left := ASize;
   Result := Self;
end;

procedure TRectangleHelper.LoadFromFile(const aFileName: string);
begin
   Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
   Self.Fill.Kind := TBrushKind.Bitmap;
   try
      Self.Fill.Bitmap.Bitmap.LoadFromFile(aFileName);
   except
       Self.Fill.Bitmap.Bitmap := nil;
   end;
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

function TRectangleHelper.MarginAll(ASize: Single): TRectangle;
begin
   Right(ASize).Top(ASize).Left(ASize).Right(ASize);
   Result := Self;
end;

function TRectangleHelper.PaddingAll(ASize: Single): TRectangle;
begin
   Padding.Top := ASize;
   Padding.Left := ASize;
   Padding.Right := ASize;
   Padding.Bottom := ASize;
   Result := Self;
end;

function TRectangleHelper.PositionXY(APositionX,
  APositionY: Single): TRectangle;
begin
   Position.X := APositionX;
   Position.Y := APositionY;
   Result := Self;
end;

function TRectangleHelper.Right(ASize: Single): TRectangle;
begin
   Margins.Right := ASize;
   Result := Self;
end;

function TRectangleHelper.SizeH(H: Real): TRectangle;
begin
   Self.Height := H;
   Result := Self;
end;

function TRectangleHelper.SizeW(H: Real): TRectangle;
begin
   Self.Width := H;
   Result := Self;
end;

procedure TRectangleHelper.Sombrear;
var Sombra: TShadowEffect;
begin
   Sombra := TShadowEffect.Create(Self);
   Self.Stroke.Thickness := 0;
   Self.AddObject(Sombra);
   Sombra.Distance := 2;
   Sombra.Direction := 45;
   Sombra.Softness := 0.1;
   Sombra.Opacity := 0.1;
   Sombra.ShadowColor := TAlphaColorRec.Black;
end;

function TRectangleHelper.Top(ASize: Single): TRectangle;
begin
   Margins.Top := ASize;
   Result := Self;
end;

end.
