unit uMain;

interface

uses
  System.DateUtils,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TForm3 = class(TForm)
    VertScrollBox1: TVertScrollBox;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    procedure Rectangle2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure Slot(qtd :integer; gridPanelLayout : TGridPanelLayout);
    procedure GradeGeral;
    procedure Figurinha1Click(Sender :TObject);

  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

uses uContainer, FMX.Helpers.Layouts;


procedure TForm3.Figurinha1Click(Sender: TObject);
begin
   if TText(Sender).TextSettings.FontColor = TAlphaColors.Null then begin
      TText(Sender).TextSettings.FontColor := TAlphaColors.White;
      Container.SQLite.ExecSQL('UPDATE Album SET Quantidade = 0 WHERE ID = '+InttoStr(TText(Sender).Tag));
   end else begin
     TText(Sender).TextSettings.FontColor := TAlphaColors.Null;
       Container.SQLite.ExecSQL('UPDATE Album SET Quantidade = 1 WHERE ID = '+InttoStr(TText(Sender).Tag));
   end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
   GradeGeral;
end;

procedure TForm3.GradeGeral;
var
  R :TRectangle;
  GridPanelLayout1 : TGridPanelLayout;
  T,T2 :TText;
begin


  Container.tabAlbum.Open('SELECT Album.*, Count(*) Total FROM Album GROUP BY Sequencia');
  Container.tabAlbum.First;

  VertScrollBox1.BeginUpdate;

  while not Container.tabAlbum.eof do begin

     R := TRectangle.Create(VertScrollBox1);
     R.Align := TAlignLayout.Top;
     R.Stroke.Color := TAlphaColors.Null;
     R.Fill.Color := TAlphaColors.Null;
     R.Margins.Left := 5;
     R.Margins.Right := 5;

     VertScrollBox1.AddObject(R);


     T := TText.Create(R);
     T.TextSettings.HorzAlign := TTextAlign.Leading;
     T.TextSettings.VertAlign := TTextAlign.Center;

     T.TextSettings.FontColor := TAlphaColors.White;


     T.TextSettings.Font.Size := 16;
     T.TextSettings.Font.Style := [TFontStyle.fsBold];
     T.Align := TAlignLayout.Client;
     R.AddObject(T);


     if Container.tabAlbum.FieldByName('Total').AsInteger = 20 then begin
        T.Text := Container.tabAlbum.FieldByName('Time').AsString ;

        T2 := TText.Create(T);
        T2.TextSettings.HorzAlign := TTextAlign.Trailing;
        T2.TextSettings.VertAlign := TTextAlign.Center;

        T2.TextSettings.FontColor := TAlphaColors.White;
        T2.Text := Container.tabAlbum.FieldByName('Grupo').AsString ;

        T2.TextSettings.Font.Size := 10;
        T2.TextSettings.Font.Style := [TFontStyle.fsBold];
        T2.Align := TAlignLayout.Client;
        T.AddObject(T2);

     end else
        T.Text := Container.tabAlbum.FieldByName('Grupo').AsString;


     R := TRectangle.Create(VertScrollBox1);
     R.Align := TAlignLayout.Top;
     R.Stroke.Color := TAlphaColors.Null;
     R.Fill.Color := TAlphaColors.Null;
     VertScrollBox1.AddObject(R);


     if Container.tabAlbum.FieldByName('Total').AsInteger  = 8 then begin

        R.Height := (VertScrollBox1.Width / 5) * 2;

        GridPanelLayout1 := TGridPanelLayout.Create(R,2,5);


     end else if Container.tabAlbum.FieldByName('Total').AsInteger = 11 then begin

        R.Height := (VertScrollBox1.Width / 5) * 3;

        GridPanelLayout1 := TGridPanelLayout.Create(R,3,5);


     end else if Container.tabAlbum.FieldByName('Total').AsInteger = 20 then begin

        R.Height := (VertScrollBox1.Width / 5) * 4;

        GridPanelLayout1 := TGridPanelLayout.Create(R,4,5);


     end;

     R.AddObject(GridPanelLayout1);
     Slot(Container.tabAlbum.FieldByName('Sequencia').AsInteger,GridPanelLayout1);


     Container.tabAlbum.Next;
  end;
  VertScrollBox1.EndUpdate;
end;

procedure TForm3.Rectangle2Click(Sender: TObject);
begin
  showmessage('test');
end;

procedure TForm3.Slot(qtd: integer; gridPanelLayout: TGridPanelLayout);
var I :Integer;
    Fundo :TRectangle;
    T :TText;
begin

   Container.tabPaginas.Open('SELECT * FROM Album WHERE Sequencia ='+inttostr(qtd) );
   Container.tabPaginas.First;
   gridPanelLayout.BeginUpdate;

   while not Container.tabPaginas.eof do begin
      Fundo := TRectangle.Create(gridPanelLayout);
      Fundo.Align := TAlignLayout.Client;
      Fundo.Stroke.Color := TAlphaColors.White;
      Fundo.Fill.Color := TAlphaColors.Null;
      Fundo.Tag := Container.tabPaginas.FieldByName('ID').AsInteger;
      Fundo.Margins.Top := 2;
      Fundo.Margins.Left := 2;
      Fundo.Margins.Right := 2;
      Fundo.Margins.Bottom := 2;
      Fundo.HitTest := True;
      Fundo.OnClick := FigurinhaClick;

      T := TText.Create(Fundo);
      T.Text := Container.tabPaginas.FieldByName('IDFigurinha').AsString;
      T.TextSettings.HorzAlign := TTextAlign.Center;
      T.TextSettings.VertAlign := TTextAlign.Center;

      if Container.tabPaginas.FieldByName('Quantidade').AsInteger > 0 then
        T.TextSettings.FontColor := TAlphaColors.Null
      else
        T.TextSettings.FontColor := TAlphaColors.White;

      T.Tag := Container.tabPaginas.FieldByName('ID').AsInteger;
      T.TextSettings.Font.Size := 14;
      T.Align := TAlignLayout.Client;
      T.HitTest := True;
      T.OnClick := Figurinha1Click;

      Fundo.AddObject(T);

      gridPanelLayout.AddObject(Fundo);
      Container.tabPaginas.Next;
   end;

   gridPanelLayout.EndUpdate;
end;

end.
