unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, System.ImageList,
  FMX.ImgList, FMX.Layouts;

type
  TForm2 = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    TabItem5: TTabItem;
    TabItem6: TTabItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Rectangle1: TRectangle;
    ImageList1: TImageList;
    Layout1: TLayout;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses FMX.Helpers.Layouts;

procedure TForm2.Button1Click(Sender: TObject);
var R :TRectangle;
begin

    R := TRectangle.Create(Self);
    Layout1.AnimaCard(R);
end;

procedure TForm2.Button2Click(Sender: TObject);
var R :TRectangle;
begin

    R := TRectangle.Create(Self);
    Layout1.AnimaCard(R,'left');

end;

procedure TForm2.Button3Click(Sender: TObject);
var R :TRectangle;
begin
    R := TRectangle.Create(Self);
    Layout1.AnimaCard(R,'');
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
//   ImageList := ImageList1;

//   TabControl1.BarButtons(TAlignLayout.Bottom);
end;

end.
