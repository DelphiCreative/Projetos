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
    procedure CabecalhoClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    ListRectangle : TObjectList<TRectangle>;
    procedure Grade(sql :String = '');
    procedure Figurinha(Seq :String; var Grid :TGridPanelLayout;sql :String = '');

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

  Grade(' AND Quantidade = 0');

end;

procedure TfrmMain.CabecalhoClick(Sender: TObject);
begin
   if TRectangle(Sender).Height = 50 then
      TRectangle(Sender).AnimateFloat('Height',
      (((VertScrollBox1.Width /5) * TRectangle(Sender).Tag) + TRectangle(Sender).Height)
      ,0.3, TAnimationType.In, TInterpolationType.Circular)
   else
      TRectangle(Sender).AnimateFloat('Height',50,0.3, TAnimationType.In, TInterpolationType.Circular)

end;

procedure TfrmMain.Figurinha(Seq :String; var Grid :TGridPanelLayout; sql :String = '');
var
  R :TRectangle;
  T :TText;

begin
   Container.tabPaginas.Open('SELECT * FROM Album WHERE Sequencia = '+Seq + ' '+ sql);
   Container.tabPaginas.First;
   Grid.BeginUpdate;
   while not Container.tabPaginas.eof  do begin
      R := TRectangle.Create(Grid,TAlignLayout.Client,TAlphaColors.White);
      R.Stroke.Color := TAlphaColors.Black;
      R.Sombra;

      R.Top(5).Left(5).Right(5).Bottom(5);

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
      T.TextSettings.FontColor := TAlphaColors.Black;

      if Container.tabPaginas.FieldByName('Quantidade').AsInteger = 0 then
         T.TextSettings.FontColor := TAlphaColors.Black
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
   ImageList := Container.ImageList1;
end;

procedure TfrmMain.Grade(sql :String = '');
var
  R, R2 :TRectangle;
  T, T2 :TText;
  GridPanelLayout : TGridPanelLayout;
  Icone :TImage;
begin
   Container.tabAlbum.Open('SELECT Album.*, '+
                           ' IIF(Time ="",Grupo, Time) Titulo, '+
                           ' Count(*) Total FROM Album WHERE 0=0 '+ sql + ' GROUP BY Sequencia');
   Container.tabAlbum.First;

   VertScrollBox1.BeginUpdate;
   while not Container.tabAlbum.eof do begin

      R := TRectangle.Create(VertScrollBox1,TAlignLayout.Top, TAlphaColors.White);
      //R.Sombra;
      R.Stroke.Color := TAlphaColors.White;
      R.ClipChildren := True;
      R.Padding.Left := 10;
      R.OnClick := CabecalhoClick;

      R.XRadius := 5;
      R.YRadius := 5;

      ListRectangle.Add(R);
      R.Margins.Top := 10;

      Icone := TImage.Create(R,Container.tabAlbum.FieldByName('Titulo').AsString.ToUpper);
      Icone.Position.Y := 0;
      Icone.Position.X := 10;
      Icone.Width := 40;
      Icone.Height := 50;


      T := TText.Create(R,
                        Container.tabAlbum.FieldByName('Titulo').AsString,
                        TTextAlign.Leading,
                        TTextAlign.Center,
                        TAlignLayout.Top,
                        16
                        );
      T.TextSettings.FontColor := TAlphaColors.Black;
      T.Margins.Left := 50;
      T.TextSettings.Font.Style := [TFontStyle.fsBold];

      {if Container.tabAlbum.FieldByName('Total').AsInteger = 20 then begin
        T.Text := Container.tabAlbum.FieldByName('Time').AsString;

        T2 := TText.Create(T,
                          Container.tabAlbum.FieldByName('Grupo').AsString,
                          TTextAlign.Leading,
                          TTextAlign.Center,
                          TAlignLayout.Right);
        T2.TextSettings.FontColor := TAlphaColors.Black;

      end;}

      R2 := TRectangle.Create(R,TAlignLayout.Top);
   
      if Container.tabAlbum.FieldByName('Total').AsInteger < 5 then begin
         R2.Height := (VertScrollBox1.Width/ 5) * 1;
         GridPanelLayout := TGridPanelLayout.Create(R,1,5);
         R.Tag := 1;
      end
      else
      if (Container.tabAlbum.FieldByName('Total').AsInteger > 5) and
         (Container.tabAlbum.FieldByName('Total').AsInteger <= 10)then begin
         R2.Height := (VertScrollBox1.Width/ 5) * 2;
         GridPanelLayout := TGridPanelLayout.Create(R,2,5);
         R.Tag := 2;
      end else
      if (Container.tabAlbum.FieldByName('Total').AsInteger > 10) and
         (Container.tabAlbum.FieldByName('Total').AsInteger <= 15)then begin
         R2.Height := (VertScrollBox1.Width/ 5) * 3;
         GridPanelLayout := TGridPanelLayout.Create(R,3,5);
         R.Tag := 3;
      end else if Container.tabAlbum.FieldByName('Total').AsInteger > 15 then begin
         R2.Height := (VertScrollBox1.Width/ 5) * 4;
         GridPanelLayout := TGridPanelLayout.Create(R,4,5);
         R.Tag := 4;
      end;

      Figurinha( Container.tabAlbum.FieldByName('Sequencia').AsString,GridPanelLayout,sql );

      R2.AddObject(GridPanelLayout);
      Container.tabAlbum.Next;

   end;
   VertScrollBox1.EndUpdate;
end;

end.
