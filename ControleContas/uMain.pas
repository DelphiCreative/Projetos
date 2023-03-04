unit uMain;

interface

uses
 FMX.VirtualKeyboard, FMX.DialogService.Async,FMX.DialogService,
  FMX.Ani,System.StrUtils,  System.Generics.Collections, FMX.Platform,
  System.SysUtils,DateUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Layouts,
  FMX.Objects, FMX.TabControl, FMX.Edit, FMX.Colors, System.ImageList,
  FMX.ImgList, FMX.Calendar, FMX.DateTimeCtrls, FMX.Effects, System.Actions,
  FMX.ActnList, FMX.MultiView;

type
  THelperForm = class helper for TForm
     procedure Aviso(Msg , Botao1 , Botao2 : String);

     procedure ExibeMsg(msg:String);

     procedure LancarDespesaReceita;
     procedure SelectDespesaReceita;

     procedure SelectCategorias(sql :String; sNameComponent :string);

     procedure SelectContas(sql :String);

     procedure ExitAviso(Sender: TObject);
     procedure ExitFinish(Sender: TObject);

  end;


type
  TfMain = class(TForm)
    TabControl1: TTabControl;
    TabHome: TTabItem;
    TabReceitaDespesa: TTabItem;
    TabValor: TTabItem;
    Rectangle1: TRectangle;
    retTopo: TRectangle;
    VertScrollBox1: TVertScrollBox;
    Rectangle3: TRectangle;
    btnAnterior: TSpeedButton;
    btnProximo: TSpeedButton;
    Layout1: TLayout;
    Circle1: TCircle;
    SpeedButton3: TSpeedButton;
    Rectangle7: TRectangle;
    Rectangle11: TRectangle;
    Rectangle4: TRectangle;
    Text6: TText;
    Rectangle5: TRectangle;
    Text11: TText;
    edtCategoria: TEdit;
    Text12: TText;
    ImageList1: TImageList;
    edtValor: TEdit;
    Line1: TLine;
    Label2: TLabel;
    Line2: TLine;
    Rectangle6: TRectangle;
    SearchEditButton2: TSearchEditButton;
    Text2: TText;
    edtSubcategoria: TEdit;
    SearchEditButton3: TSearchEditButton;
    Line3: TLine;
    edtVencimento: TDateEdit;
    GridPanelLayout1: TGridPanelLayout;
    Layout5: TLayout;
    GridPanelLayout3: TGridPanelLayout;
    Layout6: TLayout;
    edtParcela: TEdit;
    Line4: TLine;
    Label1: TLabel;
    Rectangle10: TRectangle;
    Rectangle13: TRectangle;
    lblLimparParcela: TLabel;
    Rectangle9: TRectangle;
    SpeedButton1: TSpeedButton;
    Rectangle12: TRectangle;
    ShadowEffect1: TShadowEffect;
    Text4: TText;
    Text5: TText;
    edtDescricao: TEdit;
    Line5: TLine;
    Rectangle2: TRectangle;
    Rectangle15: TRectangle;
    Rectangle16: TRectangle;
    Rectangle17: TRectangle;
    Rectangle18: TRectangle;
    Rectangle19: TRectangle;
    VertScrollBox2: TVertScrollBox;
    GridPanelLayout2: TGridPanelLayout;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    Image2: TImage;
    Text7: TText;
    Rectangle20: TRectangle;
    Image3: TImage;
    Text10: TText;
    Rectangle21: TRectangle;
    Image4: TImage;
    Text13: TText;
    MultiView1: TMultiView;
    Rectangle22: TRectangle;
    Image5: TImage;
    Text14: TText;
    Memo1: TMemo;
    Rectangle8: TRectangle;
    Rectangle14: TRectangle;
    Text8: TText;
    edtID: TEdit;
    Line6: TLine;
    Layout4: TLayout;
    Rectangle25: TRectangle;
    Text9: TText;
    edtPagamento: TDateEdit;
    Rectangle26: TRectangle;
    Label5: TLabel;
    edtValorPago: TEdit;
    Line8: TLine;
    HorzScrollBox1: THorzScrollBox;
    Text15: TText;
    GridPanelLayout4: TGridPanelLayout;
    Rectangle23: TRectangle;
    Layout7: TLayout;
    Text16: TText;
    Text17: TText;
    LayoutReceitas: TLayout;
    LayoutReceber: TLayout;
    Rectangle24: TRectangle;
    Rectangle27: TRectangle;
    Layout2: TLayout;
    Text1: TText;
    Text3: TText;
    LayoutDespesas: TLayout;
    LayoutPagar: TLayout;
    Rectangle28: TRectangle;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    procedure Layout1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Text5Click(Sender: TObject);
    procedure SearchEditButton2Click(Sender: TObject);
    procedure SearchEditButton3Click(Sender: TObject);
    procedure edtValorEnter(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure edtParcelaExit(Sender: TObject);
    procedure edtParcelaEnter(Sender: TObject);
    procedure lblLimparParcelaClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Text4Click(Sender: TObject);
    procedure edtCategoriaChangeTracking(Sender: TObject);
    procedure Rectangle6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Text14Click(Sender: TObject);
    procedure Rectangle7Click(Sender: TObject);
    procedure VertScrollBox2ViewportPositionChange(Sender: TObject;
      const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Voltar;
  private
    { Private declarations }
  public
    { Public declarations }

    DataNew,DataOld :TDate;
    procedure ListarContas(ASimples: Boolean = False);
    procedure CardsCategoria;
    procedure AnimaFinish(Sender: TObject);
    procedure LimparLista;
    procedure CarregaCategorias;
    procedure CarregaSubcategorias;

    procedure Data(Direction :String);
    procedure MyDate(Direction :String);
    procedure Teclado;
    procedure TecladoInteiro;

    procedure IconeClick(Sender: TObject);
    procedure IconeExcluirClick(Sender: TObject);
    procedure IconeEditarClick(Sender: TObject);
    procedure NumeroClick(Sender : TObject);
    procedure NumeroInteiroClick(Sender : TObject);
  end;

var
  fMain: TfMain;
  vParcela, ID_Parcela :String;
  ListLayout,ListContas : TObjectList<TLayout>;
  ListCategorias, ListHCategorias : TObjectList<TRectangle>;
  ListaAnima,
  ListAnimaEntrada,
  ListAnimaSaida : TObjectList<TFloatAnimation>;
  FormList :  TObjectList<TForm>;
  NameComponent, NameValor :String;

  FundoOpaco :TRectangle;

implementation

{$R *.fmx}

uses uContainer, FMX.Helpers.Layouts,  FMX.Helpers.Text,
  FMX.Functions, FMX.Helpers.Image, FMX.Helpers.FloatAnimation, uContas,
  uChart, uCards;

var
   LayoutPrincipal : TControl;

procedure TfMain.Data(Direction: String);
var
   R, retDespesas, rPagar, rReceber, retReceitas :TRectangle;
   T, txtDespesas, txtReceber, txtPagar, txtReceitas  :TText;
   Mes :String;
begin

   if direction = 'L' then begin
      DataNew := IncMonth(DataNew,+1)
   end else if direction = 'R' then begin
      DataNew := IncMonth(DataNew,-1)
   end else if direction = 'U' then
      DataOld := IncMonth(DataNew,-1)
   else
      DataNew := Date;

   if (DataNew <> DataOld) or (direction = 'U') or (direction = 'A') then begin
      DataOld := DataNew;

      if YearOf(DataNew) = YearOf(Date) then
         Mes := AnsiUpperCase(FormatDateTime('MMMM',DataNew))
      else
         Mes := AnsiUpperCase(FormatDateTime('MMM/yyyy',DataNew));

      Layout1.Hint := FormatDateTime('YYYY-MM-DD',DataNew);


      R := TRectangle.Create(Self,TAlphaColors.Null);

      T := TText.Create(R,
                        Mes ,
                        14,
                        TAlphaColors.white,
                        TAlignLayout.Client
                        );
      T.Bold;

      Container.tabConsulta.Open(Container.FDScript2.SQL(1).Replace('?',FormatDateTime('YYYY-MM',DataNew)));


      retDespesas := TRectangle.Create(Self,TAlphaColors.Null);

      txtDespesas := TText.Create(retDespesas,
                                  Container.tabConsulta.Fields[1].AsString,
                                  14,
                                  TAlphaColors.Darkgrey,
                                  TAlignLayout.Client
                                  );
      txtDespesas.Bold;

      retReceitas := TRectangle.Create(Self,TAlphaColors.Null);

      txtReceitas := TText.Create(retReceitas,
                                  Container.tabConsulta.Fields[0].AsString,
                                  14,
                                  TAlphaColors.Darkgrey,
                                  TAlignLayout.Client
                                  );
      txtReceitas.Bold;

      rPagar := TRectangle.Create(Self,TAlphaColors.Null);

      txtPagar := TText.Create(rPagar,
                                  Container.tabConsulta.Fields[3].AsString,
                                  14,
                                  TAlphaColors.Darkgrey,
                                  TAlignLayout.Client
                                  );
      txtPagar.Bold;

      rReceber := TRectangle.Create(Self,TAlphaColors.Null);

      txtReceber := TText.Create(rReceber,
                                  Container.tabConsulta.Fields[2].AsString,
                                  14,
                                  TAlphaColors.Darkgrey,
                                  TAlignLayout.Client
                                  );
      txtReceber.Bold;

      Container.tabLista.Open(Container.FDScript2.SQL(0) +' AND strftime("%Y-%m", DataVencimento) = ' +QuotedStr(FormatDateTime('YYYY-MM',DataNew)) + ' GROUP BY ID ORDER BY Categoria' );

      if (direction = 'L') or (direction = 'R') then begin
         Layout1.AnimaCard(R,direction);
      end else begin
         Layout1.AnimaCard(R);
      end;

      LayoutDespesas.AnimaCard(retDespesas);
      LayoutReceitas.AnimaCard(retReceitas);
      LayoutPagar.AnimaCard(rPagar);
      LayoutReceber.AnimaCard(rReceber);

      if (direction <> 'A') then
         ListarContas;
   end;

end;

procedure TfMain.edtCategoriaChangeTracking(Sender: TObject);
begin
   edtSubcategoria.Text := '';
end;

procedure TfMain.edtParcelaEnter(Sender: TObject);
begin
   Rectangle9.AnimateFloat('Height',75,0.3, TAnimationType.In, TInterpolationType.Circular)
end;

procedure TfMain.edtParcelaExit(Sender: TObject);
begin
   Rectangle9.AnimateFloat('Height',0,0.3, TAnimationType.In, TInterpolationType.Circular)
end;

procedure TfMain.FormCreate(Sender: TObject);
begin

   StatusBarColor(retTopo.Fill.Color);

   ImageList := ImageList1;

   Image2.ImageByName('LIQUIDADA');
   Image3.ImageByName('ABERTA');
   Image4.ImageByName('ATRASADA');

   Teclado;
   TecladoInteiro;

   ListAnimaEntrada := TObjectList<TFloatAnimation>.Create;
   ListAnimaSaida := TObjectList<TFloatAnimation>.Create;
   ListaAnima := TObjectList<TFloatAnimation>.Create;
   ListLayout := TObjectList<TLayout>.Create;
   ListContas := TObjectList<TLayout>.Create;
   ListCategorias := TObjectList<TRectangle>.Create;
   ListHCategorias := TObjectList<TRectangle>.Create;
   FormList :=  TObjectList<TForm>.Create;

   TabControl1.GotoVisibleTab(0);
   TabControl1.TabPosition := TTabPosition.None;

   LayoutPrincipal := TLayout(Self.Parent);

end;

procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
var
   FService : IFMXVirtualKeyboardService;
begin
   if Key = vkHardwareBack then begin
      TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
      if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then begin

      end else  begin
         Key := 0;
         Voltar;
      end;
   end;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
   Data('');

end;

procedure TfMain.IconeClick(Sender: TObject);
var status :string;
begin

   Container.SQLite.ExecSQL('UPDATE Parcelas '+
                            'SET  '+
                            ' DataPagamento = IIF(DataPagamento IS NULL, strftime("%Y-%m-%d",DateTime()),NULL),'+
                            ' ValorPago = IIF(ValorPago IS NULL, Valor ,NULL) '+
                            ' WHERE ID = '+ TImage(Sender).Tag.ToString );

   status := Container.SQLite.ExecSQLScalar('SELECT IIF(DataPagamento IS NOT NULL, "LIQUIDADA",IIF( strftime("%Y/%m/%d", DataVencimento) < strftime("%Y/%m/%d", Datetime()), "ATRASADA", "ABERTA"))Status FROM parcelas  WHERE ID = '+ TImage(Sender).Tag.ToString );
   if status = 'LIQUIDADA' then
      ExibeMsg('Conta liquidada')
   else
      ExibeMsg('Pagamento cancelado');

   TImage(Sender).ImageByName(status);

   Data('U')

end;


procedure TfMain.IconeExcluirClick(Sender: TObject);
begin

   Container.SQLite.ExecSQL('DELETE FROM Parcelas WHERE ID = '+ TImage(Sender).Tag.ToString );

   Data('U');

   ExibeMsg('Conta excluída');

end;


procedure TfMain.IconeEditarClick(Sender: TObject);
begin
   Container.tabContas.Open(Container.FDScript2.SQL(0) + ' AND ID ='+ TImage(Sender).Tag.ToString);

   edtID.Text := TImage(Sender).Tag.ToString;
   edtDescricao.Text := Container.tabContas.FieldByName('Descricao_Parcela').AsString;
   edtCategoria.Text := Container.tabContas.FieldByName('Categoria').AsString;
   edtSubcategoria.Text := Container.tabContas.FieldByName('SubCategoria').AsString;
   edtVencimento.Text := Container.tabContas.FieldByName('Vencimento').AsString;
   edtParcela.Text := Container.tabContas.FieldByName('NParcela').AsString;

   edtPagamento.Text := Container.tabContas.FieldByName('Pagamento').AsString;

   edtValor.Hint :=  FormatFloat('#,##0.00', Container.tabContas.FieldByName('ValorParcela').AsFloat);
   edtValor.Text :=  edtValor.Hint;

   if Container.tabContas.FieldByName('ValorPago').AsString <> '' then
      edtValorPago.Hint :=  FormatFloat('#,##0.00', Container.tabContas.FieldByName('ValorPago').AsFloat)
   else
      edtValorPago.Hint := '';

   if Container.tabContas.FieldByName('TipoMovimento').AsString = 'R' then begin
      Text6.Text := 'Receita';
      Text6.Tag := 0;
   end else begin
      Text6.Text := 'Despesa';
      Text6.Tag := 1;
   end;

   edtValorPago.Text :=  edtValorPAgo.Hint;
   TabControl1.GotoVisibleTab(1)


end;

procedure TfMain.Layout1Click(Sender: TObject);
begin
   Data('');
end;

procedure TfMain.lblLimparParcelaClick(Sender: TObject);
var
   S :String;
begin
   S := vParcela;
   S := LeftStr(S, S.Length-1);
   vParcela := S;
   edtParcela.Text := S;

end;

procedure TfMain.LimparLista;
var I , J : Integer;
begin

   ListContas.Clear;

   {J := 1;
   for I := 0 to ListaAnima.Count -1 do begin

      if ListaAnima.Items[I].Tag <> -1 then begin
         J := J +1 ;

         ListaAnima.Items[I].StartFromCurrent := true;
         ListaAnima.Items[I].StopValue := VertScrollBox1.Width * -2;
         ListaAnima.Items[I].Duration      := 0.2;

         ListaAnima.Items[I].OnFinish := AnimaFinish;

         ListaAnima.Items[I].Start;
      end;
   end;}
end;

procedure TfMain.ListarContas(ASimples: Boolean = False);
var
   I : Integer;
   layPrincipal: TLayout;
   Anima : TFloatAnimation;
   rCard, Valor :TRectangle;
   Color :TAlphaColor;
begin


   I := 0;
   LimparLista;
   Container.tabLista.First;
   while not  Container.tabLista.Eof do begin
      layPrincipal            := TLayout.Create(VertScrollBox2);
      layPrincipal.Height := 70;

      layPrincipal.Position.X := 0;
      layPrincipal.Width      := VertScrollBox2.Width;
      layPrincipal.Tag        := I;
      layPrincipal.Align := TAlignLayout.Top;
      ListContas.Add(layPrincipal);

      VertScrollBox2.AddObject(layPrincipal);

      rCard := TRectangle.Create(layPrincipal);
      rCard.Fill.Color     := TAlphaColorRec.White;
      rCard.Stroke.Color   := TAlphaColorRec.Darkgray;
      rCard.PositionXY(layPrincipal.Width *(I+1),2);
      rCard.Width          := layPrincipal.Width - 40;
      rCard.Height         := layPrincipal.Height - 4;
      rCard.Tag            := I;
      rCard.MarginAll(2);
      rCard.PaddingAll(0);
      rCard.Padding.Right := 5;
      rCard.Sombrear;
      layPrincipal.AddObject(rCard);

      Anima := TFloatAnimation.Create(rCard,0.3,rCard.Width ,20, True, 'Position.X', 0);

      if Container.tabLista.FieldByName('TipoMovimento').AsString = 'R' then
         Color     := TAlphaColorRec.Green
      else
         Color     := TAlphaColorRec.Tomato;

      Color := TAlphaColors.White;
      FCard := TFCard.Create(Self);
      rCard.AddObject(FCard.Rectangle1);
      FCard.txtDescricao.Text := Container.tabLista.FieldByName('Descricao').AsString;
      FCard.txtValor.Text := Container.tabLista.FieldByName('Valor').AsString;
      FCard.Rectangle2.Fill.Color := Color;
      FCard.imgIcone.ImageByName(Container.tabLista.FieldByName('Categoria').AsString.ToUpper);

      FCard.Image3.Tag := Container.tabLista.FieldByName('ID').AsInteger;
      FCard.Image3.OnClick := IconeEditarClick;

      FCard.Image1.Tag := Container.tabLista.FieldByName('ID').AsInteger;
      FCard.Image1.OnClick := IconeExcluirClick;

      FCard.Image2.ImageByName(Container.tabLista.FieldByName('Status').AsString.ToUpper);
      FCard.Image2.Tag := Container.tabLista.FieldByName('ID').AsInteger;
      FCard.Image2.OnClick := IconeClick;

      Valor := TRectangle.Create(FCard.Layout4, Container.tabLista.FieldByName('Categoria').AsString, 8, TAlphaColors.Darkgrey, Color);//TTextAlign.Trailing);
      Valor.Align := TAlignLayout.Left;
      Valor.Margins.Right := 5;
      Valor.Margins.Top := 5;
      Valor.YRadius := 5;
      Valor.XRadius := 5;
      Valor.Sombrear;

      if Container.tabLista.FieldByName('Subcategoria').AsString <> '' then begin
         Valor := TRectangle.Create(FCard.Layout4, Container.tabLista.FieldByName('Subcategoria').AsString, 8, TAlphaColors.Darkgrey,Color);//TTextAlign.Trailing);
         Valor.Margins.Left := 5;
         Valor.Margins.Top := 5;
         Valor.Align := TAlignLayout.Left;
         Valor.YRadius := 5;
         Valor.XRadius := 5;
         Valor.Sombrear;
      end;

      Anima.Tag := I;
      Anima.Interpolation := TInterpolationType.Linear;

      rCard.AddObject(Anima);

      FormList.Add(FCard);
      ListaAnima.Add(Anima);
      Anima.Start;

      Inc(I);

      Container.tabLista.Next
   end;

   CardsCategoria;
end;

procedure TfMain.MyDate(Direction: String);
begin

end;

procedure TfMain.NumeroClick(Sender: TObject);
var
   S :String;
begin

   if TText(Sender).Tag = 0 then begin

      S := (TEdit(FindComponent(NameValor)).Hint + TText(Sender).Text).Replace(',','').Replace('.','');

      if StrToInt64(s) > 99 then
         s := inttostr(StrToInt64(s))
      else
         s := RightStr(S,3);

      S.Insert(S.Length-2,',');

      if S.Length > 6 then
         S.Insert(S.Length-6,'.');

      TEdit(FindComponent(NameValor)).Hint := S;
   end else if TText(Sender).Tag = 2 then begin
      S := (TEdit(FindComponent(NameValor)).Hint).Replace(',','').Replace('.','');
      S := LeftStr(S, S.Length-1);

      if S.Length = 2 then  S :=  ('0'+S);
      S.Insert(S.Length-2,',');

      if S.Length > 6 then
         S.Insert(S.Length-6,'.');

      TEdit(FindComponent(NameValor)).Hint := S;

   end else if TText(Sender).Tag = 1 then begin
      S := '0.00';
      TEdit(FindComponent(NameValor)).Hint := S;
   end;

   TEdit(FindComponent(NameValor)).Text := S;
end;

procedure TfMain.NumeroInteiroClick(Sender: TObject);
var
   S :String;
begin

   S := (vParcela + TText(Sender).Text);
   s := inttostr(StrToInt64(s));
   vParcela := S;
   edtParcela.Text := S;

end;

procedure TfMain.Rectangle6Click(Sender: TObject);
begin
   if TRectangle(Sender).Fill.Color = TAlphaColors.White then
      TRectangle(Sender).Fill.Color := TAlphaColors.Darkgray
   else
      TRectangle(Sender).Fill.Color := TAlphaColors.White;

   //ListarContas(True);
end;

procedure TfMain.Rectangle7Click(Sender: TObject);
var SQL :String;
begin
  // varConsulta := Primeiro_Nome(Trim(UpperCase(varSintaxe)));

   SQL := Memo1.text;

   try

      Container.tabConsulta.SQL.Text:= SQL;

      if (LeftStr(SQL.Trim,6) = 'SELECT') then begin

         Container.tabConsulta.Open;
      end else begin

         Container.tabConsulta.ExecSQL;
      end;
  except
        on E:Exception do  begin

            ExibeMsg(StringReplace(E.Message,'[FireDAC][Phys][MySQL] ','',[rfReplaceAll]));

        end;
  end;
end;

procedure TfMain.edtValorEnter(Sender: TObject);
begin
   NameValor := TEdit(Sender).Name;
   Rectangle10.AnimateFloat('Height',75,0.3, TAnimationType.In, TInterpolationType.Circular)
end;

procedure TfMain.edtValorExit(Sender: TObject);
begin
   Rectangle10.AnimateFloat('Height',0,0.3, TAnimationType.In, TInterpolationType.Circular)
end;

procedure TfMain.AnimaFinish(Sender: TObject);
begin
   if TFloatAnimation(Sender).Tag <> -1 then
      TFloatAnimation(Sender).Tag := -1;
end;

procedure TfMain.btnAnteriorClick(Sender: TObject);
begin
   Data('R');
end;

procedure TfMain.btnProximoClick(Sender: TObject);
begin
   Data('L');
end;

procedure TfMain.CardsCategoria;
var
   layContent : TLayout;
   Card :TRectangle;
   Icone : TImage;
   txtTitulo,txtValor :TText;

begin

   Container.tabLista.Open('SELECT Descricao, '  +
                           '(SELECT Replace(printf("R$ %.2f",SUM(Valor)),".",",") AS Valor FROM Parcelas WHERE strftime("%Y-%m", DataVencimento) = ' +QuotedStr(FormatDateTime('YYYY-MM',DataNew)) + ' AND Parcelas.ID_Categoria = Categorias.ID) Valor '+
                           'FROM Categorias Order by Valor DESC,Descricao ');

   ListHCategorias.Clear;
   HorzScrollBox1.BeginUpdate;

   Container.tabLista.First;
   while not  Container.tabLista.Eof do begin
      Card := TRectangle.Create(HorzScrollBox1,TAlignLayout.Left,TAlphaColorRec.White);
      Card.Margins.Left := 20;
      Card.Padding.Top := 5;
      Card.Padding.Bottom := 5;
      Card.Width      := HorzScrollBox1.Height;
      Card.Height     := HorzScrollBox1.Height;
      Card.Stroke.Color   := TAlphaColorRec.Darkgray;
      Card.YRadius := 10;
      Card.XRadius := 10;
      Card.Sombrear;

      ListHCategorias.Add(Card);

      txtTitulo := TText.Create(Card,
                                Container.tabLista.FieldByName('Descricao').AsString,
                                10,
                                TAlphaColors.Darkgray,
                                TTextAlign.Center,
                                TTextAlign.Leading,
                                TAlignLayout.Top);

      txtValor := TText.Create(Card,
                               Container.tabLista.FieldByName('Valor').AsString,
                               12,
                               TAlphaColors.Darkgray,
                               TTextAlign.Center,
                               TTextAlign.Center,
                               TAlignLayout.Bottom);
      txtValor.Height := 15;

      layContent := TLayout.Create(Card, TAlignLayout.Contents);

      Icone := TImage.Create(layContent,
               Container.tabLista.FieldByName('Descricao').AsString.ToUpper,
               TAlignLayout.Center);
      Icone.Height := 38;
      Icone.Width := 38;

      Container.tabLista.Next
   end;
   HorzScrollBox1.EndUpdate;
end;

procedure TfMain.CarregaCategorias;
begin
   SelectCategorias('SELECT * FROM Categorias WHERE TipoMovimento ="'+
                    IfThen(Text6.Tag = 0,'R','D')+
                    '" ORDER BY Descricao',edtCategoria.Name );
end;

procedure TfMain.CarregaSubcategorias;
begin

   SelectCategorias(
                    Format('SELECT * FROM SubCategorias WHERE ID_Categoria =(SELECT ID FROM Categorias WHERE Descricao = "%s") ORDER BY Descricao ',[edtCategoria.Text]),
                    edtSubcategoria.Name);
end;

procedure TfMain.SearchEditButton2Click(Sender: TObject);
begin
   CarregaCategorias;
end;

procedure TfMain.SearchEditButton3Click(Sender: TObject);
begin
   if edtCategoria.Text <> '' then
      CarregaSubcategorias
end;

procedure TfMain.SpeedButton1Click(Sender: TObject);
begin
   TabControl1.GotoVisibleTab(0);
end;

procedure TfMain.SpeedButton3Click(Sender: TObject);
begin
   SelectDespesaReceita;
end;

procedure TfMain.Teclado;
var
   I :Integer;
   BotaoFundo : TRectangle;
   Text : TText;
   GridPanelLayout1 : TGridPanelLayout;
begin
   GridPanelLayout1 := TGridPanelLayout.Create(Rectangle10,2,6);
   Rectangle10.AddObject(GridPanelLayout1);
   Rectangle10.Fill.Color := TAlphaColors.Null;

   for I := 1 to 12 do begin
      BotaoFundo := TRectangle.Create(GridPanelLayout1,TAlignLayout.Client);
      BotaoFundo.Fill.Color := TAlphaColorRec.White;
      BotaoFundo.YRadius := 5;
      BotaoFundo.XRadius := 5;

      Text := TText.Create(BotaoFundo);
      if I = 10 then begin
         Text.Text := IntToStr(0);
         Text.Tag := 0;
      end
      else if I = 11 then begin
         Text.Text := '0,00';
         Text.Tag := 1;
      end else if I = 12 then begin
         Text.Text := '<<';
         Text.Tag := 2;
      end else begin
         Text.Text := IntToStr(I);
         Text.Tag := 0;
      end;
      Text.Align := TAlignLayout.Client;
      Text.TextSettings.FontColor := TAlphaColorRec.Darkgrey;

      Text.TextSettings.Font.Size := 12;
      Text.OnClick := NumeroClick;
      BotaoFundo.MarginAll(2);
      BotaoFundo.AddObject(Text);
      BotaoFundo.Sombrear;

      GridPanelLayout1.AddObject(BotaoFundo);
   end;

   Rectangle14.Sombrear;
end;


procedure TfMain.TecladoInteiro;
var
   I :Integer;
   BotaoFundo :TRectangle;
   Text :TText;
   GridPanelLayout1 :TGridPanelLayout;
begin
   GridPanelLayout1 := TGridPanelLayout.Create(Rectangle9,2,5);
   Rectangle9.AddObject(GridPanelLayout1);
   Rectangle9.Fill.Color := TAlphaColors.Null;

   for I := 0 to 9 do begin
      BotaoFundo := TRectangle.Create(GridPanelLayout1,TAlignLayout.Client);
      BotaoFundo.Fill.Color := TAlphaColorRec.White;

      BotaoFundo.YRadius := 5;
      BotaoFundo.XRadius := 5;

      Text := TText.Create(BotaoFundo);
      Text.Text := IntToStr(I);
      Text.Align := TAlignLayout.Client;
      Text.TextSettings.FontColor := TAlphaColorRec.Darkgrey;

      Text.TextSettings.Font.Size := 12;
      Text.OnClick := NumeroInteiroClick;
      BotaoFundo.MarginAll(1);
      BotaoFundo.AddObject(Text);
      BotaoFundo.Sombrear;

      GridPanelLayout1.AddObject(BotaoFundo);
   end;
   Rectangle14.Sombrear;
end;

procedure TfMain.Text14Click(Sender: TObject);
begin
   TabControl1.GotoVisibleTab(2);
end;

procedure TfMain.Text4Click(Sender: TObject);
var Contas :TContas;
begin

   if edtCategoria.Text = '' then begin
      CarregaCategorias;
   end else if (edtValor.Text = '') or (edtValor.Text = '0,00')then begin
      ExibeMsg('Informe um valor');
      edtValor.SetFocus;
   end else if (edtParcela.Text = '') or (edtParcela.Text = '0')then begin
      ExibeMsg('Informe quantidade de parcelas');
      edtValor.SetFocus;
   end else begin

      Contas := TContas.Create;
      Contas.ID := edtID.Text;
      Contas.Descricao := edtDescricao.Text;
      Contas.Subcategoria := edtSubcategoria.Text;
      Contas.Categoria := edtCategoria.Text;
      Contas.Vencimento := edtVencimento.Date;

      if edtPagamento.Text <> '' then
         Contas.Pagamento := edtPagamento.Date;

      Contas.ValorPago := edtValorPago.Text;
      Contas.TipoMovimento := IfThen(Text6.Tag = 0,'R','D');
      Contas.Valor := edtValor.Text;
      Contas.Parcela := StrToInt(edtParcela.Text);
      Contas.Incluir;

      DataNew := edtVencimento.Date;

      Data('U');
      ExibeMsg(Text6.text + ' incluída com sucesso');

      LancarDespesaReceita;
      TabControl1.GotoVisibleTab(0);
   end;
end;

procedure TfMain.Text5Click(Sender: TObject);
begin
   StatusBarColor(TAlphaColors.Crimson);
   retTopo.Color(TAlphaColors.Crimson);
end;

procedure TfMain.VertScrollBox2ViewportPositionChange(Sender: TObject;
  const OldViewportPosition, NewViewportPosition: TPointF;
  const ContentSizeChanged: Boolean);
begin
   Circle1.Visible :=  (NewViewportPosition.Y = 0);
end;

procedure TfMain.Voltar;
begin
    if TabControl1.ActiveTab = TabReceitaDespesa then begin
       TabControl1.GotoVisibleTab(0)
    end else if TabControl1.ActiveTab = TabHome then begin
       TDialogService.MessageDialog('Sair do aplicativo?',
         system.UITypes.TMsgDlgType.mtConfirmation,
         [system.UITypes.TMsgDlgBtn.mbYes, system.UITypes.TMsgDlgBtn.mbNo],
         system.UITypes.TMsgDlgBtn.mbYes,0,
         procedure (const AResult: System.UITypes.TModalResult)
         begin
            case AResult of
               mrYES: Close;
            end;
         end);
    end;
end;

{ THelperForm }

procedure THelperForm.Aviso(Msg, Botao1, Botao2: String);
begin

end;

procedure THelperForm.ExibeMsg(msg: String);
var
   L :TLayout;
   R :TRectangle;
   AnimaEntrada,AnimaSaida :TFloatAnimation;


   T : TText;
begin

   NameComponent := 'TabControl1';

   FundoOpaco := TRectangle.Create(Self);
   FundoOpaco.Name := 'FundoOpaco';
   FundoOpaco.Hint := 'Fundo Opaco';
   FundoOpaco.Fill.Color := TAlphaColorRec.Black;
   FundoOpaco.Stroke.Color := TAlphaColorRec.Null;
   FundoOpaco.Stroke.Thickness := 0;
   FundoOpaco.Opacity := 0.5;
   FundoOpaco.OnClick := ExitAviso;
   FundoOpaco.Align := TAlignLayout.Contents;
   Self.AddObject(FundoOpaco);

   L := TLayout.Create(Self);
   L.Size.Width := Self.Width;
   L.Size.Height := Self.Height;
   L.Size.PlatformDefault := False;
   L.Position.X := 0;
   L.Position.Y := 0;
   L.Align := TAlignLayout.Client;

   L.HitTest := False;
   ListLayout.Add(L);
   R := TRectangle.Create(L,TAlignLayout.None,TAlphaColors.White);
   R.Position.Y :=  L.Size.Height;
   R.Size.Width := L.Size.Width;
   R.Size.Height := 60;
   R.Size.PlatformDefault := False;
   R.PaddingAll(10);

   L.AddObject(R);
   R.Anchors := [TAnchorKind.akLeft, TAnchorKind.akRight, TAnchorKind.akBottom];

   Self.AddObject(L);

   AnimaEntrada := TFloatAnimation.Create(R,0.2,0,L.Height - R.Height, True, 'Position.Y', 0);

   ListAnimaEntrada.Add(AnimaEntrada);


   {inicio codigo}

   T := TText.Create(R, msg, 12, TAlphaColors.Darkgray);
   T.HitTest := False;

   {fim codigo}


   AnimaEntrada.Start;

   AnimaSaida := TFloatAnimation.Create(R,0.5,0,L.Height,True,'Position.Y',3);
   ListAnimaSaida.Add(AnimaSaida);
   R.Tag := ListAnimaSaida.Count-1;
   L.Tag := ListAnimaSaida.Count-1;
   FundoOpaco.Tag := L.Tag;

   AnimaSaida.OnFinish := ExitFinish;
   AnimaSaida.Start;


end;

procedure THelperForm.ExitAviso(Sender: TObject);
begin
   ListAnimaSaida.Items[TRectangle(Sender).Tag].Delay := 0.1;
   ListAnimaSaida.Items[TRectangle(Sender).Tag].Duration := 0.2;
   ListAnimaSaida.Items[TRectangle(Sender).Tag].Start;
   ListAnimaSaida.Items[TRectangle(Sender).Tag].OnFinish := ExitFinish;

   if FindComponent(NameComponent) <> nil then begin

      if AnsiUpperCase(TRectangle(Sender).Hint) = 'ADICIONAR RECEITA' then begin
         TText(FindComponent('Text6')).Text := 'Nova Receita';
         TText(FindComponent('Text6')).Tag := 0;
         TRectangle(FindComponent('Rectangle4')).Fill.Color := TAlphaColors.Darkgreen;
         LancarDespesaReceita;
      end else if AnsiUpperCase(TRectangle(Sender).Hint) = 'ADICIONAR DESPESA' then begin
         TText(FindComponent('Text6')).Text := 'Nova Despesa';
         TText(FindComponent('Text6')).Tag := 1;
         TRectangle(FindComponent('Rectangle4')).Fill.Color := TAlphaColors.Tomato;
         LancarDespesaReceita;
      end else if AnsiUpperCase(TRectangle(Sender).Hint) = 'FUNDO OPACO' then begin

      end else
          TEdit(FindComponent(NameComponent)).Text := TRectangle(Sender).Hint;
   end;


end;

procedure THelperForm.ExitFinish(Sender: TObject);
begin
   ListLayout.Clear;
   TRectangle(FindComponent('FundoOpaco')).DisposeOf;

end;


procedure THelperForm.LancarDespesaReceita;
begin
   TEdit(FindComponent('edtID')).Text := '';
   TEdit(FindComponent('edtSubcategoria')).Text := '';
   TEdit(FindComponent('edtCategoria')).Text := '';
   TEdit(FindComponent('edtParcela')).Text := '1';

   TEdit(FindComponent('edtValor')).Hint := '0,00';
   TEdit(FindComponent('edtValor')).Text := '0,00';

   TEdit(FindComponent('edtValorPago')).Hint := '0,00';
   TEdit(FindComponent('edtValorPago')).Text := '0,00';

   TDateEdit(FindComponent('edtVencimento')).Date := Date;
   TDateEdit(FindComponent('edtPagamento')).Text := '';
   TEdit(FindComponent('edtDescricao')).Text := '';
   TTabControl(FindComponent('TabControl1')).GotoVisibleTab(1)

end;

procedure THelperForm.SelectCategorias(sql :String; sNameComponent :string);
var
   L :TLayout;
   R,R1 :TRectangle;
   AnimaEntrada,AnimaSaida :TFloatAnimation;
   Lista :TVertScrollBox;
   T : TText;
begin

   Container.tabCategorias.Open(sql);
   if (Container.tabCategorias.RecordCount = 0)  then begin
      ExibeMsg('Nenhuma sub-categoria para "'+TEdit(FindComponent(NameComponent)).Text+'"');
      Abort;
   end;

   NameComponent := sNameComponent;

   FundoOpaco := TRectangle.Create(Self);
   FundoOpaco.Name := 'FundoOpaco';
   FundoOpaco.Hint := 'Fundo Opaco';

   FundoOpaco.Fill.Color := TAlphaColorRec.Black;
   FundoOpaco.Stroke.Color := TAlphaColorRec.Null;
   FundoOpaco.Stroke.Thickness := 0;
   FundoOpaco.Opacity := 0.5;
   FundoOpaco.OnClick := ExitAviso;
   FundoOpaco.Align := TAlignLayout.Contents;
   Self.AddObject(FundoOpaco);

   L := TLayout.Create(Self);
   L.Size.Width := Self.Width;
   L.Size.Height := Self.Height;
   L.Size.PlatformDefault := False;
   L.Position.X := 0;
   L.Position.Y := 0;
   L.Align := TAlignLayout.Client;

   L.HitTest := False;
   ListLayout.Add(L);

   R := TRectangle.Create(L);
   R.Fill.Color := TAlphaColors.White;
   R.Position.Y :=  L.Size.Height;
   R.Size.Width := L.Size.Width;
   R.Size.Height :=  L.Size.Height - (L.Size.Height/3) ;
   R.Size.PlatformDefault := False;
   R.Stroke.Color := TAlphaColors.White;
   R.PaddingAll(10);

   L.AddObject(R);
   R.Anchors := [TAnchorKind.akLeft, TAnchorKind.akRight, TAnchorKind.akBottom];

   Self.AddObject(L);

   AnimaEntrada := TFloatAnimation.Create(R,0.2,0,L.Height - R.Height, True, 'Position.Y', 0);

   ListAnimaEntrada.Add(AnimaEntrada);

   {$IF DEFINED(MSWINDOWS)}

   {$ENDIF}

   Lista := TVertScrollBox.Create(R);
   R.AddObject(Lista);
   Lista.Align := TAlignLayout.Client;
   Lista.Size.PlatformDefault := False;
   Lista.ShowScrollBars := False;
   Lista.BeginUpdate;

   Container.tabCategorias.First;
   while not Container.tabCategorias.eof do begin

      R1 := TRectangle.Create(Lista,TAlignLayout.Top,Container.tabCategorias.Fields[1].AsString);
      R1.HitTest := True;
      R1.Tag := ListAnimaSaida.Count;
      ListCategorias.Add(R1);
      R1.OnClick :=  ExitAviso;

      R1.Margins.Bottom := 5;
      R1.Sombrear;

      T := TText.Create(R1, Container.tabCategorias.Fields[1].AsString, 12, TAlphaColors.Darkgray);
      T.HitTest := False;

      Container.tabCategorias.Next;
   end;
   Lista.EndUpdate;


   AnimaEntrada.Start;

   AnimaSaida := TFloatAnimation.Create(R,0.5,0,L.Height ,True,'Position.Y',3);
   ListAnimaSaida.Add(AnimaSaida);

   R.Tag := ListAnimaSaida.Count-1;
   L.Tag := ListAnimaSaida.Count-1;
   FundoOpaco.Tag := ListAnimaSaida.Count-1;

end;

procedure THelperForm.SelectContas(sql: String);
begin

end;

procedure THelperForm.SelectDespesaReceita;
var
   L :TLayout;
   R,R1 :TRectangle;
   AnimaEntrada,AnimaSaida :TFloatAnimation;
   Lista :TVertScrollBox;
   T : TText;
begin

   NameComponent := 'TabControl1';

   FundoOpaco := TRectangle.Create(Self);
   FundoOpaco.Name := 'FundoOpaco';
   FundoOpaco.Hint := 'Fundo Opaco';
   FundoOpaco.Fill.Color := TAlphaColorRec.Black;
   FundoOpaco.Stroke.Color := TAlphaColorRec.Null;
   FundoOpaco.Stroke.Thickness := 0;
   FundoOpaco.Opacity := 0.5;
   FundoOpaco.OnClick := ExitAviso;
   FundoOpaco.Align := TAlignLayout.Contents;
   Self.AddObject(FundoOpaco);

   L := TLayout.Create(Self);
   L.Size.Width := Self.Width;
   L.Size.Height := Self.Height;
   L.Size.PlatformDefault := False;
   L.Position.X := 0;
   L.Position.Y := 0;
   L.Align := TAlignLayout.Client;

   L.HitTest := False;
   ListLayout.Add(L);
   R := TRectangle.Create(L,TAlignLayout.None,TAlphaColors.White);
   R.Position.Y :=  L.Size.Height;
   R.Size.Width := L.Size.Width;
   R.Size.Height := 120;// L.Size.Height - (L.Size.Height/5) ;
   R.Size.PlatformDefault := False;
   R.PaddingAll(10);
   R.OnClick :=  ExitAviso;

   L.AddObject(R);
   R.Anchors := [TAnchorKind.akLeft, TAnchorKind.akRight, TAnchorKind.akBottom];

   Self.AddObject(L);

   AnimaEntrada := TFloatAnimation.Create(R,0.2,0,L.Height - R.Height, True, 'Position.Y', 0);

   ListAnimaEntrada.Add(AnimaEntrada);


   {inicio codigo}
   Lista := TVertScrollBox.Create(R);
   R.AddObject(Lista);
   Lista.Align := TAlignLayout.Client;
   Lista.Size.PlatformDefault := False;
   Lista.ShowScrollBars := False;
   Lista.BeginUpdate;

   Container.tabCategorias.Open('SELECT "Adicionar Receita" Conta '+
                                 'UNION '+
                                 'SELECT "Adicionar Despesa" Conta ');
   Container.tabCategorias.First;
   while not Container.tabCategorias.eof do begin

      R1 := TRectangle.Create(Lista,TAlignLayout.Top,
                              Container.tabCategorias.Fields[0].AsString);
      R1.HitTest := True;
      R1.Tag := ListAnimaSaida.Count;
      ListCategorias.Add(R1);
      R1.OnClick :=  ExitAviso;

      R1.Margins.Bottom := 5;
      R1.Sombrear;

      T := TText.Create(R1, Container.tabCategorias.Fields[0].AsString, 12, TAlphaColors.Darkgray);
      T.HitTest := False;

      Container.tabCategorias.Next;
   end;
   Lista.EndUpdate;
   {fim codigo}


   AnimaEntrada.Start;

   AnimaSaida := TFloatAnimation.Create(R,0.5,0,L.Height,True,'Position.Y',3);
   ListAnimaSaida.Add(AnimaSaida);
   R.Tag := ListAnimaSaida.Count-1;
   L.Tag := ListAnimaSaida.Count-1;
   FundoOpaco.Tag := L.Tag;
   //AnimaSaida.Start;


end;


end.
