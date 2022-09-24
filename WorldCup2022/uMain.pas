unit uMain;

interface

uses
  System.DateUtils,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
   TTextHelper = class helper for TText
      constructor Create(AOwner: TComponent;_text :String;
      _horzAlign :TTextAlign; _vertAlign: TTextAlign  ) overload;
   end;

type
  TfrmMain = class(TForm)
    VertScrollBox1: TVertScrollBox;
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure Grade;

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses uContainer;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
   Grade;
end;

procedure TfrmMain.Grade;
var
  R :TRectangle;
  T, T2 :TText;


begin
   Container.tabAlbum.Open('SELECT Album.*, Count(*) Total FROM Album GROUP BY Sequencia');
   Container.tabAlbum.First;

   while not Container.tabAlbum.eof do begin

      R := TRectangle.Create(VertScrollBox1);
      VertScrollBox1.AddObject(R);
      R.Align := TAlignLayout.Top;
      R.Fill.Color := TAlphaColors.White;
      R.Stroke.Color := TAlphaColors.White;
      R.Margins.Top := 10;


      T := TText.Create(R,Container.tabAlbum.FieldByName('Grupo').AsString);

      T.TextSettings.HorzAlign := TTextAlign.Leading;
      T.TextSettings.VertAlign := TTextAlign.Center;
      T.TextSettings.Font.Size := 16;
      T.TextSettings.Font.Style := [TFontStyle.fsBold];
      T.Align := TAlignLayout.Client;

      if Container.tabAlbum.FieldByName('Total').AsInteger = 20 then begin
        T.Text := Container.tabAlbum.FieldByName('Time').AsString;

        T2 := TText.Create(R);
        R.AddObject(T2);
        T2.TextSettings.HorzAlign := TTextAlign.Leading;
        T2.TextSettings.VertAlign := TTextAlign.Center;
        T2.TextSettings.Font.Size := 12;
        T2.Align := TAlignLayout.Right;
        T2.Text := Container.tabAlbum.FieldByName('Grupo').AsString;


      end else
         T.Text := Container.tabAlbum.FieldByName('Grupo').AsString;


      Container.tabAlbum.Next;

   end;

end;

{ TTextHelper }

constructor TTextHelper.Create(AOwner: TComponent;_text :String;
      _horzAlign :TTextAlign; _vertAlign: TTextAlign ) ;
begin
   Inherited Create(AOwner);
   TFmxObject(AOwner).AddObject(Self);
   TextSettings.HorzAlign :=  _horzAlign;
   TextSettings.VertAlign :=  _vertAlign;
   Text := _text;

end;

end.
