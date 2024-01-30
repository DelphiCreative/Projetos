{
  Unit: uBarChartManager
  Descrição: Esta unidade fornece funcionalidades para gerenciar e exibir gráficos de barras.
             A classe principal, TBarChartRacer, lida com a criação, atualização e animação de gráficos de barras.

  Autor: Diego Cataneo
  Data de Criação: 25/01/2024
  Última Atualização: 25/01/2024

  Uso: Esta unidade deve ser usada em conjunto com componentes FireMonkey para visualização de dados em forma de gráficos de barras.
       É compatível com TDataSet para carregar dados e exibir em um TVertScrollBox.

  Dependências: FMX.Forms, System.Classes, Data.DB, etc.

  Exemplo de Uso:
    var
      BarChartManager: TBarChartRacer;
    begin
      BarChartManager := TBarChartRacer.Create;
      // Configurações adicionais e uso do BarChartManager
    end;

  Notas:
    - Esta Unit foi desenhada para ser flexível e fácil de integrar em projetos existentes.
    - Os gráficos de barras são animados e podem ser personalizados conforme necessário.

  Licença: Licença Livre
    Este código é disponibilizado sob a Licença MIT.
    Para mais informações, consulte a cópia da licença em https://opensource.org/licenses/MIT.
}


unit uBarChartManager;

interface

uses
  FMX.Forms,
  System.Threading,
  System.Classes, System.SysUtils, System.UITypes, FMX.Types, FMX.Controls,
  FMX.Objects, FMX.Layouts, FMX.Dialogs, FMX.Ani, System.Generics.Defaults,
  FMX.Graphics, Data.DB, System.Generics.Collections;

type
  TBarChartItem = class
  private
    FName: string;
    FValue: Single;
    FDate: TDate;
  public
    property Name: string read FName write FName;
    property Value: Single read FValue write FValue;
    property Date: TDate read FDate write FDate;
  end;

type
  TBarChartRacer = class
  private
    FAnimationDuration: Single;
    FDateField: string;
    FDataSet: TDataSet;
    FFormatValues :string;
    FValueField: string;
    FPendingAnimations :Integer;
    FNameField: string;
    FTitle : string;
    FVertScrollBox: TVertScrollBox;
    FListBarChart: TObjectList<TBarChartItem>;
    FListBarChartCache: TObjectList<TBarChartItem>;
    FFormatDate :string;

    txtDateEvolution : TText;

    function GetRandomColor: TAlphaColor;
    procedure CreateBarChartItem(ABarChart: TBarChartItem);
    procedure LoadDataFromQuery;
    procedure PopulateUIFromData;
    procedure UpdateClassification;
    function FindBarChartByName(const AName: string): TBarChartItem;
    procedure AnimationFinished(Sender: TObject);
    procedure CreateAndStartAnimation(Target: TFmxObject;
      const PropName: string; NewValue: Single);
  public
    constructor Create(ADataSet: TDataSet; AVertScrollBox: TVertScrollBox);
    destructor Destroy; override;

    property DataSet: TDataSet read FDataSet write FDataSet;
    property NameField: string read FNameField write FNameField;
    property ValueField: string read FValueField write FValueField;
    property DateField: string read FDateField write FDateField;
    property FormatValues : string read FFormatValues write FFormatValues;
    property FormatDate : string read FFormatDate write FFormatDate;

    property AnimationDuration: Single read FAnimationDuration write FAnimationDuration;
    property Title: string read FTitle write FTitle;

    property VertScrollBox: TVertScrollBox read FVertScrollBox
      write FVertScrollBox;
    procedure Start;
  end;

implementation

{ TBarChartManager }

constructor TBarChartRacer.Create(ADataSet: TDataSet; AVertScrollBox: TVertScrollBox);
begin
  FListBarChart := TObjectList<TBarChartItem>.Create(True);
  FListBarChartCache := TObjectList<TBarChartItem>.Create(True);
  FAnimationDuration := 0.6;
  FDataSet := ADataSet;
  FVertScrollBox := AVertScrollBox;
end;

procedure TBarChartRacer.CreateBarChartItem(ABarChart: TBarChartItem);
var
  layName: TLayout;
  txtName: TText;
  txtValue: TText;
  rctName: TRectangle;
  UniqueName, Name: string;
