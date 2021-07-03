unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects,
  FMX.Objects, FMX.Edit, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm2 = class(TForm)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    ShadowEffect1: TShadowEffect;
    Rectangle3: TRectangle;
    ShadowEffect2: TShadowEffect;
    Label1: TLabel;
    Label2: TLabel;
    Layout1: TLayout;
    Rectangle4: TRectangle;
    Image1: TImage;
    Edit1: TEdit;
    Line1: TLine;
    Edit2: TEdit;
    Line2: TLine;
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses FMX.Helpers;

procedure TForm2.Label2Click(Sender: TObject);
begin
  Image1.Size(300)
        .AddText(Edit1.Text)
        .AddText(Edit2.Text).GeraQrCode;


end;

end.
