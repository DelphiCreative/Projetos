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
    procedure tbrAnimationSpeedTracking(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     function GetFieldNames(AQuery: TFDQuery; const AFieldTypes: array of TFieldType): TArray<String>;

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses uBarChartManager, FMX.Helper.FLowLayout;

var
   BarChartRacer :TBarChartRacer;

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
   try
      BarChartRacer := TBarChartRacer.Create(tabQuery,vsbBarCharRacer);
      BarChartRacer.Title := edtTitle.Text;
      BarChartRacer.NameField := flowName.ItemSelected;
      BarChartRacer.ValueField := flowValue.ItemSelected;
      BarChartRacer.DateField := 'Data_Venda';
      BarChartRacer.FormatValues := flowFormat.ItemSelected;
      BarChartRacer.FormatDate := flowDateFormat.ItemSelected;
      BarChartRacer.AnimationDuration := tbrAnimationSpeed.Value;
      BarChartRacer.Start;
   finally
     BarChartRacer.Free;
   end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
    I: Integer;
begin

//   for I := 0 to ParamCount do
//      ShowMessage(ParamStr(i));


   FDConnection.Params.Database := ParamStr(1);
   FDConnection.Params.DriverID := ParamStr(2);;

//   FDConnection.Params.Database := 'C:\Git\Projetos\BarChartRaceDelphi\Vendas.sdb';
//   FDConnection.Params.DriverID := 'SQlite';


   FDConnection.Connected := True;

   tabQuery.Open('SELECT '+
                 '  Vendedor, ' +
                 '  Valor, ' +
                 '  Data_Venda, ' +
                 '  1 as Total, ' +
                 '  Produto ' +
                 'FROM VENDAS Order By Data_Venda LIMIT 20 ');

   tabQuery.Active := True;

   flowName.LoadStrings( GetFieldNames(tabQuery,[ftString]));
   flowValue.LoadStrings( GetFieldNames(tabQuery,[ftLargeint,ftFloat]));
   flowFormat.LoadStrings(['0.00', '0']);

   flowDateFormat.LoadStrings(['yyyy-mm-dd', 'dd mmm yyyy']);
   flowDateFormat.SelectItem('dd mmm yyyy');

end;

function TfrmMain.GetFieldNames(AQuery: TFDQuery; const AFieldTypes: array of TFieldType): TArray<String>;
var
  i, j: Integer;
  FieldList: TList<String>;
begin
  FieldList := TList<String>.Create;
  try
    for i := 0 to AQuery.FieldCount - 1 do
    begin
      for j := 0 to High(AFieldTypes) do
      begin
        if AQuery.Fields[i].DataType = AFieldTypes[j] then
        begin
          FieldList.Add(AQuery.Fields[i].FieldName);
          Break;
        end;
      end;
    end;
    Result := FieldList.ToArray;
  finally
    FieldList.Free;
  end;
end;

procedure TfrmMain.tbrAnimationSpeedTracking(Sender: TObject);
begin
   if Assigned(BarChartRacer) then
      BarChartRacer.AnimationDuration := tbrAnimationSpeed.Value;

   lblAnimationSpeed.Text := 'Animation Speed: ' + FormatFloat('0.#',tbrAnimationSpeed.Value)
end;

end.
