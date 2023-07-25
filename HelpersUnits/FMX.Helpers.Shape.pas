unit FMX.Helpers.Shape;

interface

uses
  System.Classes, System.UITypes, FMX.Effects, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, FMX.Graphics, FMX.Objects, FMX.Types;

type
  TRectangleHelper = class helper for TRectangle
    function SizeH(H: Real): TRectangle; overload;
    function SizeW(H: Real): TRectangle; overload;
    function TextCenter(aText: String; aFontSize: Single; aFontColor: TAlphaColors): TRectangle; overload;
    procedure LoadFromFile(const aFileName: string);
    procedure LoadFromURL(const aFileName: string);
    procedure Sombrear;
    constructor Create(AOwner: TComponent; AlignLayout: TAlignLayout; aColor: TAlphaColor); overload;
    constructor Create(AOwner: TComponent; AlignLayout: TAlignLayout; aHint: string = ''); overload;
  end;

implementation

uses
  System.IOUtils, FMX.Helpers.Text;

{ TRectangleHelper }

constructor TRectangleHelper.Create(AOwner: TComponent;
  AlignLayout: TAlignLayout; aHint: string = '');
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
  Stroke.Color := aColor;
  Sombrear;
end;

procedure TRectangleHelper.LoadFromFile(const aFileName: string);
begin
  Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
  Self.Fill.Kind := TBrushKind.Bitmap;
  Self.Fill.Bitmap.Bitmap.LoadFromFile(aFileName);
end;

procedure TRectangleHelper.LoadFromURL(const aFileName: string);
var
  MyFile: TFileStream;
  NetHTTPClient: TNetHTTPClient;
begin

  Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
  Self.Fill.Kind := TBrushKind.Bitmap;

  TThread.CreateAnonymousThread(
    procedure()
    begin
      MyFile := TFileStream.Create(TPath.Combine(TPath.GetDocumentsPath,
        TPath.GetFileName(aFileName)), fmCreate);

      try
        NetHTTPClient := TNetHTTPClient.Create(nil);
        NetHTTPClient.Get(aFileName, MyFile);
      finally
        NetHTTPClient.DisposeOf;
      end;

      TThread.Synchronize(TThread.CurrentThread,
        procedure()
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

function TRectangleHelper.SizeH(H: Real): TRectangle;
begin
  Self.Height := H;
end;

function TRectangleHelper.SizeW(H: Real): TRectangle;
begin
  Self.Width := H;
end;

procedure TRectangleHelper.Sombrear;
var
  Sombra: TShadowEffect;
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

function TRectangleHelper.TextCenter(aText: String; aFontSize: Single;
aFontColor: TAlphaColors): TRectangle;
begin

end;

end.
