unit Image.Base64;

interface

uses
  jpeg,
  pngimage,
  Vcl.ExtCtrls,
  System.Classes,
  System.NetEncoding;

type
  TImageHelper = class helper for TImage
     function Base64 :AnsiString; overload;
     procedure Base64(str64: String); overload;
  end;

implementation

{ TImageHelper }

function TImageHelper.Base64: AnsiString;
var
   LInput : TStringStream;
   LOutput: TStringStream;
begin
   LInput := TStringStream.Create;
   LOutput := TStringStream.Create;

   try
      Self.Picture.SaveToStream(LInput);
      LInput.Position := 0;
      TNetEncoding.Base64.Encode( LInput, LOutput );
      LOutput.Position := 0;
      Result := LOutput.DataString;
   finally
      LInput.Free;
      LOutput.Free;
   end;
end;

procedure TImageHelper.Base64(str64: String);
var
   LInput : TStringStream;
   LOutput: TStringStream;
begin
   LInput := TStringStream.Create(str64) ;
   LOutput := TStringStream.Create;

   try
      LInput.Position := 0;
      TNetEncoding.Base64.Decode( LInput, LOutput );
      LOutput.Position := 0;
      Self.Picture.LoadFromStream(LOutput);
   finally
      LInput.Free;
      LOutput.Free;
   end;
end;

end.
