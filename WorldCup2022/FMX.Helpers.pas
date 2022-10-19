unit FMX.Helpers;

interface

uses
  FMX.Effects,
  FMX.Layouts, FMX.Objects,FMX.Types,System.UITypes, System.Classes;

type
  TTextHelper = class helper for TText
    constructor Create(AOwner: TComponent;_text :String;
      _horzAlign :TTextAlign; _vertAlign: TTextAlign; _align:TAlignLayout;
      _size : Single  = 12) overload;
  end;

type
  TRectangleHelper = class helper for TRectangle
    function Top(_size :Single) :TRectangle;
    function Left(_size :Single) :TRectangle;
    function Bottom(_size :Single) :TRectangle;
    function Right(_size :Single) :TRectangle;
    procedure Sombra;
    constructor Create(AOwner: TComponent; _align:TAlignLayout;
     _color :TAlphaColor = TAlphaColors.Null) overload;
  end;

type
  TGridPanelLayoutHelper = class helper for TGridPanelLayout
    constructor Create(AOwner :TComponent;const _row, _col  :Integer); overload;
    procedure CreateGrid(const _row,_col:Integer);
  end;


implementation

{ TTextHelper }

constructor TTextHelper.Create(AOwner: TComponent;_text :String;
      _horzAlign :TTextAlign; _vertAlign: TTextAlign; _align:TAlignLayout;
      _size : Single = 12) ;
begin
   Inherited Create(AOwner);
   TFmxObject(AOwner).AddObject(Self);
   TextSettings.HorzAlign :=  _horzAlign;
   TextSettings.VertAlign :=  _vertAlign;
   Align := _align;
   Text := _text;
   Font.Size := _size;
end;

{ TGridPanelLayoutHelper }

constructor TGridPanelLayoutHelper.Create(AOwner :TComponent;const _row, _col  :Integer);
begin
   inherited Create(AOwner);
   Align := TAlignLayout.Client;
   CreateGrid(_row, _col );
end;

procedure TGridPanelLayoutHelper.CreateGrid(const _row,_col:Integer);
var I :Integer;
begin

   RowCollection.BeginUpdate;
   ColumnCollection.BeginUpdate;

   for I := 0 to ControlsCount -1 do
      Controls[0].Free;

   RowCollection.Clear;
   ColumnCollection.Clear;

   for I := 0 to _row -1 do begin
      RowCollection.Add;
      RowCollection.Items[i];
      RowCollection.Items[I].Value := 100;
      RowCollection.Items[I].SizeStyle := TGridPanelLayout.TSizeStyle.Percent;
   end;

   for I := 0 to _col -1 do begin
      ColumnCollection.Add;
      ColumnCollection.Items[i];
      ColumnCollection.Items[I].Value := 100;
      ColumnCollection.Items[I].SizeStyle := TGridPanelLayout.TSizeStyle.Percent;
   end;

   ColumnCollection.EndUpdate;
   RowCollection.EndUpdate;
end;

{ TRectangleHelper }

function TRectangleHelper.Bottom(_size: Single): TRectangle;
begin
   Margins.Bottom := _size;
   Result := Self;
end;

constructor TRectangleHelper.Create(AOwner: TComponent; _align: TAlignLayout;
  _color: TAlphaColor);
begin
   Inherited Create(AOwner);
   TFmxObject(AOwner).AddObject(Self);
   Align := _align;
   Fill.Color := _color;
   Stroke.Color := _color;
end;

function TRectangleHelper.Left(_size: Single): TRectangle;
begin
   Margins.Left := _size;
   Result := Self;
end;

function TRectangleHelper.Right(_size: Single): TRectangle;
begin
   Margins.Right := _size;
   Result := Self;
end;

procedure TRectangleHelper.Sombra;
var Sombra : TShadowEffect;
begin
   Sombra := TShadowEffect.Create(Self);
   Self.Stroke.Thickness := 0;
   Self.AddObject(Sombra);
   Sombra.Distance := 2;
   Sombra.Direction := 45;
   Sombra.Softness := 0.1;
   Sombra.Opacity := 0.1;
   Sombra.ShadowColor := TAlphaColors.black;

end;

function TRectangleHelper.Top(_size: Single): TRectangle;
begin
   Margins.Top := _size;
   Result := Self;
end;

end.
