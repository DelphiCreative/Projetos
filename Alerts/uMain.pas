unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Effects, FMX.Layouts,
  FMX.Colors, FMX.ListBox;

type
  TAlertType = (atPositive, atNegative, atMessage);

type
  TForm1 = class(TForm)
    Rectangle1: TRectangle;
    SpeedButton1: TSpeedButton;
    ShadowEffect1: TShadowEffect;
    Text1: TText;
    Rectangle2: TRectangle;
    SpeedButton2: TSpeedButton;
    ShadowEffect2: TShadowEffect;
    Text2: TText;
    Rectangle3: TRectangle;
    SpeedButton3: TSpeedButton;
    ShadowEffect3: TShadowEffect;
    Text3: TText;
    Rectangle4: TRectangle;
    SpeedButton4: TSpeedButton;
    ShadowEffect4: TShadowEffect;
    Text4: TText;
    Layout1: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    ComboColorBox1: TComboColorBox;
    ComboColorBox2: TComboColorBox;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses FMX.Alerts;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
   TAlert.Create(Self, 'Sucesso!!!', atSuccessToast, ComboColorBox1.Color, ComboColorBox2.Color );
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
   TAlert.Create(Self, 'Erro!!!', atErrorToast, ComboColorBox1.Color, ComboColorBox2.Color );
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  var Alert := TAlert.Create(Self, 'Mensagem atBottomToast', atNone, ComboColorBox1.Color, ComboColorBox2.Color );
  Alert.AlertRectHeight := 80;
  Alert.ShowBottomToast;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
   TAlert.Create(Self, 'Mensagem atTopToast', atTopToast, ComboColorBox1.Color, ComboColorBox2.Color );
end;

end.
