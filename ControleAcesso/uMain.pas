unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
   Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    edtID: TEdit;
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Status(id :String):String;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
   Showmessage(Status(edtID.Text));
end;

function TForm2.Status(id: String): String;
var
   Net : TNetHTTPClient;
   Str : TStringStream;
begin
   try
     Net := TNetHTTPClient.Create(nil);
     Str := TStringStream.Create;

     Net.Get('https://validador-5fa17-default-rtdb.firebaseio.com/clientes/'
            +id+'.json',
            Str);

      Result := Str.DataString;
   finally
     Net.Free;
     Str.Free;
   end;


end;

end.
