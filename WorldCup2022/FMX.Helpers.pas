unit FMX.Helpers;

interface

uses
  FMX.Layouts, FMX.Objects,FMX.Types, System.Classes;

type
   TTextHelper = class helper for TText
    constructor Create(AOwner: TComponent;_text :String;
      _horzAlign :TTextAlign; _vertAlign: TTextAlign; _align:TAlignLayout;
      _size : Single  = 12) overload;
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

end.
