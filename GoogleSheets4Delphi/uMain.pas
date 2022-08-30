unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses GoogleSheets4Delphi_TLB;

var GS : TGoogleSheets;

procedure TForm1.FormCreate(Sender: TObject);
begin
  GS := TGoogleSheets.Create(Self);
  Gs.GoogleService('client_secret.json');

end;

end.
