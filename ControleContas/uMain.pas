unit uMain;

interface

uses
  System.DateUtils,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TForm3 = class(TForm)
    Rectangle1: TRectangle;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    procedure Label1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DataNew, DataOld :TDate;
    procedure ExibeMes(M :String);
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

procedure TForm3.ExibeMes(M: String);
var
   Mes :string;
   R :TRectangle;
begin
   if M  = 'P' then
      DataNew := IncMonth(DataNew,+1)
   else if M  = 'A' then
      DataNew := IncMonth(DataNew,-1)
   else
      DataNew := Date;

   if DataNew <> DataOld then begin
      DataOld := DataNew;
      if YearOf(DataNew) = YearOf(Date) then
        Mes := FormatDateTime('MMMM',DataNew)
      else
        Mes := FormatDateTime('MMM/yyyy',DataNew);

      R := TRectangle.Create(Self);
      R.Fill.Color := TAlphaColors.Blue;
      R.Stroke.Color := TAlphaColors.Blue;
      R.Align := TAlignLayout.top;
      Self.AddObject(R);

      Label1.Text := Mes
   end;

end;

procedure TForm3.FormShow(Sender: TObject);
begin
   ExibeMes('');
end;

procedure TForm3.Label1Click(Sender: TObject);
begin
   ExibeMes('');
end;

procedure TForm3.SpeedButton1Click(Sender: TObject);
begin
   ExibeMes('A');
end;

procedure TForm3.SpeedButton2Click(Sender: TObject);
begin
   ExibeMes('P');
end;

end.
