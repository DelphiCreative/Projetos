unit VCL.Helpers;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, System.JSON, System.Classes,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, VCL.Dialogs, Vcl.DBCtrls,
  VCL.DBGrids,System.RegularExpressions;

type
  TDBGridHelper = class helper for TDBGrid
    procedure AutoSize;
  end;

type
  TDBComboBoxHelper = class helper for TDBComboBox
     procedure Lista(aItems :String; Separador : String = ',');
  end;

implementation

{ TDBGridHelper }

procedure TDBGridHelper.AutoSize;
{https://showdelphi.com.br/como-ajustar-automaticamente-o-tamanho-das-colunas-do-dbgrid}
type
  TArray = Array of Integer;
  procedure AjustarColumns(Swidth, TSize: Integer; Asize: TArray);
  var
     idx: Integer;
  begin
     if TSize = 0 then begin
        TSize := Self.Columns.count;
        for idx := 0 to Self. Columns.count - 1 do
          Self.Columns[idx].Width := (Self.Width - Self.Canvas.TextWidth('AAAAAA')) div TSize
     end else
        for idx := 0 to Self.Columns.count - 1 do
          Self.Columns[idx].Width := Self.Columns[idx].Width + (Swidth * Asize[idx] div TSize);
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
   for idx := 0 to Self.Columns.count - 1 do begin
      NomeColuna := Self.Columns[idx].Title.Caption;
      Self.Columns[idx].Width := Self.Canvas.TextWidth(Self.Columns[idx].Title.Caption + 'A');
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

   if TDBGridOption.dgIndicator in Self.Options then
      Twidth := Twidth + IndicatorWidth;

   Swidth := Self.ClientWidth - Twidth;
   AjustarColumns(Swidth, TSize, Asize);
end;

{ TDBComboBoxHelper }

procedure TDBComboBoxHelper.Lista(aItems :String; Separador : String = ',');
var
   I :Integer;
   Item :TArray<String>;
begin
   Self.Clear;
   if aItems <> '' then begin
      Item := TRegEx.Split(aItems,Separador);
      for I := 0 to TRegEx.Matches(aItems,Separador).Count do
         Self.Items.Add(Item[I])
   end;
end;

end.

