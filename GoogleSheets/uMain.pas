unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFDMemTableHelper = class helper for TFDMemTable
    procedure LoadFromText(text :string);
  end;

type
  TDBGridHelper = class helper for TDBGrid
     procedure AutoSize;
  end;



type
  TForm1 = class(TForm)
    edtSpreadSheetId: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtSheet: TEdit;
    Label3: TLabel;
    edtStart: TEdit;
    Label4: TLabel;
    edtEnd: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label5: TLabel;
    Edit5: TEdit;
    edtResult: TMemo;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button5: TButton;
    Edit1: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Edit2: TEdit;
    Label8: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddColumns;
    procedure Propriedades;
    procedure Get;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses GoogleSheets4Delphi_TLB;

var GS :TGoogleSheets;

procedure TForm1.Button1Click(Sender: TObject);
begin
   Get;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   Propriedades;
   AddColumns;
   GS.Append();
   Get;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   Propriedades;
   AddColumns;
   GS.Update();
   Get;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
   Propriedades;
   GS.Clear();
   Get;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
   try
      GS := TGoogleSheets.Create(Self);
      GS.GoogleService('C:\Users\diego\source\repos\ConsoleApp5\consoleApp5\credentials.json');

   finally
      Button1.Enabled := True;
      Button2.Enabled := True;
      Button3.Enabled := True;
      Button4.Enabled := True;
   end;
end;

procedure TForm1.Get;
begin
   Propriedades;

   GS.IndexStart := edtStart.Text;
   GS.IndexEnd := edtEnd.Text;

   edtResult.Text := GS.Get();

   if edtResult.Text <> 'Verifique seus dados.' then
      FDMemTable1.LoadFromText(edtResult.Text)
   else
      FDMemTable1.Close;

   DBGrid1.AutoSize;
end;

procedure TForm1.AddColumns;
var
  List : TStringList;
  SplitList :TArray<string>;
  I :Integer;
begin
   try
     List := TStringList.Create;
     List.Text := Edit5.Text;

     SplitList := List.Strings[0].Split([Char(124)]);
     Gs.ListClear;
     for I := 0 to Pred(Length(SplitList)) do
           Gs.AddColumn(SplitList[I]);

      finally
        List.Free;
   end;

end;

procedure TForm1.Propriedades;
begin
  GS.SpreadSheetId := edtSpreadSheetId.Text;

  GS.Sheet := edtSheet.Text;
  GS.IndexStart := Edit1.Text;
  GS.IndexEnd := Edit2.Text;

end;

{ TFDMemTableHelper }

procedure TFDMemTableHelper.LoadFromText(text: string);
var
   Dados :TStringList;
   SplitDados :TArray<String>;
   I,J: Integer;
   linhas, colunas :string;
begin

   Self.FieldDefs.Clear;
   try

      Dados := TStringList.Create;
      Dados.Text := text;

      SplitDados := Dados.Strings[0].Split([Char(124)]);

      for I := 0 to Pred(Length(SplitDados)) do
        Self.FieldDefs.add(SplitDados[I].Replace('/','_'), ftString, 25);

      Self.Close;

      Self.Open;

      for J := 1 to PRed(Dados.Count) do begin
         SplitDados := Dados.Strings[J].Split([Char(124)]);
         Self.Append;

         for I := 0 to Pred(Length(SplitDados)) do
           Self.Fields[I].Value := SplitDados[I];

         Self.Post;
      end;

   finally
      Dados.Free;
   end;

end;

{ TDBGridHelper }

procedure TDBGridHelper.AutoSize;
type
  TArray = Array of Integer;
  procedure AjustarColumns(Swidth, TSize: Integer; Asize: TArray);
  var
    idx: Integer;
  begin
    if TSize = 0 then
    begin
      TSize := Self.Columns.count;
      for idx := 0 to Self.Columns.count - 1 do
        Self.Columns[idx].Width := (Self.Width - Self.Canvas.TextWidth('AAAAAA')
          ) div TSize
    end
    else
      for idx := 0 to Self.Columns.count - 1 do
        Self.Columns[idx].Width := Self.Columns[idx].Width +
          (Swidth * Asize[idx] div TSize);
  end;

var
  idx, Twidth, TSize, Swidth: Integer;
  AWidth: TArray;
  Asize: TArray;
  NomeColuna: String;
begin
  SetLength(AWidth, Self.Columns.count);
  SetLength(Asize, Self.Columns.count);
  Twidth := 0;
  TSize := 0;
  for idx := 0 to Self.Columns.count - 1 do
  begin
    NomeColuna := Self.Columns[idx].Title.Caption;
    Self.Columns[idx].Width := Self.Canvas.TextWidth
      (Self.Columns[idx].Title.Caption + 'A');
    AWidth[idx] := Self.Columns[idx].Width;
    Twidth := Twidth + AWidth[idx];

    if Assigned(Self.Columns[idx].Field) then
      Asize[idx] := Self.Columns[idx].Field.Size
    else
      Asize[idx] := 1;

    TSize := TSize + Asize[idx];
  end;
  if TDBGridOption.dgColLines in Self.Options then
    Twidth := Twidth + Self.Columns.count;

  // adiciona a largura da coluna indicada do cursor
  if TDBGridOption.dgIndicator in Self.Options then
    Twidth := Twidth + IndicatorWidth;

  Swidth := Self.ClientWidth - Twidth;
  AjustarColumns(Swidth, TSize, Asize);
end;

end.
