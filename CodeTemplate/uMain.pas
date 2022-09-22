unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Layouts, FMX.ListBox;

type
  TForm2 = class(TForm)
    tabDemo: TFDMemTable;
    tabDemoID: TIntegerField;
    tabDemoNome: TStringField;
    tabDemoCidade: TStringField;
    ListBox1: TListBox;
    Button1: TButton;
    ListBoxItem1: TListBoxItem;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
begin
   var L :TListBoxItem;

   ListBox1.Items.Clear;
   tabDemo.First;
   while not tabDemo.Eof do begin
      L := TListBoxItem.Create(ListBox1);
      L.Text := tabDemo.FieldByName('Nome').AsString;
      L.ItemData.Detail := tabDemo.FieldByName('Cidade').AsString;
      L.Height := 40;
      L.StyleLookup := 'listboxitembottomdetail';
      ListBox1.AddObject(L);
      tabDemo.Next;
   end;

end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  var L :TListBoxItem;

     ListBox1.Items.Clear;
     tabDemo.First;
     while not tabDemo.Eof do begin
        L := TListBoxItem.Create(ListBox1);
        L.Text := tabDemo.FieldByName('Nome').AsString;
        L.ItemData.Detail := tabDemo.FieldByName('Cidade').AsString;
        L.Height := 40;
        L.StyleLookup := 'listboxitembottomdetail';
        ListBox1.AddObject(L);
        tabDemo.Next;
     end;

end;

procedure TForm2.FormCreate(Sender: TObject);
begin
   tabDemo.Close;
   tabDemo.Open;
   tabDemo.AppendRecord([1,'Diego Cataneo', 'Mineiros do Tietê']);
   tabDemo.AppendRecord([2,'Diego H Cataneo', 'São Paulo']);
   tabDemo.AppendRecord([3,'Diego Henrique Cataneo', 'Rio de Janeiro']);

end;


end.
