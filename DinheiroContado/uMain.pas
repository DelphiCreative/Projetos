unit uMain;

interface

uses
  FMX.MultiResBitmap, System.UIConsts,
  System.Permissions, System.JSON,  System.Threading,
  FMX.VirtualKeyboard, FMX.DialogService.Async,FMX.DialogService,
  FMX.Ani,System.StrUtils,  System.Generics.Collections, FMX.Platform,
  System.SysUtils,DateUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  Data.DB,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Layouts,
  FMX.Objects, FMX.TabControl, FMX.Edit, FMX.Colors, System.ImageList,
  FMX.ImgList, FMX.Calendar, FMX.DateTimeCtrls, FMX.Effects, System.Actions,
  FMX.ActnList, FMX.MultiView, FMX.StdActns, FMX.MediaLibrary.Actions, System.Skia,
  FMX.Skia;

type
  THelperForm = class helper for TForm
     procedure ExibeMsg(AMsg:String);
     procedure LancarDespesaReceita;
     procedure SelectDespesaReceita;
     procedure SelectCategorias(ASQL :String; ANameComponent :string);
     procedure ExitAviso(Sender: TObject);
     procedure ExitFinish(Sender: TObject);

     function CreateRctFundoOpaco(Parent: TComponent; const Name, Hint: string;
        Color: TAlphaColor; Opacity: Single; OnClickEvent: TNotifyEvent): TRectangle;
  end;


