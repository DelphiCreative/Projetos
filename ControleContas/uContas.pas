unit uContas;

interface

uses
  System.SysUtils, System.DateUtils, System.Variants;

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
    FID: String;
    FValorPago: String;
    FPagamento: TDate;
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

  public
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

    function IncluirCategoria :String;
    procedure Incluir;
  end;


implementation

{ TContas }

uses uContainer;

procedure TContas.Incluir;
var S :String;
    IdCategoria, idSubcategoria :string;
begin

    if Container.SQLite.ExecSQLScalar('SELECT Count(*) FROM Categorias WHERE Descricao = "'+Categoria+'" AND TipoMovimento ="'+TipoMovimento+'"') = 0 then
       Container.SQLite.ExecSQL('INSERT INTO Categorias (Descricao, TipoMovimento) Values  ("'+Categoria+'","'+TipoMovimento+'")');

    idCategoria := Container.SQLite.ExecSQLScalar('SELECT ID FROM Categorias WHERE Descricao = "'+Categoria+'" AND TipoMovimento ="'+TipoMovimento+'"');


    if Subcategoria <> '' then begin
       if Container.SQLite.ExecSQLScalar(
                                         Format('SELECT Count(*) FROM Subcategorias '+
                                                ' WHERE Descricao = "%s" '+
                                                ' AND TipoMovimento ="%s" '+
                                                ' AND ID_Categoria = "%s"  ',
                                                [Subcategoria,TipoMovimento,idCategoria])) = 0 then
          Container.SQLite.ExecSQL('INSERT INTO Subcategorias (Descricao, TipoMovimento, ID_Categoria) ' +
                                   'VALUES  ("'+Subcategoria+'","'+TipoMovimento+'","'+idCategoria+'")');

       idSubcategoria := Container.SQLite.ExecSQLScalar(
                                         Format('SELECT ID FROM Subcategorias '+
                                                ' WHERE Descricao = "%s" '+
                                                ' AND TipoMovimento ="%s" '+
                                                ' AND ID_Categoria = "%s"  ',
                                                [Subcategoria,TipoMovimento,idCategoria]))
    end;



    if ID = '' then begin

       Container.tabContas.Open('SELECT * FROM Contas LIMIT 0');
       Container.tabContas.Append;
       Container.tabContas.FieldByName('Descricao').value := Descricao;
       if idSubcategoria <> '' then
          Container.tabContas.FieldByName('ID_Subcategoria').value := idSubcategoria;

       Container.tabContas.FieldByName('NParcela').value := Parcela;
       Container.tabContas.FieldByName('Valor').value := Valor.Replace('.','');

       if ValorPago <> '' then
          Container.tabContas.FieldByName('ValorPago').value := ValorPago.Replace('.','');

       Container.tabContas.FieldByName('TipoMovimento').value := TipoMovimento;
       Container.tabContas.FieldByName('ID_Categoria').value := IdCategoria;
       Container.tabContas.FieldByName('DataVencimento').AsDateTime := Vencimento;

       if DateTimeToStr(Pagamento) <> '30/12/1899' then
          Container.tabContas.FieldByName('DataPagamento').AsDateTime := Pagamento;

       Container.tabContas.Post;

    end else begin

       Container.tabContas.Open('SELECT * FROM Parcelas WHERE ID ='+ID);
       Container.tabContas.Edit;
       Container.tabContas.FieldByName('Descricao').value := Descricao;
       if idSubcategoria <> '' then
          Container.tabContas.FieldByName('ID_Subcategoria').value := idSubcategoria;

       Container.tabContas.FieldByName('NParcela').value := Parcela;
       Container.tabContas.FieldByName('Valor').value := (Valor.Replace('.',''));

       if ValorPago <> '' then
          Container.tabContas.FieldByName('ValorPago').value := (ValorPago.Replace('.',''))
       else
          Container.tabContas.FieldByName('ValorPago').AsString := '';

       Container.tabContas.FieldByName('TipoMovimento').value := TipoMovimento;
       Container.tabContas.FieldByName('ID_Categoria').value := IdCategoria;
       Container.tabContas.FieldByName('DataVencimento').AsDateTime := Vencimento;

       if DateTimeToStr(Pagamento) <> '30/12/1899' then
          Container.tabContas.FieldByName('DataPagamento').AsDateTime := Pagamento
       else
          Container.tabContas.FieldByName('DataPagamento').AsString := '';

       Container.tabContas.Post;
    end;

end;

function TContas.IncluirCategoria: String;
begin

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
