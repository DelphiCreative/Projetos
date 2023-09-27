unit Helpers.Utils;

interface

uses
  System.SysUtils, System.StrUtils, System.JSON;

type
  TStringHelper = record helper for string
    function FindJsonValue(const Key: string): string;
    function JsonFormat :string;
  end;

implementation

function TStringHelper.FindJsonValue(const Key: string): string;
var
  StartPos, EndPos: Integer;
  KeyStartPos, KeyEndPos: Integer;

  jsonObject: TJSONObject;
  resultObject: TJSONObject;
begin
  Result := '';

  try
    jsonObject := TJSONObject.ParseJSONValue(Self) as TJSONObject;

    if Assigned(jsonObject) then
    begin
      resultObject := jsonObject.GetValue('result') as TJSONObject;
      if Assigned(resultObject) then
      begin
        Result := resultObject.GetValue(Key).Value;
      end;
    end;
  finally
    jsonObject.Free;
  end;





//  StartPos := Pos('"' + Key + '":', Self);
//  if StartPos = 0 then
//    Exit('');
//
//  KeyStartPos := StartPos + Length(Key) + 3; // Length(Key) + 3 to skip ": and the opening quote "
//  KeyEndPos := PosEx('"', Self, KeyStartPos);
//
//  if KeyEndPos = 0 then
//    Exit('');
//
//  StartPos := KeyEndPos + 1;
//  EndPos := PosEx('"', Self, StartPos);
//
//  if EndPos = 0 then
//    Exit('');
//
//  Result := Copy(Self, StartPos, EndPos - StartPos);
end;

function TStringHelper.JsonFormat :string;
var
   jsonObject: TJSONObject;
begin
   try
      try
        jsonObject := TJSONObject.ParseJSONValue(Self) as TJSONObject;
        Result := jsonObject.Format;
      except
        Result := Self;
      end;
   finally
     jsonObject.Free;
   end;
end;

end.
