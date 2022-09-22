unit uMain;

interface

uses
  ClipBrd,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ControlList,
  Vcl.VirtualImage, Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.ExtCtrls;

type
  TFDMemTableHelper = class helper for TFDMemTable
     procedure LoadFromClipboard;
  end;

type
  TForm3 = class(TForm)
    Button1: TButton;
    FDMemTable1: TFDMemTable;
    ControlList1: TControlList;
    Label1: TLabel;
    VirtualImage1: TVirtualImage;
    Label2: TLabel;
    ImageCollection1: TImageCollection;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure ControlList1BeforeDrawItem(AIndex: Integer; ACanvas: TCanvas;
      ARect: TRect; AState: TOwnerDrawState);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}


procedure TForm3.Button1Click(Sender: TObject);
begin
   FDMemTable1.LoadFromClipboard;
   ControlList1.ItemCount := FDMemTable1.RecordCount;


end;

{ TFDMemTableHelper }

procedure TFDMemTableHelper.LoadFromClipboard;
var
   Dados :TStringList;
   SplitDados :TArray<String>;
   I,J: Integer;
begin

   Self.FieldDefs.Clear;
   try
      Dados := TStringList.Create;
      Dados.Text := Clipboard.AsText;

      SplitDados := Dados.Strings[0].Split([Char(9)]);

      for I := 0 to Pred(Length(SplitDados)) do
        Self.FieldDefs.add(SplitDados[I].Replace('/','_'), ftString, 25);

      Self.Close;

      Self.Open;

      for J := 1 to PRed(Dados.Count) do begin
         SplitDados := Dados.Strings[J].Split([Char(9)]);
         Self.Append;

         for I := 0 to Pred(Length(SplitDados)) do
           Self.Fields[I].Value := SplitDados[I];

         Self.Post;
      end;

   finally
      Dados.Free;
   end;
end;

procedure TForm3.ControlList1BeforeDrawItem(AIndex: Integer; ACanvas: TCanvas;
  ARect: TRect; AState: TOwnerDrawState);
begin
   FDMemTable1.RecNo := AIndex +1;
   Label2.Caption := FDMemTable1.Fields[0].AsString.ToUpper;
   Label1.Caption := FDMemTable1.Fields[1].AsString;

   VirtualImage1.ImageName := FDMemTable1.Fields[0].AsString;

end;

end.
