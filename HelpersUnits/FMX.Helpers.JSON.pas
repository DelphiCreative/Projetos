unit FMX.Helpers.JSON;

interface

uses System.Classes,System.JSON, System.SysUtils,
 System.Net.URLClient,System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TJSONArrayHelper = class helper for TJSONArray
    function LoadFromURL(const aFileName :string):TJSONArray;
  end;

type
   TJSONObjectHelper = class helper for TJSONObject
     public
      function Value(Name :String) :String;
      function GetBoolean(value :String) : Boolean; overload;
      function GetFloat(value :String) : Extended; overload;
      function GetString(value :String) : String; overload;
      function GetStringData(value :String) : String; overload;
      function GetInteger(value :String) : Integer; overload;
  end;

implementation

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


{ TJSONObjectHelper }

function TJSONObjectHelper.GetBoolean(value: String): Boolean;
begin
   if Self.GetValue(value) <> nil  then
      if Self.GetValue(value).Value <> '' then
         result := StrToBool(Self.GetValue(value).Value)
      else
         result := false
   else
      result := False;
end;

function TJSONObjectHelper.GetFloat(value: String): Extended;
begin
   if Self.GetValue(value) <> nil  then
      if Self.GetValue(value).Value <> '' then
         result := StrToFloat(Self.GetValue(value).Value)
      else
         result :=0
   else
      result := 0;
end;

function TJSONObjectHelper.GetInteger(value: String): Integer;
begin
   if Self.GetValue(value) <> nil  then
      if Self.GetString(value) <> '' then
         result := StrToInt(Self.GetString(value))
      else
         result := 0
   else
      result := 0;

end;

function TJSONObjectHelper.GetString(value: String): String;
begin
   if Self.GetValue(value) <> nil  then
      result := Self.GetValue(value).Value
   else
      result := '';

end;

function TJSONObjectHelper.GetStringData(value: String): String;
begin
   if Self.GetValue(value) <> nil then

      Result := Copy(Self.GetString(value),7,2) + '/' +
                Copy(Self.GetString(value),5,2) + '/' +
              Copy(Self.GetString(value),1,4)
   else
      Result := '';

end;


function TJSONObjectHelper.Value(Name: String): String;
begin
   if Self.GetValue(Name) <> nil then
      Result := Self.GetValue(Name).Value
   else
      Result := '';
end;


end.
