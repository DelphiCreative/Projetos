program TelegramBot;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.Classes,
  System.SysUtils,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent;

var
  LHTTP: TNetHTTPClient;
  token, url :string;
  JsonStream :TStringStream;

function ObterMensagem(lastID :String): string;
begin
   LHTTP.Get(url+'/getUpdates?timeout=100&offset='+lastID,JsonStream);
   result := JsonStream.DataString;
end;

procedure Bot;
begin

  while True do begin
      Writeln(ObterMensagem('312'));

      Sleep(100)
  end;

end;



begin

  LHTTP := TNetHTTPClient.Create(nil);
  token := '5284986308:AAEOpxeGNSs89WaKz8tgoVqc-P6RAOUWXA4';
  url := 'https://api.telegram.org/bot'+token+'';

  JsonStream := TStringStream.Create;
  try

    bot;


  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  Readln;

end.
