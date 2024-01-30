unit uMain;

interface

uses
  System.Generics.Collections, TypInfo,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,FMX.Ani,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Objects, FMX.Edit, FMX.ListBox,
  FMX.Effects;

type
  TfrmMain = class(TForm)
    FDConnection: TFDConnection;
    tabQuery: TFDQuery;
    vsbBarCharRacer: TVertScrollBox;
    Rectangle2: TRectangle;
    ShadowEffect1: TShadowEffect;
    Rectangle3: TRectangle;
    ShadowEffect2: TShadowEffect;
    lblY: TLabel;
    cmbFieldName: TComboBox;
    lblAnimationSpeed: TLabel;
    tbrAnimationSpeed: TTrackBar;
    btnStart: TButton;
    lblX: TLabel;
    flowName: TFlowLayout;
    flowValue: TFlowLayout;
    flowFormat: TFlowLayout;
    lblTitle: TLabel;
    edtTitle: TEdit;
    Line1: TLine;
    lblFormat: TLabel;
    flowDateFormat: TFlowLayout;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses uBarChartManager;

procedure TfrmMain.btnStartClick(Sender: TObject);
var
   BarChartRacer :TBarChartRacer;
begin
   try
      BarChartRacer := TBarChartRacer.Create(tabQuery,vsbBarCharRacer);
      BarChartRacer.Title := edtTitle.Text;
      BarChartRacer.NameField := 'Produto';
      BarChartRacer.ValueField := 'Total';
      BarChartRacer.AnimationDuration := 0.1;
      BarChartRacer.Start;
   finally
      BarChartRacer.Free;
   end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
   FDConnection.Connected := True;

   tabQuery.Open('SELECT '+
                 '  Vendedor, ' +
                 '  Valor, ' +
                 '  Data_Venda, ' +
                 '  1 as Total, ' +
                 '  Produto ' +
                 'FROM VENDAS Order By Data_Venda LIMIT 20 ');

   tabQuery.Active := True;

end;

end.
