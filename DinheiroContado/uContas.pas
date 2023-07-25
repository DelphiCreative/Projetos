unit uContas;

interface

uses
  FMX.Dialogs, System.SysUtils, System.DateUtils, System.Variants, FireDAC.Comp.Client, System.StrUtils;

type
  TContas = class
  private
    FValor: String;
    FVencimento: TDate;
    FCategoria: String;
    FDescricao: String;
    FSubcategoria: String;
    FParcela: Integer;
    FTipoMovimento :String;
    FIDCategoria :String;
    FIDSubCategoria :String;
    FID: String;
    FValorPago: String;
    FPagamento: TDate;
    FConnection: TFDConnection;
    procedure SetCategoria(const Value: String);
    procedure SetDescricao(const Value: String);
    procedure SetSubcategoria(const Value: String);
    procedure SetParcela(const Value: Integer);
    procedure SetValor(const Value: String);
    procedure SetVencimento(const Value: TDate);
    procedure SetTipoMovimento(const Value: String);
    procedure SetID(const Value: String);
    procedure SetValorPago(const Value: String);
    procedure SetPagamento(const Value: TDate);

    function IdCategoria :String;
    function IdSubCategoria :String;
    function QueryCategoria :string;
    function QuerySubCategoria :string;

  public

    constructor Create(Connection: TFDConnection);
    property ID            :String read FID write SetID;
    property Subcategoria  :String read FSubcategoria write SetSubcategoria;
    property Categoria     :String read FCategoria write SetCategoria;
    property Descricao     :String read FDescricao write SetDescricao;
    property Valor         :String read FValor write SetValor;
    property ValorPago     :String read FValorPago write SetValorPago;
    property Parcela       :Integer read FParcela write SetParcela;
    property Vencimento    :TDate read FVencimento write SetVencimento;
    property Pagamento     :TDate read FPagamento write SetPagamento;
    property TipoMovimento :String read FTipoMovimento write SetTipoMovimento;
    procedure Incluir;
    procedure Excluir;
    procedure Liquidar;

  end;


implementation

{ TContas }

uses uContainer;

constructor TContas.Create(Connection: TFDConnection);
begin
  inherited Create;
  FConnection := Connection;
end;


procedure TContas.Excluir;
begin
   FConnection.ExecSQL('DELETE FROM Parcelas WHERE ID IN ('+ ID + ')');
end;

function TContas.IdCategoria: String;
begin
    if FConnection.ExecSQLScalar(QueryCategoria) = 0 then begin
       FConnection.ExecSQL('INSERT INTO Categorias (Descricao, TipoMovimento) Values  ("'+Categoria+'","'+TipoMovimento+'")');
    end;

    FIDCategoria  := FConnection.ExecSQLScalar(QueryCategoria);

    Result := FIDCategoria;
end;

function TContas.IdSubCategoria: String;
begin
    if Subcategoria <> '' then begin

       if FConnection.ExecSQLScalar(QuerySubCategoria) = 0 then
          FConnection.ExecSQL('INSERT INTO Subcategorias (Descricao, TipoMovimento, ID_Categoria) ' +
                               'VALUES  ("'+Subcategoria+'","'+TipoMovimento+'","'+FIDCategoria+'")');

       FIDCategoria :=  FConnection.ExecSQLScalar(QuerySubCategoria)
    end;

    Result := FIDCategoria
end;

procedure TContas.Incluir;
var
   Query: TFDQuery;
begin
   try
      Query := TFDQuery.Create(nil);
      try
         Query.Connection := FConnection;

         if ID = '' then begin
            Query.Open('SELECT * FROM Contas LIMIT 0');
            Query.Append;

            if not ValorPago.IsEmpty then
               Query.FieldByName('ValorPago').value := ValorPago.Replace('.','');

            if Pagamento <> EncodeDate(1899, 12, 30) then
               Query.FieldByName('DataPagamento').AsDateTime := Pagamento;

         end else begin
            Query.Open('SELECT * FROM Parcelas WHERE ID ='+ID);
            Query.Edit;

            if not ValorPago.IsEmpty then
               Query.FieldByName('ValorPago').value := (ValorPago.Replace('.',''))
            else
               Query.FieldByName('ValorPago').Clear;

            if Pagamento <> EncodeDate(1899, 12, 30) then
                Query.FieldByName('DataPagamento').AsDateTime := Pagamento
            else
                Query.FieldByName('DataPagamento').Clear;

         end;

         Query.FieldByName('Descricao').value := Descricao;
         Query.FieldByName('TipoMovimento').value := TipoMovimento;
         Query.FieldByName('ID_Categoria').value := IdCategoria;
         Query.FieldByName('DataVencimento').AsDateTime := Vencimento;
         Query.FieldByName('NParcela').value := Parcela;
         Query.FieldByName('Valor').value := Valor.Replace('.','');
         Query.FieldByName('ID_Subcategoria').value := idSubcategoria;

         Query.Post;

      finally
         Query.Free;
      end;
   except
    on E: Exception do
      ShowMessage('Erro ao incluir ou atualizar conta: ' + E.Message);
   end;
end;

procedure TContas.Liquidar;
begin
   FConnection.ExecSQL('UPDATE Parcelas '+
                       'SET  '+
                       ' DataPagamento = IIF(DataPagamento IS NULL, strftime("%Y-%m-%d",DateTime()),NULL),'+
                       ' ValorPago = IIF(DataPagamento IS NULL, Valor, NULL) '+
                       ' WHERE DataPagamento IS NULL AND ID IN ('+ ID +')' );
end;

function TContas.QueryCategoria: string;
begin
  Result := Format('SELECT ID FROM Categorias WHERE Descricao = "%s" AND TipoMovimento = "%s"', [Categoria, TipoMovimento]);
end;

function TContas.QuerySubCategoria: string;
begin
  Result := Format('SELECT ID FROM Subcategorias WHERE Descricao = "%s" AND TipoMovimento ="%s" AND ID_Categoria = "%s"', [Subcategoria,TipoMovimento,FIDCategoria])
end;

procedure TContas.SetCategoria(const Value: String);
begin
  FCategoria := Trim(Value);
end;

procedure TContas.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TContas.SetID(const Value: String);
begin
  FID := Value;
end;

procedure TContas.SetSubcategoria(const Value: String);
begin
  FSubcategoria := Trim(Value);
end;

procedure TContas.SetPagamento(const Value: TDate);
begin
  FPagamento := Value;
end;

procedure TContas.SetParcela(const Value: Integer);
begin
  FParcela := Value;
end;

procedure TContas.SetTipoMovimento(const Value: String);
begin
  FTipoMovimento := Value;
end;

procedure TContas.SetValor(const Value: String);
begin
  FValor := Value;
end;

procedure TContas.SetValorPago(const Value: String);
begin
  FValorPago := Value;
end;

procedure TContas.SetVencimento(const Value: TDate);
begin
  FVencimento := Value;
end;

end.
