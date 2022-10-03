unit uMain;

interface

uses
  System.DateUtils,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TfrmMain = class(TForm)
    VertScrollBox1: TVertScrollBox;
    Rectangle1: TRectangle;
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure Grade;
    procedure Figurinha(Seq :String; var Grid :TGridPanelLayout);

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses uContainer, FMX.Helpers;

procedure TfrmMain.Figurinha(Seq: String; var Grid: TGridPanelLayout);
var R :TRectangle;
T :TText;

begin
   Container.tabPaginas.Open('SELECT * FROM Album WHERE Sequencia = '+Seq);
   Container.tabPaginas.First;

   while not Container.tabPaginas.eof  do begin
      R := TRectangle.Create(Grid,TAlignLayout.Client);
      R.Stroke.Color := TAlphaColors.white;
      R.Margins.Top := 1;
      R.Margins.Left := 1;
      R.Margins.Right := 1;
      R.Margins.Bottom := 1;

      T := TText.Create(R,
                        Container.tabPaginas.FieldByName('IDFigurinha').AsString,
                        TTextAlign.Center,
                        TTextAlign.Center,
                        TAlignLayout.Client,
                        12
                        );
      T.TextSettings.FontColor := TAlphaColors.White;

      Container.tabPaginas.Next;
   end;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
   Grade;
end;

procedure TfrmMain.Grade;
var
  R :TRectangle;
  T, T2 :TText;
  GridPanelLayout : TGridPanelLayout;

begin
   Container.tabAlbum.Open('SELECT Album.*, Count(*) Total FROM Album GROUP BY Sequencia');
   Container.tabAlbum.First;

   while not Container.tabAlbum.eof do begin

      R := TRectangle.Create(VertScrollBox1,TAlignLayout.Top);

      R.Margins.Top := 10;

      T := TText.Create(R,
                        Container.tabAlbum.FieldByName('Grupo').AsString,
                        TTextAlign.Leading,
                        TTextAlign.Center,
                        TAlignLayout.Client,
                        16
                        );
      T.TextSettings.FontColor := TAlphaColors.White;

      T.TextSettings.Font.Style := [TFontStyle.fsBold];

      if Container.tabAlbum.FieldByName('Total').AsInteger = 20 then begin
        T.Text := Container.tabAlbum.FieldByName('Time').AsString;

        T2 := TText.Create(R,
                        Container.tabAlbum.FieldByName('Grupo').AsString,
                        TTextAlign.Leading,
                        TTextAlign.Center,
                        TAlignLayout.Right);
        T2.TextSettings.FontColor := TAlphaColors.White;

      end;

      R := TRectangle.Create(VertScrollBox1,TAlignLayout.Top);

      if Container.tabAlbum.FieldByName('Total').AsInteger = 8 then begin
         R.Height := (VertScrollBox1.Width/ 5) * 2;
         GridPanelLayout := TGridPanelLayout.Create(R,2,5);

      end else if Container.tabAlbum.FieldByName('Total').AsInteger = 11 then begin
         R.Height := (VertScrollBox1.Width/ 5) * 3;
         GridPanelLayout := TGridPanelLayout.Create(R,3,5);

      end else if Container.tabAlbum.FieldByName('Total').AsInteger = 20 then begin
         R.Height := (VertScrollBox1.Width/ 5) * 4;
         GridPanelLayout := TGridPanelLayout.Create(R,4,5);
      end;

      Figurinha( Container.tabAlbum.FieldByName('Sequencia').AsString,GridPanelLayout);

      R.AddObject(GridPanelLayout);
      Container.tabAlbum.Next;

   end;

end;



end.
