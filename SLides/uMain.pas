unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Layouts, FMX.Objects;

type
  TForm2 = class(TForm)
    tabSlide: TFDMemTable;
    tabSlideID: TAutoIncField;
    tabSlideDescricao: TStringField;
    tabSlideImagem: TStringField;
    Layout1: TLayout;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses FMX.Slides;

procedure TForm2.Button1Click(Sender: TObject);
begin
   Layout1.Slide(tabSlide,5);


//   Rectangle1.Fill.Kind := TBrushKind
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
   tabSlide.Open;
   tabSlide.AppendRecord([1,'Delphi Creative','C:\MeusProjetos\GitHub\Projetos\SLides\1.jpg']);
   tabSlide.AppendRecord([2,'Delphi Creative','C:\MeusProjetos\GitHub\Projetos\SLides\2.jpg']);
   tabSlide.AppendRecord([3,'Delphi Creative','C:\MeusProjetos\GitHub\Projetos\SLides\3.jpg']);
   tabSlide.AppendRecord([4,'Delphi Creative','C:\MeusProjetos\GitHub\Projetos\SLides\4.jpg']);

end;

end.
