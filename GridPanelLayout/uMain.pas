unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Objects;

type
  TForm2 = class(TForm)
    Button1: TButton;
    SpinCol: TSpinBox;
    SpinRow: TSpinBox;
    Selection1: TSelection;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    GridPanelLayout1 : TGridPanelLayout;
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses FMX.Helpers;

procedure TForm2.Button1Click(Sender: TObject);
var I :Integer;
    Button : TSpeedButton;
begin

   if GridPanelLayout1 <> nil then
      GridPanelLayout1.Free;

   GridPanelLayout1 := TGridPanelLayout.Create(Selection1,Trunc(SpinRow.Value), Trunc(SpinCol.Value));
   Selection1.AddObject(GridPanelLayout1);

   for I := 1 to Trunc(SpinRow.Value * SpinCol.Value)  do begin
      Button := TSpeedButton.Create(GridPanelLayout1);
      GridPanelLayout1.AddObject(Button);
      Button.Text := InttoStr(I);
      Button.Align := TAlignLayout.Client;
   end;

end;

end.
