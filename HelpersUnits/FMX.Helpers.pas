unit FMX.Helpers;

interface

uses
   FMX.Objects,System.StrUtils,System.SysUtils, System.Generics.Collections;

type
   TObjectListHelper = class helper for TObjectList<TRectangle>
      procedure Filter(aText: String);
   end;

implementation

{ TObjectListHelper }

procedure TObjectListHelper.Filter(aText: String);
var I :Integer;
begin
   for I := 0 to Self.Count - 1 do begin
      if Trim(aText) <> '' then
         TRectangle(Self[I]).Visible := ContainsStr(AnsiLowerCase(TRectangle(Self[I]).Hint),AnsiLowerCase(aText))
      else
         TRectangle(Self[I]).Visible := True
   end;
end;

end.