begin

  Name := ABarChart.Name.Replace(' ', '_');
  UniqueName := 'layName' + Name;

  layName := TLayout(VertScrollBox.FindComponent(UniqueName));
  if layName = nil then
  begin
    layName := TLayout.Create(VertScrollBox);
    layName.Name := UniqueName;
    layName.Parent := VertScrollBox;
    layName.Position.Y := VertScrollBox.Height *2;
    layName.Height := 50;
    layName.Width := VertScrollBox.Width;
    layName.Padding.Top := 10;
    layName.Padding.Bottom := 10;

    txtName := TText.Create(layName);
    txtName.Align := TAlignLayout.Left;
    txtName.Parent := layName;
    txtName.Name := 'txtName' + Name;
    txtName.Text := Name;
    txtName.Visible := False;
    txtName.TextSettings.HorzAlign := TTextAlign.Trailing;
    txtName.TextSettings.Font.Style := [TFontStyle.fsBold];
    txtName.TextSettings.Font.Size := 10;
    txtName.Margins.Right := 5;
    txtName.Position.X := 0;
    txtName.Width := 100;

    rctName := TRectangle.Create(layName);
    rctName.Parent := layName;
    rctName.Name := 'rctName' + Name;
    rctName.Align := TAlignLayout.Left;
    rctName.Position.X := txtName.Width;
    rctName.Width := 0;
    rctName.Height := layName.Height;
    rctName.Fill.Color := GetRandomColor;
    rctName.Stroke.Color := TAlphaColors.Null;

    txtValue := TText.Create(rctName);
    txtValue.Align := TAlignLayout.Left;
    txtValue.Parent := layName;
    txtValue.Name := 'txtValue' + Name;
    txtValue.Text := '';
    txtValue.Position.X := 10;
    txtValue.Anchors := [TAnchorKind.akRight];
    txtValue.Width := 50;
    txtValue.TextSettings.Font.Size := 10;
    txtValue.Visible := False;


    FListBarChartCache.Add(ABarChart);
  end;
end;

destructor TBarChartRacer.Destroy;
begin
  FListBarChart.Free;
  inherited;
end;

function TBarChartRacer.GetRandomColor: TAlphaColor;
var
  R, G, B: Byte;
begin
  R := Random(256);
  G := Random(256);
  B := Random(256);
  Result := TAlphaColor((R shl 16) or (G shl 8) or B or $FF000000);
end;

procedure TBarChartRacer.LoadDataFromQuery;
var
  BarChart: TBarChartItem;
  BarChartName: string;

  function BarChartExists(const AName: string; out AExistingBarChart: TBarChartItem): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 0 to FListBarChart.Count - 1 do
    begin
      if FListBarChart[i].Name = AName then
      begin
        AExistingBarChart := FListBarChart[i];
        Exit(True);
      end;
    end;
  end;
begin

  if not Assigned(FListBarChart) then
    FListBarChart := TObjectList<TBarChartItem>.Create(True);

  DataSet.Open;
  while not DataSet.Eof do
  begin
    BarChartName := DataSet.FieldByName(NameField).AsString;

    if not BarChartExists(BarChartName, BarChart) then
    begin
      BarChart := TBarChartItem.Create;
      BarChart.Name := BarChartName;
      BarChart.Value := 0;
      FListBarChart.Add(BarChart);
    end;

    BarChart := TBarChartItem.Create;
    BarChart.Name := BarChartName;
    BarChart.Value := DataSet.FieldByName(ValueField).AsSingle;
    BarChart.Date := DataSet.FieldByName(FDateField).AsDateTime;
    FListBarChart.Add(BarChart);

    DataSet.Next;
  end;
  DataSet.Close;
end;

procedure TBarChartRacer.PopulateUIFromData;
var
  i: Integer;
  BarChart: TBarChartItem;
  layTitle : TLayout;
  layContent : TLayout;
  txtTitle : TText;

begin

  VertScrollBox.BeginUpdate;

  for i := VertScrollBox.ComponentCount	- 1 downto 0 do
  begin
    if VertScrollBox.Components[i].ClassName = 'TLayout' then
       VertScrollBox.Components[i].Free;
  end;

  layTitle := TLayout.Create(VertScrollBox);
  layTitle.Name := 'layTitle';
  layTitle.Parent := VertScrollBox;
  layTitle.Position.Y := 0;
  layTitle.Height := 50;
  layTitle.Width := VertScrollBox.Width;
  layTitle.Padding.Top := 10;
  layTitle.Padding.Bottom := 10;

  txtTitle := TText.Create(layTitle);
  txtTitle.Align := TAlignLayout.Client;
  txtTitle.Parent := layTitle;
  txtTitle.Name := 'txtTitulo';
  txtTitle.Text := FTitle;
  txtTitle.TextSettings.Font.Style := [TFontStyle.fsBold];
  txtTitle.TextSettings.Font.Size := 14;
  txtTitle.Margins.Right := 5;
  txtTitle.Position.X := 0;
  txtTitle.Width := 100;

  layContent := TLayout.Create(VertScrollBox);
  layContent.Name := 'layContent';
  layContent.Parent := VertScrollBox;
  layContent.Align := TAlignLayout.Contents;

  txtDateEvolution := TText.Create(layContent);
  txtDateEvolution.Align := TAlignLayout.Bottom;
  txtDateEvolution.Parent := layContent;
  txtDateEvolution.Margins.Bottom := 50;
  txtDateEvolution.Margins.Right := 50;
  txtDateEvolution.Name := 'txtEvolution';
  txtDateEvolution.Text :='';
  txtDateEvolution.TextSettings.HorzAlign := TTextAlign.Trailing;
  txtDateEvolution.TextSettings.Font.Style := [TFontStyle.fsBold];
  txtDateEvolution.TextSettings.Font.Size := 14;

  try
    for i := 0 to FListBarChart.Count - 1 do
    begin
      BarChart := FListBarChart[i];
      CreateBarChartItem(BarChart);
    end;
  finally
    VertScrollBox.EndUpdate;
  end;
