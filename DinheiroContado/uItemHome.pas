unit uItemHome;

interface

uses
  System.UIConsts,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, FMX.Objects, FMX.Skia, FMX.Layouts, Data.DB;

type
  TfraItemHome = class(TFrame)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Layout3: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    txtValor: TSkLabel;
    Layout10: TLayout;
    txtDescricao: TSkLabel;
    Layout4: TLayout;
    Image1: TImage;
    Image2: TImage;
    imgEditar: TImage;
    RoundRect1: TRoundRect;
    RoundRect2: TRoundRect;
    Layout2: TLayout;
    Circle1: TCircle;
    imgIcone: TImage;
    procedure imgIconeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

     constructor Create(AOwner : TComponent; ADataSet: TDataSet); overload;
  end;

implementation

{$R *.fmx}

uses uMain, FMX.Helpers.Image, uSettings, Chart4Delphi, uChart;

{ TFrame1 }
constructor TfraItemHome.Create(AOwner: TComponent; ADataSet: TDataSet);
var
  strIcone :String;
  color :TAlphaColor;

  procedure ConfigureRectangularLayout(AParent: TLayout; AText: String; AColor: TAlphaColor);
  var
     rctCategoria: TRectangle;
  begin
     if AText <> '' then begin
        rctCategoria := TRectangle.Create(AParent, AText, 8, TAlphaColors.White, AColor);
        rctCategoria.Margins.Left := 5;
        rctCategoria.Margins.Top := 5;
        rctCategoria.Align := TAlignLayout.Left;
        rctCategoria.YRadius := 5;
        rctCategoria.XRadius := 5;
        rctCategoria.Sombrear;
     end;
  end;
begin
  inherited Create(AOwner);

  txtDescricao.Text := ADataSet.FieldByName('Descricao').AsString + ' ' + ADataSet.FieldByName('NParcelas').AsString;
  txtValor.Text := ADataSet.FieldByName('Valor').AsString;

  if ADataSet.FieldByName('IconeCor').AsString <> '' then begin
     Circle1.Fill.Color := StringToAlphaColor('$'+ ADataSet.FieldByName('IconeCor').AsString);
     if Circle1.Fill.Color <> Colors[0] then
        RoundRect2.Fill.Color := Circle1.Fill.Color;
  end;

  if ADataSet.FieldByName('Icone').AsString.ToUpper = '' then
     strIcone := ADataSet.FieldByName('Categoria').AsString.ToUpper
  else
     strIcone := ADataSet.FieldByName('Icone').AsString.ToUpper;

  imgIcone.ImageByName(strIcone);
  imgIcone.Hint := strIcone;
  imgIcone.Tag := 0;

  imgEditar.Tag := ADataSet.FieldByName('ID').AsInteger;

  RoundRect2.Width := (RoundRect1.Width / 100) * ADataSet.FieldByName('PorcentagemPaga').AsFloat;

  if ADataSet.FieldByName('TipoMovimento').AsString = 'R' then
     Color := ColorReceber
  else
     Color := ColorPagar	;

  ConfigureRectangularLayout(Layout4, ADataSet.FieldByName('Categoria').AsString, Color);
  ConfigureRectangularLayout(Layout4, ADataSet.FieldByName('Subcategoria').AsString, Color);
end;

procedure TfraItemHome.imgIconeClick(Sender: TObject);
begin
   if imgIcone.Tag = 0 then begin
      imgIcone.ImageByName('ACEITAR');
      imgIcone.Tag := 1
   end else begin
      imgIcone.ImageByName(imgIcone.Hint);
      imgIcone.Tag := 0;
   end;
   fMain.MultiSelect;
end;

end.
