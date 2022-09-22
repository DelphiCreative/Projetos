unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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

procedure TForm1.Button1Click(Sender: TObject);
begin
  GS.IndexStart := 'A1';
  GS.IndexEnd := 'E';
  Memo1.text := GS.Get;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin

  GS.IndexStart := 'A';
  GS.IndexEnd := 'E';

  Gs.ListClear;

  Gs.AddColumn('HBO');
  Gs.AddColumn('Assinatura');
  Gs.AddColumn('R$ 45,90');
  Gs.AddColumn('08/2022');

  GS.Append;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  GS.IndexStart := 'C4';
  GS.IndexEnd := 'C4';

  Gs.AddColumn('R$ 15,90');

  GS.Update;


end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  GS.IndexStart := 'A4';
  GS.IndexEnd := 'E4';

  GS.Clear;



end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  GS := TGoogleSheets.Create(Self);
  Gs.GoogleService('client_secret.json');

  GS.SpreadSheetId := '1GQWCvGbojWHEAZDORTpU69Dk1J4CEUI_QMaTFiVYBMI';
  GS.Sheet := 'Pagina1';


end;

end.
