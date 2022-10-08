unit uMain;

interface

uses
  System.DateUtils,System.Generics.Collections,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TfrmMain = class(TForm)
    VertScrollBox1: TVertScrollBox;
    Rectangle1: TRectangle;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FigurinhaClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    ListRectangle : TObjectList<TRectangle>;
    procedure Grade;
    procedure Figurinha(Seq :String; var Grid :TGridPanelLayout);

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses uContainer, FMX.Helpers;

procedure TfrmMain.Button1Click(Sender: TObject);
var T :TTime;
begin
   T := Time;
   Grade;
   //ShowMessage(timetostr(T) +' ' + TimeToStr(Time));

end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  VertScrollBox1.BeginUpdate;
  ListRectangle.Clear;
  VertScrollBox1.EndUpdate;

end;

procedure TfrmMain.Figurinha(Seq: String; var Grid: TGridPanelLayout);
var R :TRectangle;
T :TText;

begin
   Container.tabPaginas.Open('SELECT * FROM Album WHERE Sequencia = '+Seq);
   Container.tabPaginas.First;
   Grid.BeginUpdate;
   while not Container.tabPaginas.eof  do begin
      R := TRectangle.Create(Grid,TAlignLayout.Client);
      R.Stroke.Color := TAlphaColors.white;

      R.Top(1).Left(1).Right(1).Bottom(1);

      R.XRadius := 5;
      R.YRadius := 5;

      T := TText.Create(R,
                        Container.tabPaginas.FieldByName('IDFigurinha').AsString,
                        TTextAlign.Center,
                        TTextAlign.Center,
                        TAlignLayout.Client,
                        12
                        );
      T.Tag :=  Container.tabPaginas.FieldByName('ID').AsInteger;

      if Container.tabPaginas.FieldByName('Quantidade').AsInteger = 0 then
         T.TextSettings.FontColor := TAlphaColors.White
      else
         T.TextSettings.FontColor := TAlphaColors.Null;

      T.OnClick := FigurinhaClick;

      Container.tabPaginas.Next;
   end;

   Grid.EndUpdate;

end;

procedure TfrmMain.FigurinhaClick(Sender: TObject);
begin

   if TText(Sender).TextSettings.FontColor = TAlphaColors.White then begin
      TText(Sender).TextSettings.FontColor := TAlphaColors.Null;
      Container.SQLite.ExecSQL('UPDATE ALbum SET Quantidade = 1 WHERE ID  = '+ IntToStr(TText(Sender).Tag));
   end else begin
      TText(Sender).TextSettings.FontColor := TAlphaColors.White;
      Container.SQLite.ExecSQL('UPDATE ALbum SET Quantidade = 0 WHERE ID  = '+ IntToStr(TText(Sender).Tag));
   end;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
   ListRectangle := TObjectList<TRectangle>.Create;
end;

procedure TfrmMain.Grade;
var
  R :TRectangle;
  T, T2 :TText;
  GridPanelLayout : TGridPanelLayout;

begin
   Container.tabAlbum.Open('SELECT Album.*, Count(*) Total FROM Album GROUP BY Sequencia');
   Container.tabAlbum.First;

   VertScrollBox1.BeginUpdate;
   while not Container.tabAlbum.eof do begin

      R := TRectangle.Create(VertScrollBox1,TAlignLayout.Top);
      ListRectangle.Add(R);
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
      ListRectangle.Add(R);

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
   VertScrollBox1.EndUpdate;
end;

end.
