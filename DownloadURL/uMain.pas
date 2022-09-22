unit uMain;

interface

uses
  System.JSON, RegularExpressions,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, FMX.Layouts,
  FMX.ListBox;

type
  TForm2 = class(TForm)
    Rectangle1: TRectangle;
    Button1: TButton;
    ListBox1: TListBox;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    JSON :TJSONArray;

    function URL(aURL,aSep : String) : String;
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses FMX.Helpers;

procedure TForm2.Button1Click(Sender: TObject);
var
   I :INteger;
   Members :TJSONObject;
   L : TListBoxItem;
begin

   JSON :=  JSON.LoadFromURL('https://api.github.com/orgs/adobe/members');
//   JSON :=  JSON.LoadFromURL('https://api.github.com/users/3ch023');
   for  I := 0 to JSON.Count - 1 do begin

      Members := TJSONObject.ParseJSONValue(JSON.Items[I].ToJSON) as TJSONObject;

      L := TListBoxItem.Create(ListBox1);
      L.StyleLookup := 'listboxitemnodetail';
      L.Height := 60;
      L.ItemData.Text := Members.GetValue('login').Value;
      L.ItemData.Bitmap.LoadFromURL(URL(Members.GetValue('avatar_url').Value,'?'));

      ListBox1.AddObject(L);

   end;

   abort;
   Rectangle1.LoadFromURL('https://diegocataneo.com.br/costelao-bovino.jpg');

end;

function TForm2.URL(aURL, aSep: String): String;
var S : TArray<String> ;
begin
   aURL := aURL.Replace(aSep,' ');
   s := TRegEx.Split(aURL,' ');
   Result := S[0]

end;

end.