type
  TfMain = class(TForm)
    TabControl1: TTabControl;
    tbiHome: TTabItem;
    tbiReceitaDespesa: TTabItem;
    Rectangle1: TRectangle;
    rctTopo: TRectangle;
    VertScrollBox1: TVertScrollBox;
    Rectangle3: TRectangle;
    btnAnterior: TSpeedButton;
    btnProximo: TSpeedButton;
    layMes: TLayout;
    rctFundoMes: TRectangle;
    rctReceitaDespesa: TRectangle;
    txtTipoMovimento: TText;
    rctFundoLancamento: TRectangle;
    edtCategoria : TEdit;
    lblCategoria: TText;
    ImageList1: TImageList;
    Line2: TLine;
    Rectangle6: TRectangle;
    btnBuscarCategoria: TSearchEditButton;
    lblSubCategoria: TText;
    edtSubcategoria: TEdit;
    btnBuscarSubCategoria: TSearchEditButton;
    Line3: TLine;
    gplParcelas: TGridPanelLayout;
    layParcelas: TLayout;
    edtParcela: TEdit;
    Line4: TLine;
    lblParcelas: TLabel;
    rctTeclado: TRectangle;
    rctLimparParcelas: TRectangle;
    lblLimparParcela: TLabel;
    rctTecladoInteiro: TRectangle;
    SpeedButton1: TSpeedButton;
    ShadowEffect1: TShadowEffect;
    lblDescricao: TText;
    edtDescricao: TEdit;
    Line5: TLine;
    rctDescricao: TRectangle;
    rctCategoria: TRectangle;
    rctSubCategoria: TRectangle;
    rctParcelas: TRectangle;
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
    Rectangle14: TRectangle;
    Text8: TText;
    edtID: TEdit;
    Line6: TLine;
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
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    rctBotaoSalvar: TRectangle;
    lblSalvar: TSkLabel;
    btnSalvar: TSpeedButton;
    tbiCategoria: TTabItem;
    Rectangle12: TRectangle;
    SkLabel1: TSkLabel;
    SpeedButton2: TSpeedButton;
    ShadowEffect5: TShadowEffect;
    Rectangle29: TRectangle;
    Text4: TText;
    edtEditCategoria: TEdit;
    SearchEditButton1: TSearchEditButton;
    Line7: TLine;
    Rectangle30: TRectangle;
    Text18: TText;
    SpeedButton4: TSpeedButton;
    Rectangle31: TRectangle;
    Rectangle32: TRectangle;
    Text19: TText;
    HorzScrollBox: THorzScrollBox;
    Rectangle33: TRectangle;
    Text21: TText;
    Layout8: TLayout;
    Rectangle34: TRectangle;
    GridPanelLayout5: TGridPanelLayout;
    Circle2: TCircle;
    Circle4: TCircle;
    btnAdicionar: TSpeedButton;
    shaAdicionar: TShadowEffect;
    Layout3: TLayout;
    Rectangle35: TRectangle;
    SkLabel2: TSkLabel;
    skSaldo: TSkLabel;
    GridPanelLayout6: TGridPanelLayout;
    Rectangle36: TRectangle;
    Image1: TImage;
    Layout9: TLayout;
    SkLabel4: TSkLabel;
    skReceita: TSkLabel;
    Rectangle37: TRectangle;
    Image6: TImage;
    Layout10: TLayout;
    skDespesas: TSkLabel;
    skDespesa: TSkLabel;
    btnExcluirMovimento: TSpeedButton;
    rctDatas: TRectangle;
    gplDatas: TGridPanelLayout;
    Rectangle25: TRectangle;
    lblPagamento: TText;
    edtPagamento: TDateEdit;
    Rectangle16: TRectangle;
    lblVencimento: TText;
    edtVencimento: TDateEdit;
    rctTrocaData: TRectangle;
    imgTrocaData: TImage;
    btnTrocaData: TSpeedButton;
    rctValores: TRectangle;
    gplValores: TGridPanelLayout;
    rctTrocaValor: TRectangle;
    imgTrocaValor: TImage;
    btnTrocaValor: TSpeedButton;
    Rectangle18: TRectangle;
    lblValor: TLabel;
    edtValor: TEdit;
    Line1: TLine;
    rctValorPago: TRectangle;
    lblValorPago: TLabel;
    edtValorPago: TEdit;
    Line8: TLine;
    layHome: TLayout;
    svgHome: TSkSvg;
    lblHome: TSkLabel;
    layChart: TLayout;
    svgChart: TSkSvg;
    lblChart: TSkLabel;
    layExit: TLayout;
    svgExit: TSkSvg;
    lblExit: TSkLabel;
    btnHome: TSpeedButton;
    btnChart: TSpeedButton;
    btnExit: TSpeedButton;
    tbcHome: TTabControl;
    TabItem1: TTabItem;
    Text15: TText;
    hsbCategorias: THorzScrollBox;
    vsbListaMensal: TVertScrollBox;
    tbiChart: TTabItem;
    Rectangle8: TRectangle;
    Rectangle2: TRectangle;
    Layout13: TLayout;
    vsbCategoriaPorc: TVertScrollBox;
    Rectangle7: TRectangle;
    SkLabel8: TSkLabel;
    layMultiSelecao: TLayout;
    rctMultiSelecao: TRectangle;
    layMultiSelecaoImg: TLayout;
    crcMultiSelecaoImg: TCircle;
    imgMultiSelecao: TImage;
    Layout19: TLayout;
    sklTotal: TSkLabel;
    layLiquidarMultiplos: TLayout;
    rctLiquidarMultiplos: TRectangle;
    SkLabel10: TSkLabel;
    ShadowEffect6: TShadowEffect;
    btnLiquidarMultiplos: TSpeedButton;
    layExcluirMultiplos: TLayout;
    rctExcluirMultiplos: TRectangle;
    SkLabel11: TSkLabel;
    ShadowEffect7: TShadowEffect;
    btnExcluirMultiplos: TSpeedButton;
    layCustomize: TLayout;
    svgCustomize: TSkSvg;
    lblCustomize: TSkLabel;
    btnCustomize: TSpeedButton;
    ShadowEffect4: TShadowEffect;
    ShadowEffect8: TShadowEffect;
    tbiConsulta: TTabItem;
    VertScrollBox2: TVertScrollBox;
    procedure layMesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure Text5Click(Sender: TObject);
    procedure btnBuscarCategoriaClick(Sender: TObject);
    procedure btnBuscarSubCategoriaClick(Sender: TObject);
    procedure edtValorEnter(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure edtParcelaExit(Sender: TObject);
    procedure edtParcelaEnter(Sender: TObject);
    procedure lblLimparParcelaClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edtCategoriaChangeTracking(Sender: TObject);
    procedure Rectangle6Click(Sender: TObject);
    procedure Text14Click(Sender: TObject);
    procedure vsbListaMensalViewportPositionChange(Sender: TObject;
      const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Voltar;
    procedure LoadPhoto(tag: Integer; descricao : String);
    procedure btnSalvarClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Text4Click(Sender: TObject);
    procedure CircleClick(Sender: TObject);
    procedure CircleCoresClick(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure edtEditCategoriaChangeTracking(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTrocaDataClick(Sender: TObject);
    procedure btnTrocaValorClick(Sender: TObject);
    procedure btnHomeClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure btnChartClick(Sender: TObject);
    function CreateJsonChart(DataSet: TDataSet; AField, AValue, AColor :String) : String;
    procedure btnExitClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ShowGraph(ALayout: TLayout; AJSON :String);
    procedure tbcHomeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure MultiSelect;
    procedure MultiSelectCheck;
    procedure btnLiquidarClick(Sender: TObject);
    procedure btnLiquidarMultiplosClick(Sender: TObject);
    procedure btnExcluirMultiplosClick(Sender: TObject);
    procedure btnExcluirMovimentoClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

    DataNew,DataOld :TDate;

    fAppPermissions: TArray<string>;
    procedure StartTakePhotoFromLibOnAndroid;
    procedure RequestPermissionsResultEvent(Sender: TObject;
      const APermissions: TClassicStringDynArray;
      const AGrantResults: TClassicPermissionStatusDynArray);
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
    procedure LoadImagesIntoFlowLayout;
    procedure CreateColorSelector;
    function ColorSelect : TAlphaColor; overload;
    function ColorSelect(ACor: TAlphaColor) : TAlphaColor; overload;

    function IconeSelect : String; overload;
    function IconeSelect(AText:string): String; overload;

    procedure IconeClick(Sender: TObject);
    procedure IconeExcluirClick(Sender: TObject);
    procedure IconeEditarClick(Sender: TObject);
    procedure NumeroClick(Sender : TObject);
    procedure NumeroInteiroClick(Sender : TObject);

    procedure ExcluirContas(AId: String);
    procedure AnimaGraph;

  end;

var
  fMain: TfMain;
  vParcela, ID_Parcela :String;
  NameComponent, NameValor :String;
  rctFundoOpaco :TRectangle;
  //key12345677
implementation

{$R *.fmx}

uses
{$IFDEF ANDROID}
  Androidapi.Helpers, Androidapi.JNI.Os, Androidapi.JNI.JavaTypes,
{$ENDIF}
  System.IOUtils,
  uContainer, FMX.Helpers.Layouts, FMX.Helpers.Text,
  FMX.Functions, FMX.Helpers.Image, FMX.Helpers.FloatAnimation, uContas,
   uCards, uSettings, Chart4Delphi,
   uChart,
   fraItemHome, uItemHome;

var
   LayoutPrincipal : TControl;

procedure TfMain.Data(Direction: String);
var
   R, rctDespesas, rctPagar, rctReceber, rctReceitas :TRectangle;
   lblMes : TSkLabel;
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

      layMes.Hint := FormatDateTime('YYYY-MM-DD',DataNew);

      R := TRectangle.Create(Self,TAlphaColors.Null);

      lblMes := TSkLabel.Create(R);
      lblMes.Align := TAlignLayout.Client;
      lblMes.StyledSettings := [TStyledSetting.Family];
      lblMes.TextSettings.Font.Size := 15;
      lblMes.TextSettings.Font.Weight := TFontWeight.Semibold;
      lblMes.TextSettings.FontColor := TAlphaColorRec.White;
      lblMes.TextSettings.HorzAlign := TSkTextHorzAlign.Center;
      lblMes.Words.Add.Text := Mes;
      R.AddObject(lblMes);

      Container.tabConsulta.Open(Container.FDScript2.SQL(1).Replace('?',FormatDateTime('YYYY-MM',DataNew)));

      rctDespesas := TRectangle.Create(Self,TAlphaColors.Null);

      txtDespesas := TText.Create(rctDespesas,
                                  Container.tabConsulta.Fields[1].AsString,
                                  14,
                                  TAlphaColors.Darkgrey,
                                  TAlignLayout.Client
                                  );
      txtDespesas.Bold;

      rctReceitas := TRectangle.Create(Self,TAlphaColors.Null);

      txtReceitas := TText.Create(rctReceitas,
                                  Container.tabConsulta.Fields[0].AsString,
                                  14,
                                  TAlphaColors.Darkgrey,
                                  TAlignLayout.Client
                                  );
      txtReceitas.Bold;

      rctPagar := TRectangle.Create(Self,TAlphaColors.Null);

      txtPagar := TText.Create(rctPagar,
                                  Container.tabConsulta.Fields[3].AsString,
                                  14,
                                  TAlphaColors.Darkgrey,
                                  TAlignLayout.Client
                                  );
      txtPagar.Bold;

      rctReceber := TRectangle.Create(Self,TAlphaColors.Null);

      txtReceber := TText.Create(rctReceber,
                                  Container.tabConsulta.Fields[2].AsString,
                                  14,
                                  TAlphaColors.Darkgrey,
                                  TAlignLayout.Client
                                  );
      txtReceber.Bold;

      skReceita.Text := Container.tabConsulta.Fields[0].AsString;
      skDespesa.Text := Container.tabConsulta.Fields[1].AsString;
      skSaldo.Text := Container.tabConsulta.Fields[4].AsString;

      Container.tabLista.Open(Container.FDScript2.SQL(0) +' AND strftime("%Y-%m", DataVencimento) = ' +QuotedStr(FormatDateTime('YYYY-MM',DataNew)) + ' GROUP BY P.ID ORDER BY Categoria' );

      if (direction = 'L') or (direction = 'R') then begin
         layMes.AnimaCard(R,direction);
      end else begin
         layMes.AnimaCard(R);
      end;

      LayoutDespesas.AnimaCard(rctDespesas);
      LayoutReceitas.AnimaCard(rctReceitas);
      LayoutPagar.AnimaCard(rctPagar);
      LayoutReceber.AnimaCard(rctReceber);

      if (direction <> 'A') then
         ListarContas;
   end;

   TAnimator.AnimateFloatDelay( layMultiSelecao , 'Height',0, 0.2, 0.2, TAnimationType.InOut, TInterpolationType.Circular);
   TAnimator.AnimateFloatDelay( Layout8, 'Height',72, 0.2, 0.2, TAnimationType.InOut, TInterpolationType.Circular);

end;

procedure TfMain.edtCategoriaChangeTracking(Sender: TObject);
begin
   edtSubcategoria.Text := '';
end;

procedure TfMain.edtEditCategoriaChangeTracking(Sender: TObject);
begin
   if edtEditCategoria.Text <> '' then begin
      Container.TabExecute.Open('SELECT * FROM Categorias WHERE ID = '+ IDCategoria);

      if Container.TabExecute.FieldByName('IconeCor').AsString <> '' then
         ColorSelect(StringToAlphaColor('$'+Container.TabExecute.FieldByName('IconeCor').AsString));

      IconeSelect(Container.TabExecute.FieldByName('Icone').AsString);
   end;
end;

procedure TfMain.edtParcelaEnter(Sender: TObject);
begin
   rctTecladoInteiro.AnimateFloat('Height',75,0.3, TAnimationType.In, TInterpolationType.Circular)
end;

procedure TfMain.edtParcelaExit(Sender: TObject);
begin
   rctTecladoInteiro.AnimateFloat('Height',0,0.3, TAnimationType.In, TInterpolationType.Circular)
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FrameList.Free;
   ListIcones.Free;
   ListCores.Free;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin

   StatusBarColor(rctTopo.Fill.Color);
   fMain.Fill.Color := rctTopo.Fill.Color;

   ImageList := ImageList1;
   imgMultiSelecao.ImageByName('ACEITAR');

   Teclado;
   TecladoInteiro;

   TabControl1.GotoVisibleTab(0);
   tbcHome.GotoVisibleTab(0);
   TabControl1.TabPosition := TTabPosition.None;

   LayoutPrincipal := TLayout(Self.Parent);

   {$IFDEF ANDROID}
   edtParcela.ReadOnly := True;
   edtValor.ReadOnly := True;
   edtValorPago.ReadOnly := True;

   fAppPermissions := [
     JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE),
     JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE)];

   //ShowMessage('As permissões do aplicativo são: ' + #13#10 + string.Join(', ', fAppPermissions));
   {$ENDIF}
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

procedure TfMain.StartTakePhotoFromLibOnAndroid;
begin
  PermissionsService.RequestPermissions(fAppPermissions,
    RequestPermissionsResultEvent);
end;
procedure TfMain.RequestPermissionsResultEvent(Sender: TObject;
  const APermissions: TClassicStringDynArray;
  const AGrantResults: TClassicPermissionStatusDynArray);
begin
  //
end;

procedure TfMain.IconeClick(Sender: TObject);
var status :string;
begin

   Container.SQLite.ExecSQL('UPDATE Parcelas '+
                            'SET  '+
                            ' DataPagamento = IIF(DataPagamento IS NULL, strftime("%Y-%m-%d",DateTime()),NULL),'+
                            ' ValorPago = IIF(DataPagamento IS NULL, Valor, NULL) '+
                            ' WHERE ID = '+ TImage(Sender).Tag.ToString );

   status := Container.SQLite.ExecSQLScalar('SELECT IIF(DataPagamento IS NOT NULL, "LIQUIDADA",IIF( strftime("%Y/%m/%d", DataVencimento) < strftime("%Y/%m/%d", Datetime()), "ATRASADA", "ABERTA"))Status FROM parcelas  WHERE ID = '+ TImage(Sender).Tag.ToString );
   if status = 'LIQUIDADA' then
      ExibeMsg('Conta liquidada')
   else
      ExibeMsg('Pagamento cancelado');

   TImage(Sender).ImageByName(status);

   Data('A')

end;


procedure TfMain.IconeExcluirClick(Sender: TObject);
begin

   ExcluirContas(TImage(Sender).Tag.ToString);

   ExibeMsg('Conta excluída');

end;


procedure TfMain.IconeEditarClick(Sender: TObject);
var sql :String;
begin
   Container.tabContas.Open(Container.FDScript2.SQL(0) + ' AND P.ID ='+ TImage(Sender).Tag.ToString);

   edtID.Text := TImage(Sender).Tag.ToString;
   edtDescricao.Text := Container.tabContas.FieldByName('Descricao_Parcela').AsString;
   edtCategoria.Text := Container.tabContas.FieldByName('Categoria').AsString;
   edtSubcategoria.Text := Container.tabContas.FieldByName('SubCategoria').AsString;
   edtVencimento.Text := Container.tabContas.FieldByName('Vencimento').AsString;
   edtParcela.Text := Container.tabContas.FieldByName('NParcela').AsString;
   edtPagamento.Text := Container.tabContas.FieldByName('Pagamento').AsString;
   edtValor.Hint := FormatFloat('#,##0.00', Container.tabContas.FieldByName('ValorParcela').AsFloat);
   edtValor.Text := edtValor.Hint;

   if Container.tabContas.FieldByName('ValorPago').AsString <> '' then
      edtValorPago.Hint :=  FormatFloat('#,##0.00', Container.tabContas.FieldByName('ValorPago').AsFloat)
   else
      edtValorPago.Hint := '';

   if Container.tabContas.FieldByName('TipoMovimento').AsString = 'R' then begin
      txtTipoMovimento.Text := 'Receita';
      txtTipoMovimento.Tag := 0;
      StatusBarColor([rctReceitaDespesa,rctBotaoSalvar], ColorReceber);
      fMain.Fill.Color := ColorReceber;

   end else begin
      txtTipoMovimento.Text := 'Despesa';
      txtTipoMovimento.Tag := 1;
      StatusBarColor([rctReceitaDespesa,rctBotaoSalvar], ColorPagar);
      fMain.Fill.Color := ColorPagar;
   end;

   edtValorPago.Text :=  edtValorPAgo.Hint;

   btnExcluirMovimento.Tag := TImage(Sender).Tag;
   btnExcluirMovimento.OnClick := IconeExcluirClick;
   btnExcluirMovimento.Visible := True;

   Container.tabContas.Open(Container.FDScript2.SQL(0) + ' AND P.ID_Conta = '+ Container.tabContas.FieldByName('ID_Conta').AsString);

   TabControl1.GotoVisibleTab(1)
end;

procedure TfMain.layMesClick(Sender: TObject);
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
begin
  ListContas.Clear;
end;

procedure TfMain.ListarContas(ASimples: Boolean = False);
var
   I : Integer;
   layMain: TLayout;
   Anima : TFloatAnimation;
   rctItem :TRectangle;
   Color :TAlphaColor;
   strIcone : string;

   Item : TfraItemHome;

begin

   I := 0;
   LimparLista;
   FrameList.Clear;
   Container.tabLista.First;
   vsbListaMensal.BeginUpdate;
   while not  Container.tabLista.Eof do begin
      layMain := TLayout.Create(vsbListaMensal);
      layMain.Height := 70;
      layMain.Position.X := 0;
      layMain.Width := Self.Width;
      layMain.Tag := I;
      layMain.Align := TAlignLayout.Top;
      ListContas.Add(layMain);

      vsbListaMensal.AddObject(layMain);

      rctItem := TRectangle.Create(layMain);
      rctItem.Fill.Color   := TAlphaColorRec.Null;
      rctItem.Stroke.Color   := TAlphaColorRec.Darkgray;
      rctItem.PositionXY(layMain.Width *(I+1),2);
      rctItem.Width := layMain.Width - 20;
      rctItem.Height := layMain.Height - 4;
      rctItem.Tag := I;
      rctItem.MarginAll(2);
      rctItem.Padding.Rect := TRectF.Create(0,0,5,0);
      rctItem.Sombrear;
      layMain.AddObject(rctItem);

      Anima := TFloatAnimation.Create(rctItem,0.3,rctItem.Width ,10, True, 'Position.X', 0);

      Item := TfraItemHome.Create(Self, Container.tabLista);
      Item.Name := 'f'+Container.tabLista.FieldByName('ID').AsString;
      Item.imgEditar.OnClick := IconeEditarClick;
      rctItem.AddObject(Item.Rectangle1);

      Anima.Tag := I;
      Anima.Interpolation := TInterpolationType.Linear;

      rctItem.AddObject(Anima);

      FrameList.Add(Item);
      ListaAnima.Add(Anima);
      Anima.Start;

      Inc(I);

      Container.tabLista.Next
   end;
   vsbListaMensal.EndUpdate;
   CardsCategoria;
end;

procedure TfMain.LoadPhoto(tag: Integer; descricao: String);
begin

    if PermissionsService.IsPermissionGranted('android.permission.READ_EXTERNAL_STORAGE') then
    begin

    TDialogService.MessageDialog('Gostaria de personalizar uma imagem?',
         system.UITypes.TMsgDlgType.mtConfirmation,
         [system.UITypes.TMsgDlgBtn.mbYes, system.UITypes.TMsgDlgBtn.mbNo],
         system.UITypes.TMsgDlgBtn.mbYes,0,
         procedure (const AResult: System.UITypes.TModalResult)
         begin
            case AResult of
               mrYES: Begin
                   TakePhotoFromLibraryAction1.Tag  := tag;
                   TakePhotoFromLibraryAction1.Hint := descricao;
                   TakePhotoFromLibraryAction1.Execute;
               End;
            end;
         end);
  end;

end;

procedure TfMain.MultiSelect;
var
  I: Integer;
  strIDs :TStringBuilder;
  img, imgEditar :TImage;
  valor : Double;
  txtValor : TSkLabel;
  sinHeight :Single;
begin

   strIDs := TStringBuilder.Create;
   for I := 0 to FrameList.Count - 1 do begin

      img := TImage(FrameList.Items[I].FindComponent('imgIcone'));

      if img.Tag = 1 then begin
          imgEditar := TImage(FrameList.Items[I].FindComponent('imgEditar'));
          txtValor := TSkLabel	(FrameList.Items[I].FindComponent('txtValor'));
          valor := valor + StrtoFloat(txtValor.Text.Replace('R$','').Replace(' ',''));
          strIDs.Append(IntTostr(imgEditar.Tag)+',');
      end;
   end;

   sklTotal.Text := 'Total R$ ' + FormatFloat('#,##0.00',(valor));

   if LeftStr(strIDs.ToString,strIDs.Length -1) <> '' then
      sinHeight := 55
   else
      sinHeight := 0;

   btnLiquidarMultiplos.Hint := LeftStr(strIDs.ToString,strIDs.Length -1);
   btnExcluirMultiplos.Hint := LeftStr(strIDs.ToString,strIDs.Length -1);

   TAnimator.AnimateFloatDelay( layMultiSelecao, 'Height',sinHeight, 0.2, 0.2, TAnimationType.InOut, TInterpolationType.Circular);

   if sinHeight = 0 then
      TAnimator.AnimateFloatDelay( Layout8, 'Height',72, 0.2, 0.2, TAnimationType.InOut, TInterpolationType.Circular)
   else
      TAnimator.AnimateFloatDelay( Layout8, 'Height',0, 0.2, 0.2, TAnimationType.InOut, TInterpolationType.Circular)
end;

procedure TfMain.MultiSelectCheck;
begin
//   for I := 0 to FormList.Count - 1 do begin
//
//      img := TImage(FormList.Items[I].FindComponent('imgIcone'));
//
//      if img.Tag = 1 then begin
//          imgEditar := TImage(FormList.Items[I].FindComponent('imgEditar'));
//          txtValor := TSkLabel	(FormList.Items[I].FindComponent('txtValor'));
//          valor := valor + StrtoFloat(txtValor.Text.Replace('R$','').Replace(' ',''));
//          strIDs.Append(IntTostr(imgEditar.Tag)+',');
//      end;
//   end;
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
end;


procedure TfMain.edtValorEnter(Sender: TObject);
begin
   NameValor := TEdit(Sender).Name;
   rctTeclado.AnimateFloat('Height',75,0.3, TAnimationType.In, TInterpolationType.Circular)
end;

procedure TfMain.edtValorExit(Sender: TObject);
begin
   rctTeclado.AnimateFloat('Height',0,0.3, TAnimationType.In, TInterpolationType.Circular)
end;

procedure TfMain.ExcluirContas(AId: String);
var Contas :Tcontas;
begin
   Contas := TContas.Create(Container.SQLite);
   Contas.ID := AId;
   Contas.Excluir;
   Contas.Free;

   Data('U');

   TabControl1.GotoVisibleTab(0);
end;

procedure TfMain.AnimaFinish(Sender: TObject);
begin
   if TFloatAnimation(Sender).Tag <> -1 then
      TFloatAnimation(Sender).Tag := -1;
end;

procedure TfMain.AnimaGraph;
begin

   if tbcHome.ActiveTab = tbiChart then begin
      TThread.CreateAnonymousThread(
      procedure begin
         TThread.Synchronize(nil,
         procedure begin
            ShowGraph(Layout13, CreateJsonChart(Container.tabLista, 'Descricao', 'Valor', 'IconeCor'));
         end);
      end).Start;
   end;

end;

procedure TfMain.btnAnteriorClick(Sender: TObject);
begin
   Data('R');
end;

procedure TfMain.btnLiquidarClick(Sender: TObject);
begin
   Data('A')
end;

procedure TfMain.btnLiquidarMultiplosClick(Sender: TObject);
var Contas :TContas;
begin

   Contas := TContas.Create(Container.SQLite);
   Contas.ID := TImage(Sender).Hint;
   Contas.Liquidar;
   Contas.Free;

   ExibeMsg('Conta(s) liquidada(s)');

   Data('U')

end;

procedure TfMain.btnProximoClick(Sender: TObject);
begin
   Data('L');
end;

procedure TfMain.btnSalvarClick(Sender: TObject);
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

      Contas := TContas.Create(Container.SQLite);
      Contas.ID := edtID.Text;
      Contas.Descricao := edtDescricao.Text;
      Contas.Subcategoria := edtSubcategoria.Text;
      Contas.Categoria := edtCategoria.Text;
      Contas.Vencimento := edtVencimento.Date;

      if edtPagamento.Text <> '' then
         Contas.Pagamento := edtPagamento.Date;

      Contas.ValorPago := edtValorPago.Text;
      Contas.TipoMovimento := IfThen(txtTipoMovimento.Tag = 0,'R','D');
      Contas.Valor := edtValor.Text;
      Contas.Parcela := StrToInt(edtParcela.Text);
      Contas.Incluir;

      Contas.Free;

      DataNew := edtVencimento.Date;

      Data('U');
      ExibeMsg(txtTipoMovimento.text + ' incluída com sucesso');

      LancarDespesaReceita;
      TabControl1.GotoVisibleTab(0);
   end;
end;

procedure TfMain.CardsCategoria;
var
   layContent : TLayout;
   rctCard :TRectangle;
   imgIcone : TImage;
   txtTitulo,txtValor :TText;
   strIcone :String;
   strDescricao :String;
   iColor :Integer;
begin

   Container.tabLista.Open('SELECT Descricao, '  +
                           '(SELECT Replace(printf("R$ %.2f",SUM(Valor)),".",",") AS ValorFormatado FROM Parcelas WHERE strftime("%Y-%m", DataVencimento) = ' +QuotedStr(FormatDateTime('YYYY-MM',DataNew)) + ' AND Parcelas.ID_Categoria = Categorias.ID) ValorFormatado, '+
                           '(SELECT SUM(Valor) As Valor FROM Parcelas WHERE strftime("%Y-%m", DataVencimento) = ' +QuotedStr(FormatDateTime('YYYY-MM',DataNew)) + ' AND Parcelas.ID_Categoria = Categorias.ID) Valor, '+
                           '(SELECT SUM(Valor) AS Valor FROM Parcelas WHERE strftime("%Y-%m", DataVencimento) = ' +QuotedStr(FormatDateTime('YYYY-MM',DataNew)) +' AND Parcelas.ID_Categoria = Categorias.ID) / '+
                           '(SELECT SUM(Valor) AS Valor FROM Parcelas WHERE Parcelas.TipoMovimento = Categorias.TipoMovimento AND strftime("%Y-%m", DataVencimento) = ' +QuotedStr(FormatDateTime('YYYY-MM',DataNew)) +') * 100 AS Porcentagem, '+
                           'Icone, IconeCor, TipoMovimento '+
                           'FROM Categorias WHERE Valor > 0 Order by Valor DESC,Descricao ');

   Container.tabLista.Filtered := False;
   if tbcHome.ActiveTab = tbiChart then begin
      Container.tabLista.Filter := 'TipoMovimento = ''D''';
      Container.tabLista.Filtered := True;
   end;

   AnimaGraph;

   ListHCategorias.Clear;
   hsbCategorias.BeginUpdate;

   vsbCategoriaPorc.RemoveAllComponents;

   Container.tabLista.First;
   while not  Container.tabLista.Eof do begin
      strDescricao := Container.tabLista.FieldByName('Descricao').AsString.ToUpper;
      iColor := Container.tabLista.RecNo-1;
      if tbcHome.ActiveTab = TabItem1 then begin
         rctCard := TRectangle.Create(hsbCategorias,TAlignLayout.Left,TAlphaColorRec.White);
         rctCard.Margins.Left   := 10;
         rctCard.Padding.Top    := 5;
         rctCard.Padding.Bottom := 5;
         rctCard.Margins.Bottom := 2;
         rctCard.Width          := hsbCategorias.Height;
         rctCard.Height         := hsbCategorias.Height;
         rctCard.Stroke.Color   := TAlphaColorRec.Darkgray;
         rctCard.YRadius := 5;
         rctCard.XRadius := 5;
         rctCard.Sombrear;

         ListHCategorias.Add(rctCard);

         txtTitulo := TText.Create(rctCard,
                                   strDescricao,
                                   10,
                                   TAlphaColors.Darkgray,
                                   TTextAlign.Center,
                                   TTextAlign.Leading,
                                   TAlignLayout.Top);

         txtValor := TText.Create(rctCard,
                                  Container.tabLista.FieldByName('ValorFormatado').AsString,
                                  12,
                                  TAlphaColors.Darkgray,
                                  TTextAlign.Center,
                                  TTextAlign.Center,
                                  TAlignLayout.Bottom);
         txtValor.Height := 15;

         layContent := TLayout.Create(rctCard, TAlignLayout.Contents);

         if Container.tabLista.FieldByName('Icone').AsString.ToUpper = '' then
            strIcone := strDescricao
         else
            strIcone := Container.tabLista.FieldByName('Icone').AsString.ToUpper ;

         imgIcone := TImage.Create(layContent, strIcone, TAlignLayout.Center);
         imgIcone.Height := 38;
         imgIcone.Width := 38;

      end else if tbcHome.ActiveTab = tbiChart then begin

         var layCategoriaPorc  := TLayout.Create(vsbCategoriaPorc, TAlignLayout.Top);
         layCategoriaPorc.Height := 40;
         layCategoriaPorc.Margins.Rect := TRectF.Create(5,0,5,0);
         layCategoriaPorc.Position.Y :=  Self.ComponentCount * layCategoriaPorc.Height;

         FCard := TFCard.Create(FCard,
                                strDescricao,
                                Container.tabLista.FieldByName('Porcentagem').AsFloat,
                                ColorsGraph[iColor]
                                );

         layCategoriaPorc.AddObject(FCard.rctCategoriaPorcItem);
         vsbCategoriaPorc.InsertComponent(layCategoriaPorc);

         TAnimator.AnimateFloatDelay(FCard.RoundRect4, 'Width',(FCard.RoundRect3.Width / 100) * Container.tabLista.FieldByName('Porcentagem').AsFloat , 0.2, 0.2,
            TAnimationType.InOut, TInterpolationType.Circular);

      end;

      Container.tabLista.Next

   end;
   hsbCategorias.EndUpdate;

end;

procedure TfMain.CarregaCategorias;

begin
   if TabControl1.ActiveTab = tbiReceitaDespesa then
     SelectCategorias('SELECT Categorias.*, CASE WHEN Icone IS NOT NULL THEN Icone ELSE Descricao END AS Img FROM Categorias WHERE TipoMovimento ="'+
                     IfThen(txtTipoMovimento.Tag = 0,'R','D')+
                    '" ORDER BY Descricao',edtCategoria.Name )
  else
     SelectCategorias('SELECT Categorias.*, CASE WHEN Icone IS NOT NULL THEN Icone ELSE Descricao END AS Img  FROM Categorias ORDER BY Descricao',edtEditCategoria.Name)

end;

procedure TfMain.CarregaSubcategorias;
begin

   SelectCategorias(Format(
                    'SELECT SubCategorias.*, '+
                    ' CASE WHEN Categorias.Icone IS NOT NULL THEN Categorias.Icone ELSE Categorias.Descricao END AS Img '+
                    ' FROM SubCategorias '+
                    ' INNER JOIN '+
                    ' Categorias ON Categorias.ID = SubCategorias.ID_Categoria WHERE ID_Categoria = (SELECT Categorias.ID FROM Categorias WHERE Descricao = "%s") ORDER BY Descricao ',[edtCategoria.Text]),
                    edtSubcategoria.Name);
end;

procedure TfMain.CircleClick(Sender: TObject);
var
  I: Integer;
begin

  for I := 0 to ListIcones.Count - 1 do
  begin

    if TCircle(ListIcones.Items[I]).Hint = TCircle(Sender).Hint then
        if TCircle(Sender).Fill.Color = TAlphaColors.Null  then
           TCircle(ListIcones.Items[I]).Fill.Color := ColorSelect
        else
           TCircle(ListIcones.Items[I]).Fill.Color := TAlphaColors.Null
    else begin
       TCircle(ListIcones.Items[I]).Fill.Color := TAlphaColors.Null;

    end;
  end;
end;

procedure TfMain.CircleCoresClick(Sender: TObject);
var
   I: Integer;
begin

   for I := 0 to ListCores.Count - 1 do begin

      if TCircle(ListCores.Items[I]).tag = TCircle(Sender).tag then begin
         if TCircle(Sender).Fill.Color = TAlphaColors.Null then
            TCircle(ListCores.Items[I]).Fill.Color := TCircle(Sender).Fill.Color
         else
            TCircle(ListCores.Items[I]).Fill.Color := TAlphaColors.Null
      end else begin
        TCircle(ListCores.Items[I]).Fill.Color := TCircle(ListCores.Items[I]).Stroke.Color;
      end;
   end;

  IconeSelect;

end;

function TfMain.IconeSelect(AText:string): String;
var I: Integer;
begin
  for I := 0 to ListIcones.Count - 1 do begin
      if TCircle(ListIcones.Items[I]).Hint = AText then
         TCircle(ListIcones.Items[I]).Fill.Color := ColorSelect
      else
         TCircle(ListIcones.Items[I]).Fill.Color := TAlphaColors.Null;
  end;

end;

function TfMain.ColorSelect(ACor: TAlphaColor): TAlphaColor;
var
   I: Integer;
begin

   for I := 0 to ListCores.Count - 1 do begin
      if TCircle(ListCores.Items[I]).Stroke.Color = ACor then
         TCircle(ListCores.Items[I]).Fill.Color := TAlphaColors.Null
      else
         TCircle(ListCores.Items[I]).Fill.Color := TCircle(ListCores.Items[I]).Stroke.Color
   end;
end;

function TfMain.ColorSelect: TAlphaColor ;
var
  I: Integer;
begin

   for I := 0 to ListCores.Count - 1 do begin
      if TCircle(ListCores.Items[I]).Fill.Color = TAlphaColors.Null then
          Result := TCircle(ListCores.Items[I]).Stroke.Color;
   end;
end;

function TfMain.IconeSelect: String;
var I: Integer;
begin
  for I := 0 to ListIcones.Count - 1 do begin
      if TCircle(ListIcones.Items[I]).Fill.Color <> TAlphaColors.Null then begin
         TCircle(ListIcones.Items[I]).Fill.Color := ColorSelect;
         Result := TCircle(ListIcones.Items[I]).Hint;
      end;
  end;

end;

procedure TfMain.Image1Click(Sender: TObject);
begin

   TThread.CreateAnonymousThread(
                                  procedure begin
                                      TThread.Synchronize(nil,
                                      procedure begin
                                       ShowGraph(Layout13, CreateJsonChart(Container.tabLista,'Descricao', 'Valor', 'IconeCor'));
                                      end);
                                  end
                                 ).Start;
end;

procedure TfMain.btnBuscarCategoriaClick(Sender: TObject);
begin
   CarregaCategorias;
end;

procedure TfMain.btnBuscarSubCategoriaClick(Sender: TObject);
begin
   if edtCategoria.Text <> '' then
      CarregaSubcategorias
end;

procedure TfMain.btnChartClick(Sender: TObject);
begin
   tbcHome.GotoVisibleTab(1);
end;

procedure TfMain.btnExitClick(Sender: TObject);
begin
   Close;
end;

procedure TfMain.btnExcluirMovimentoClick(Sender: TObject);
begin
   SelectDespesaReceita;
end;

procedure TfMain.btnExcluirMultiplosClick(Sender: TObject);
begin
   ExcluirContas(TSpeedButton(Sender).Hint);
   ExibeMsg('Conta(s) excluída(s)');
end;

procedure TfMain.SpeedButton1Click(Sender: TObject);
begin
   TabControl1.GotoVisibleTab(0);
end;

procedure TfMain.SpeedButton2Click(Sender: TObject);
begin
  Container.EditarCategoria(IDCategoria,IconeSelect,IntToHex(ColorSelect, 8))
end;


procedure TfMain.btnAdicionarClick(Sender: TObject);
begin
   SelectDespesaReceita;
end;

procedure TfMain.btnTrocaDataClick(Sender: TObject);
begin
  if edtPagamento.Text = '' then
     edtPagamento.Date := edtVencimento.Date
  else
     edtPagamento.Text := ''
end;

procedure TfMain.btnTrocaValorClick(Sender: TObject);
begin
  if edtValorPago.Text = '' then
     edtValorPago.Text := edtValor.Text
  else
     edtValorPago.Text := ''
end;

procedure TfMain.btnHomeClick(Sender: TObject);
begin
   tbcHome.GotoVisibleTab(0);
end;

procedure TfMain.btnCustomizeClick(Sender: TObject);
begin
   TabControl1.GotoVisibleTab(2);
end;

procedure TfMain.TabControl1Change(Sender: TObject);
begin
   if TabControl1.ActiveTab = tbiCategoria then begin
      LoadImagesIntoFlowLayout;
      CreateColorSelector;
   end else if TabControl1.ActiveTab = tbiHome then begin
      Data('U');
      StatusBarColor(ColorPadrao);
   end else if TabControl1.ActiveTab = tbiReceitaDespesa then begin
      rctTrocaData.Fill.Color := rctReceitaDespesa.Fill.Color;
      rctTrocaValor.Fill.Color := rctReceitaDespesa.Fill.Color;
   end;
end;

procedure TfMain.tbcHomeChange(Sender: TObject);
begin
   CardsCategoria
end;

procedure TfMain.Teclado;
var
   I :Integer;
   rctBotaoFundo : TRectangle;
   txtBotao : TText;
   gplTeclado : TGridPanelLayout;
begin
   gplTeclado := TGridPanelLayout.Create(rctTeclado	,2,6);
   rctTeclado.AddObject(gplTeclado);
   rctTeclado.Fill.Color := TAlphaColors.Null;

   for I := 1 to 12 do begin
      rctBotaoFundo := TRectangle.Create(gplTeclado,TAlignLayout.Client);
      rctBotaoFundo.Fill.Color := TAlphaColorRec.White;
      rctBotaoFundo.YRadius := 5;
      rctBotaoFundo.XRadius := 5;

      txtBotao := TText.Create(rctBotaoFundo);
      if I = 10 then begin
         txtBotao.Text := IntToStr(0);
         txtBotao.Tag := 0;
      end
      else if I = 11 then begin
         txtBotao.Text := '0,00';
         txtBotao.Tag := 1;
      end else if I = 12 then begin
         txtBotao.Text := '<<';
         txtBotao.Tag := 2;
      end else begin
         txtBotao.Text := IntToStr(I);
         txtBotao.Tag := 0;
      end;
      txtBotao.Align := TAlignLayout.Client;
      txtBotao.TextSettings.FontColor := TAlphaColorRec.Darkgrey;

      txtBotao.TextSettings.Font.Size := 12;
      txtBotao.OnClick := NumeroClick;
      rctBotaoFundo.MarginAll(2);
      rctBotaoFundo.AddObject(txtBotao);
      rctBotaoFundo.Sombrear;

      gplTeclado.AddObject(rctBotaoFundo);
   end;

   Rectangle14.Sombrear;
end;

procedure TfMain.TecladoInteiro;
var
   I :Integer;
   rctBotaoFundo :TRectangle;
   txtBotao :TText;
   gplTecladoInteiro :TGridPanelLayout;
begin
   gplTecladoInteiro := TGridPanelLayout.Create(rctTecladoInteiro, 2, 5);
   rctTecladoInteiro.AddObject(gplTecladoInteiro);
   rctTecladoInteiro.Fill.Color := TAlphaColors.Null;

   for I := 0 to 9 do begin
      rctBotaoFundo := TRectangle.Create(gplTecladoInteiro,TAlignLayout.Client);
      rctBotaoFundo.Fill.Color := TAlphaColorRec.White;
      rctBotaoFundo.YRadius := 5;
      rctBotaoFundo.XRadius := 5;

      txtBotao := TText.Create(rctBotaoFundo);
      txtBotao.Text := IntToStr(I);
      txtBotao.Align := TAlignLayout.Client;
      txtBotao.TextSettings.FontColor := TAlphaColorRec.Darkgrey;
      txtBotao.TextSettings.Font.Size := 12;
      txtBotao.OnClick := NumeroInteiroClick;

      rctBotaoFundo.MarginAll(1);
      rctBotaoFundo.AddObject(txtBotao);
      rctBotaoFundo.Sombrear;

      gplTecladoInteiro.AddObject(rctBotaoFundo);
   end;
   Rectangle14.Sombrear;
end;

procedure TfMain.Text14Click(Sender: TObject);
begin
   TabControl1.GotoVisibleTab(2);
end;

procedure TfMain.Text4Click(Sender: TObject);
begin
  LoadImagesIntoFlowLayout
end;

procedure TfMain.CreateColorSelector;
var
  crcFundo, crcCenter: TCircle;
  I: Integer;
begin

   if ListCores.Count = 0 then begin
      for I := 0 to ColorsCount - 1 do begin
         crcFundo := TCircle.Create(HorzScrollBox);
         crcFundo.Parent := HorzScrollBox;
         crcFundo.Align := TAlignLayout.Left;
         crcFundo.Width := 40;
         crcFundo.Height := 40;
         crcFundo.Margins.Rect := TRectF.Create(5, 5, 5, 5);
         crcFundo.Fill.Color := Colors[I];
         crcFundo.Stroke.Color := Colors[I];
         crcFundo.tag := I;
         crcFundo.Stroke.Kind := TBrushKind.Solid;
         crcFundo.Stroke.Thickness := 1;
         crcFundo.OnClick := CircleCoresClick;

         ShadowEffect(crcFundo);
         ListCores.Add(crcFundo);

         crcCenter := TCircle.Create(crcFundo);
         crcCenter.Parent := crcFundo;
         crcCenter.Width := 30;
         crcCenter.Height := 30;
         crcCenter.Align := TAlignLayout.Center;
         crcCenter.Fill.Color := Colors[I];
         crcCenter.Stroke.Kind := TBrushKind.None;
         crcCenter.HitTest := False;
      end;
   end;

  ColorSelect(TAlphaColors.White);
end;


procedure TfMain.LoadImagesIntoFlowLayout;
var
   Item: TCustomBitmapItem;
   Size: TSize;
   I: Integer;
   imgIcone: Timage;
   crcFundoImg : TCircle;
   gplIcones : TGridPanelLayout;
begin
   gplIcones := TGridPanelLayout.Create(Layout3,  5,5 );

   Layout3.AddObject(gplIcones);

   gplIcones.BeginUpdate;
   for I := 0 to ImageList1.Source.Count - 1 do begin
      if ImageList1.BitmapItemByName(ImageList1.Source.Items[I].Name, Item, Size) then begin
         crcFundoImg := TCircle.Create(Self) ;
         crcFundoImg.Margins.Rect := TRectF.Create(5, 5, 5, 5);
         crcFundoImg.Fill.Color := TAlphaColors.Null;
         crcFundoImg.Stroke.Color := TAlphaColors.Null;
         crcFundoImg.Align := TAlignLayout.Center;
         crcFundoImg.OnClick := CircleClick;
         crcFundoImg.Hint := ImageList1.Source.Items[I].Name;
         ListIcones.Add(crcFundoImg);

         imgIcone := TImage.Create(crcFundoImg);
         imgIcone.Margins.Rect := TRectF.Create(5, 5, 5, 5);
         imgIcone.Align := TAlignLayout.Client;
         imgIcone.Height := imgIcone.Width;
         imgIcone.Bitmap := Item.MultiResBitmap.Bitmaps[1.0];
         imgIcone.HitTest := False;
         crcFundoImg.AddObject(imgIcone);
         gplIcones.AddObject(crcFundoImg);
      end;
   end;

   gplIcones.EndUpdate;
end;

procedure TfMain.Text5Click(Sender: TObject);
begin
   StatusBarColor(TAlphaColors.Crimson);
   rctTopo.Color(TAlphaColors.Crimson);
end;

procedure TfMain.vsbListaMensalViewportPositionChange(Sender: TObject;
  const OldViewportPosition, NewViewportPosition: TPointF;
  const ContentSizeChanged: Boolean);
begin
   //Layout8.Visible :=  (NewViewportPosition.Y = 0);
end;

procedure TfMain.Voltar;
begin
    if TabControl1.ActiveTab = tbiReceitaDespesa then begin
       TabControl1.GotoVisibleTab(0);
       StatusBarColor(ColorPadrao);
    end else if TabControl1.ActiveTab = tbiHome then begin
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

function THelperForm.CreateRctFundoOpaco(Parent: TComponent; const Name,
  Hint: string; Color: TAlphaColor; Opacity: Single;
  OnClickEvent: TNotifyEvent): TRectangle;
begin
   Result := TRectangle.Create(Parent);
   Result.Name := Name;
   Result.Hint := Hint;
   Result.Fill.Color := Color;
   Result.Stroke.Color := TAlphaColorRec.Null;
   Result.Stroke.Thickness := 0;
   Result.Opacity := Opacity;
   Result.OnClick := OnClickEvent;
   Result.Align := TAlignLayout.Contents;
end;

procedure THelperForm.ExibeMsg(AMsg:String);
var
   layClient :TLayout;
   rctFundoWhite :TRectangle;
   AnimaEntrada,AnimaSaida :TFloatAnimation;
   txtMsg : TText;
begin

   NameComponent := 'TabControl1';

   rctFundoOpaco := CreateRctFundoOpaco(Self, 'rctFundoOpaco', 'Fundo Opaco', TAlphaColorRec.Black, 0.5, ExitAviso);

   Self.AddObject(rctFundoOpaco);

   layClient := TLayout.Create(Self);
   layClient.Size.Width := Self.Width;
   layClient.Size.Height := Self.Height;
   layClient.Position.X := 0;
   layClient.Position.Y := 0;
   layClient.Align := TAlignLayout.Client;
   layClient.HitTest := False;

   ListLayout.Add(layClient);

   rctFundoWhite := TRectangle.Create(layClient,TAlignLayout.None,TAlphaColors.White);
   rctFundoWhite.Position.Y :=  layClient.Size.Height;
   rctFundoWhite.Size.Width := layClient.Size.Width;
   rctFundoWhite.Size.Height := 60;
   rctFundoWhite.Size.PlatformDefault := False;
   rctFundoWhite.PaddingAll(10);

   layClient.AddObject(rctFundoWhite);
   rctFundoWhite.Anchors := [TAnchorKind.akLeft, TAnchorKind.akRight, TAnchorKind.akBottom];

   Self.AddObject(layClient);

   AnimaEntrada := TFloatAnimation.Create(rctFundoWhite,0.2,0,layClient.Height - rctFundoWhite.Height, True, 'Position.Y', 0);

   ListAnimaEntrada.Add(AnimaEntrada);

   txtMsg := TText.Create(rctFundoWhite, AMsg, 12, TAlphaColors.Darkgray);
   txtMsg.HitTest := False;

   AnimaEntrada.Start;

   AnimaSaida := TFloatAnimation.Create(rctFundoWhite,0.5,0,layClient.Height,True,'Position.Y',3);
   ListAnimaSaida.Add(AnimaSaida);
   rctFundoWhite.Tag := ListAnimaSaida.Count-1;
   layClient.Tag := ListAnimaSaida.Count-1;
   rctFundoOpaco.Tag := layClient.Tag;

   AnimaSaida.OnFinish := ExitFinish;
   AnimaSaida.Start;

end;

procedure THelperForm.ExitAviso(Sender: TObject);
begin
   ListAnimaSaida.Items[TSpeedButton(Sender).Tag].Delay := 0.1;
   ListAnimaSaida.Items[TSpeedButton(Sender).Tag].Duration := 0.2;
   ListAnimaSaida.Items[TSpeedButton(Sender).Tag].Start;
   ListAnimaSaida.Items[TSpeedButton(Sender).Tag].OnFinish := ExitFinish;

   if FindComponent(NameComponent) <> nil then begin

      if AnsiUpperCase(TRectangle(Sender).Hint) = 'ADICIONAR RECEITA' then begin
         TText(FindComponent('txtTipoMovimento')).Text := 'Nova Receita';
         TText(FindComponent('txtTipoMovimento')).Tag := 0;
         TRectangle(FindComponent('rctReceitaDespesa')).Fill.Color := ColorReceber;
         TRectangle(FindComponent('rctBotaoSalvar')).Fill.Color := ColorReceber;
         StatusBarColor([TRectangle(FindComponent('rctReceitaDespesa')),TRectangle(FindComponent('rctBotaoSalvar'))], ColorReceber);

         LancarDespesaReceita;
      end else if AnsiUpperCase(TRectangle(Sender).Hint) = 'ADICIONAR DESPESA' then begin
         TText(FindComponent('txtTipoMovimento')).Text := 'Nova Despesa';
         TText(FindComponent('txtTipoMovimento')).Tag := 1;
         StatusBarColor([TRectangle(FindComponent('rctReceitaDespesa')),TRectangle(FindComponent('rctBotaoSalvar'))], ColorPagar);
         LancarDespesaReceita;
      end else if AnsiUpperCase(TRectangle(Sender).Hint) = 'FUNDO OPACO' then begin

      end else begin
         IDCategoria := TSpeedButton(Sender).StyleLookup;

         TSpeedButton(FindComponent(NameComponent)).Text := TSpeedButton(Sender).Hint;
      end;

   end;

end;

procedure THelperForm.ExitFinish(Sender: TObject);
begin
   ListLayout.Clear;
   TRectangle(FindComponent('rctFundoOpaco')).DisposeOf;
end;

procedure THelperForm.LancarDespesaReceita;
begin
   TEdit(FindComponent('edtID')).Text := '';
   TEdit(FindComponent('edtSubcategoria')).Text := '';
   TEdit(FindComponent('edtCategoria')).Text := '';
   vParcela := '1';
   TEdit(FindComponent('edtParcela')).Text := vParcela;
   TEdit(FindComponent('edtValor')).Hint := '0,00';
   TEdit(FindComponent('edtValor')).Text := '0,00';

   TEdit(FindComponent('edtValorPago')).Hint := '0,00';
   TEdit(FindComponent('edtValorPago')).Text := '0,00';

   TDateEdit(FindComponent('edtVencimento')).Date := Date;
   TDateEdit(FindComponent('edtPagamento')).Text := '';
   TEdit(FindComponent('edtDescricao')).Text := '';
   TEdit(FindComponent('btnExcluirMovimento')).Visible := False;
   TTabControl(FindComponent('TabControl1')).GotoVisibleTab(1)
end;

procedure THelperForm.SelectCategorias(ASQL :String; ANameComponent :string);
var
   layClient :TLayout;
   rctFundoWhite : TRoundRect;
   rctCard :TRectangle;
   AnimaEntrada,AnimaSaida :TFloatAnimation;
   Lista :TVertScrollBox;

begin

   Container.tabCategorias.Open(ASQL);
   if (Container.tabCategorias.RecordCount = 0)  then begin
      ExibeMsg('Nenhuma sub-categoria para "'+TEdit(FindComponent(NameComponent)).Text+'"');
      Abort;
   end;

   NameComponent := ANameComponent;

   rctFundoOpaco := CreateRctFundoOpaco(Self, 'rctFundoOpaco', 'Fundo Opaco', TAlphaColorRec.Black, 0.5, ExitAviso);

   Self.AddObject(rctFundoOpaco);

   layClient := TLayout.Create(Self);
   layClient.Size.Width := Self.Width;
   layClient.Size.Height := Self.Height;
   layClient.Position.X := 0;
   layClient.Position.Y := 0;
   layClient.Align := TAlignLayout.Client;

   layClient.HitTest := False;
   ListLayout.Add(layClient);

   rctFundoWhite := TRoundRect.Create(layClient);
   rctFundoWhite.Fill.Color := ColorWhite;
   rctFundoWhite.Position.Y := layClient.Size.Height;
   rctFundoWhite.Size.Width := layClient.Size.Width;
   rctFundoWhite.Corners := [];
   rctFundoWhite.Size.Height :=  layClient.Size.Height;// - (layClient.Size.Height/3) ;
   rctFundoWhite.Size.PlatformDefault := False;
   rctFundoWhite.Stroke.Color := TAlphaColors.White;
   rctFundoWhite.Padding.Rect := TRect.Create(10,10,10,0);

   layClient.AddObject(rctFundoWhite);
   rctFundoWhite.Anchors := [TAnchorKind.akLeft, TAnchorKind.akRight, TAnchorKind.akBottom];

   Self.AddObject(layClient);

   AnimaEntrada := TFloatAnimation.Create(rctFundoWhite,0.2,0,0 { layClient.Height - rctFundoWhite.Height}, True, 'Position.Y', 0);

   ListAnimaEntrada.Add(AnimaEntrada);

   Lista := TVertScrollBox.Create(rctFundoWhite);
   rctFundoWhite.AddObject(Lista);
   Lista.Align := TAlignLayout.Client;
   Lista.Size.PlatformDefault := False;
   Lista.ShowScrollBars := False;
   Lista.BeginUpdate;

   Container.tabCategorias.First;
   while not Container.tabCategorias.eof do begin

      rctCard := TRectangle.Create(Lista,TAlignLayout.Top,Container.tabCategorias.Fields[1].AsString);
      rctCard.Color(ColorWhite);
      rctCard.HitTest := True;
      rctCard.Tag := ListAnimaSaida.Count;
      ListCategorias.Add(rctCard);

      rctCard.Margins.Bottom := 5;
      rctCard.Sombrear;

      FCard := TFCard.Create(Self);
      rctCard.AddObject(FCard.Rectangle3);

      if Container.tabCategorias.FieldByName('IconeCor').AsString <> '' then
         FCard.Circle2.Fill.Color := StringToAlphaColor('$'+ Container.tabCategorias.FieldByName('IconeCor').AsString);

      FCard.Rectangle3.Align := TAlignLayout.Client;
      FCard.SkLabel1.Text := Container.tabCategorias.Fields[1].AsString;

      if Container.tabCategorias.FieldByName('TipoMovimento').AsString = 'R' then
         FCard.rctSelecionar.Fill.Color := ColorReceber
      else
         FCard.rctSelecionar.Fill.Color := ColorPagar;

      FCard.btnSelecionar.StyleLookup := Container.tabCategorias.Fields[0].AsString;
      FCard.btnSelecionar.Hint := Container.tabCategorias.Fields[1].AsString;
      FCard.btnSelecionar.OnClick :=  ExitAviso;
      FCard.btnSelecionar.Tag := ListAnimaSaida.Count;
      FCard.Image4.ImageByName(Container.tabCategorias.FieldByName('Img').AsString.ToUpper);

      Container.tabCategorias.Next;
   end;
   Lista.EndUpdate;

   AnimaEntrada.Start;

   AnimaSaida := TFloatAnimation.Create(rctFundoWhite,0.5,0,layClient.Height ,True,'Position.Y',3);
   ListAnimaSaida.Add(AnimaSaida);

   rctFundoWhite.Tag := ListAnimaSaida.Count-1;
   layClient.Tag := ListAnimaSaida.Count-1;
   rctFundoOpaco.Tag := ListAnimaSaida.Count-1;
end;

procedure THelperForm.SelectDespesaReceita;
var
   layClient :TLayout;
   rctFundoWhite, rctFundoBotao :TRectangle;
   AnimaEntrada,AnimaSaida :TFloatAnimation;
   Lista :TVertScrollBox;
   lblReceitaDespesa : TSkLabel;
   btnReceitaDespesa: TSpeedButton;
begin

   NameComponent := 'TabControl1';

   rctFundoOpaco := CreateRctFundoOpaco(Self, 'rctFundoOpaco', 'Fundo Opaco', TAlphaColorRec.Black, 0.5, ExitAviso);

   Self.AddObject(rctFundoOpaco);

   layClient := TLayout.Create(Self, TAlignLayout.Client);
   layClient.HitTest := False;

   ListLayout.Add(layClient);
   rctFundoWhite := TRectangle.Create(layClient,TAlignLayout.None,TAlphaColors.White);
   rctFundoWhite.Position.Y := layClient.Size.Height;
   rctFundoWhite.Size.Width := layClient.Size.Width;
   rctFundoWhite.Size.Height := 140;
   rctFundoWhite.Size.PlatformDefault := False;
   rctFundoWhite.PaddingAll(10);
   rctFundoWhite.OnClick :=  ExitAviso;

   layClient.AddObject(rctFundoWhite);
   rctFundoWhite.Anchors := [TAnchorKind.akLeft, TAnchorKind.akRight, TAnchorKind.akBottom];

   Self.AddObject(layClient);

   AnimaEntrada := TFloatAnimation.Create(rctFundoWhite,0.2,0,layClient.Height - rctFundoWhite.Height, True, 'Position.Y', 0);

   ListAnimaEntrada.Add(AnimaEntrada);

   {inicio codigo}
   Lista := TVertScrollBox.Create(rctFundoWhite);
   rctFundoWhite.AddObject(Lista);
   Lista.Align := TAlignLayout.Client;
   Lista.Size.PlatformDefault := False;
   Lista.ShowScrollBars := False;
   Lista.BeginUpdate;

   Container.tabCategorias.Open('SELECT "Adicionar Receita" Conta '+
                                'UNION '+
                                'SELECT "Adicionar Despesa" Conta ');
   Container.tabCategorias.First;
   while not Container.tabCategorias.eof do begin
      rctFundoBotao := TRectangle.Create(Lista,TAlignLayout.Top,  Container.tabCategorias.Fields[0].AsString);
      rctFundoBotao.HitTest := True;

      if Container.tabCategorias.Fields[0].AsString = 'Adicionar Despesa' then
         rctFundoBotao.Fill.Color := ColorPagar
      else
         rctFundoBotao.Fill.Color := ColorReceber;

      rctFundoBotao.Tag := ListAnimaSaida.Count;
      rctFundoBotao.XRadius := 15;
      rctFundoBotao.YRadius := 15;
      rctFundoBotao.Margins.Rect := TRectF.Create(5, 5, 5, 5);
      rctFundoBotao.OnClick :=  ExitAviso;

      ListCategorias.Add(rctFundoBotao);

      lblReceitaDespesa := TSkLabel.Create(rctFundoBotao);
      lblReceitaDespesa.Align := TAlignLayout.Client;
      lblReceitaDespesa.Size.Width := 378;
      lblReceitaDespesa.Size.Height := 50;
      lblReceitaDespesa.StyledSettings := [TStyledSetting.Family];
      lblReceitaDespesa.TextSettings.Font.Size := 15;
      lblReceitaDespesa.TextSettings.Font.Weight := TFontWeight.Semibold;
      lblReceitaDespesa.TextSettings.FontColor := TAlphaColorRec.White;
      lblReceitaDespesa.TextSettings.HorzAlign := TSkTextHorzAlign.Center;
      lblReceitaDespesa.Words.Add.Text := Container.tabCategorias.Fields[0].AsString;
      rctFundoBotao.AddObject(lblReceitaDespesa);

      btnReceitaDespesa := TSpeedButton.Create(rctFundoBotao);
      btnReceitaDespesa.Align := TAlignLayout.Contents;
      rctFundoBotao.Sombrear;

      Container.tabCategorias.Next;
   end;
   Lista.EndUpdate;
   {fim codigo}

   AnimaEntrada.Start;

   AnimaSaida := TFloatAnimation.Create(rctFundoWhite,0.5,0,layClient.Height,True,'Position.Y',3);
   ListAnimaSaida.Add(AnimaSaida);
   rctFundoWhite.Tag := ListAnimaSaida.Count-1;
   layClient.Tag := ListAnimaSaida.Count-1;
   rctFundoOpaco.Tag := layClient.Tag;

end;

function TfMain.CreateJsonChart(DataSet: TDataSet; AField, AValue, AColor :String) : String;
var str : TStringBuilder;
begin
   str := TStringBuilder.Create;
   try
      DataSet.First;
      while not DataSet.Eof do begin
         if DataSet.FieldByName(AValue).AsString <> '' then begin
            str.Append('{"field" :"' + DataSet.FieldByName(AField).AsString +'",');
            str.Append('"color" :"' + DataSet.FieldByName(AColor).AsString +'",');
            str.Append('"value" : ' + DataSet.FieldByName(AValue).AsString.Replace(',','.') +'}');
         end;
         DataSet.Next;
      end;
   finally
      result := '['+str.ToString.Replace('}{','},{') + ']' ;
   end;
end;

procedure TfMain.ShowGraph(ALayout: TLayout; AJSON :String);
var
   errorMsg: string;
   pieChart: TChart4Delphi;
begin
   pieChart := nil;

   pieChart := TChart4Delphi.Create(ALayout, TChartLayoutType.ctlDonuts);
   pieChart.TextStyle := [TFontStyle.fsBold];

   pieChart.TextFontSize      := 12;;
   pieChart.TextOffset        := 0.17;
   pieChart.FormatValues      := '##,#0';
   pieChart.ShowValues        := False;
   pieChart.Animate           := True;
   pieChart.AnimationDuration := 0.8;

   pieChart.DonutsCenterRadius := 180;
   pieChart.SetColors(ColorsGraph,[]);

   pieChart.DrawGraph(AJSON, errorMsg);

   if (errorMsg <> EmptyStr) then
      ShowMessage(errorMsg);

end;

end.