end;

function TBarChartRacer.FindBarChartByName(const AName: string): TBarChartItem;
var
  BarChart: TBarChartItem;
begin
  Result := nil;
  for BarChart in FListBarChartCache do
  begin
    if SameText(BarChart.Name, AName) then
    begin
      Result := BarChart;
      Break;
    end;
  end;
end;

procedure TBarChartRacer.Start;
var
  BarChart, FoundBarChart: TBarChartItem;
begin

  if NameField = '' then
     NameField := DataSet.Fields[0].FieldName;

  if ValueField = '' then
     ValueField := DataSet.Fields[1].FieldName;

  if DateField = '' then
     DateField := DataSet.Fields[2].FieldName;

  LoadDataFromQuery;
  PopulateUIFromData;

  for BarChart in FListBarChart do
  begin
    FoundBarChart := FindBarChartByName(BarChart.Name);
    if Assigned(FoundBarChart) then
    begin
      FoundBarChart.Value := FoundBarChart.Value + BarChart.Value;
      if BarChart.Date > 0 then begin
         txtDateEvolution.Text :=  FormatDateTime(FFormatDate, BarChart.Date);
      end;

      UpdateClassification;
      while FPendingAnimations <> 0 do
         Application.ProcessMessages
    end;
  end;
end;

procedure TBarChartRacer.UpdateClassification;
var
  Name: string;
  layName: TLayout;
  txtName, txtValue: TText;
  NewPositionY: Integer;
  MaxValue: Double;
  rctName: TRectangle;
  BarChart: TBarChartItem;
  Counter: Integer;
begin
  MaxValue := 0;
  Counter := 0;

  if FFormatValues = '' then
     FFormatValues := '0.00';

  for BarChart in FListBarChartCache do
  begin
    if BarChart.Value > MaxValue then
      MaxValue := BarChart.Value;
  end;

  FListBarChartCache.Sort(TComparer<TBarChartItem>.Construct(
  function(const Left, Right: TBarChartItem): Integer
  begin
    if Left.Value < Right.Value then
      Result := 1
    else if Left.Value > Right.Value then
      Result := -1
    else
      Result := CompareText(Left.Name, Right.Name);
  end));


  for BarChart in FListBarChartCache do
  begin
    Inc(Counter);

    Name := BarChart.Name.Replace(' ', '_');

    layName := TLayout(VertScrollBox.FindComponent('layName' + Name));
    txtName := TText(layName.FindComponent('txtName' + Name));
    rctName := TRectangle(layName.FindComponent('rctName' + Name));
    txtValue := TText(rctName.FindComponent('txtValue' + Name));

    if Assigned(layName) and Assigned(txtValue) and Assigned(rctName) then
    begin

      if BarChart.Value > 0 then begin
        txtValue.Visible := True;
        txtName.Visible := True;
      end;

      txtValue.Text := FormatFloat(FFormatValues, BarChart.Value);

      if MaxValue <> 0 then
        NewPositionY := Round((BarChart.Value / MaxValue) * ((VertScrollBox.Width / 6) * 4 ))
      else
        NewPositionY := 0;

      CreateAndStartAnimation(rctName, 'Width', NewPositionY);
      CreateAndStartAnimation(layName, 'Position.Y', Counter * layName.Height);
    end;
  end;
end;

procedure TBarChartRacer.AnimationFinished(Sender: TObject);
begin
  Sender.Free;
  Dec(FPendingAnimations);
end;

procedure TBarChartRacer.CreateAndStartAnimation(Target: TFmxObject;
  const PropName: string; NewValue: Single);
var
  Anim: TFloatAnimation;
begin
  Anim := TFloatAnimation.Create(Target);
  Anim.Parent := Target;
  Anim.PropertyName := PropName;
  Anim.StopValue := NewValue;
  Anim.Duration := FAnimationDuration;
  Anim.AnimationType := TAnimationType.In;
  Anim.StartFromCurrent := True;
  Anim.Interpolation := TInterpolationType.Circular;
  Anim.OnFinish := AnimationFinished;
  Anim.Start;
  Inc(FPendingAnimations);
end;

end.
