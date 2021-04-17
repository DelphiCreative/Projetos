unit FMX.Fast;

interface

uses  TypInfo,
  System.ImageList, FMX.ImgList,
  System.IOUtils,
  System.RegularExpressions,
  System.Variants,
  System.Types,
  System.StrUtils,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.DatS,
  FireDAC.DApt,
  FireDAC.DApt.Intf,
  FireDAC.FMXUI.Wait,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Async,
  FireDAC.Stan.Def,
  FireDAC.Stan.Error,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Pool,
  FireDAC.UI.Intf,
  FMX.Graphics,
  FMX.Layouts,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Types,
  FMX.Effects,
  FMX.Dialogs,
  FMX.ListBox,
    FMX.MultiResBitmap,
  System.SysUtils,
  FMX.Edit, FMX.SearchBox,
  FMX.TabControl,
  FMX.DateTimeCtrls,
  FMX.Memo,
  System.Generics.Collections,
  FMX.ComboEdit,
  FMX.Ani,
  FMX.Controls,
  System.UITypes;

type
  TFDConnectionHelper = class helper for TFDConnection

     function CreateTable(TableName:String): TFDConnection;
     function Add(FieldName:String): TFDConnection;

     function AddDATE(FieldName:String): TFDConnection;overload;
     function AddDATE(FieldName,ReplaceName:String): TFDConnection; overload;
     function AddDATE(FieldName,ReplaceName,Msg:String): TFDConnection; overload;

     function AddFLOAT(FieldName:String): TFDConnection; overload;
     function AddFLOAT(FieldName,ReplaceName:String): TFDConnection; overload;

     function AddTEXT(FieldName:String): TFDConnection; overload;
     function AddTEXT(FieldName,ReplaceName:String): TFDConnection; overload;

     function AddVARCHAR(FieldName:String;Size :Integer): TFDConnection; overload;
     function AddVARCHAR(FieldName:String;Size :Integer;ReplaceName:String):
       TFDConnection; overload;
     function AddVARCHAR(FieldName:String;Size :Integer;ReplaceName,Msg:String;
        Key :Boolean = false):
       TFDConnection; overload;

     procedure Execute;
  end;

//type
//  TControlHelper = class helper for TSpControl
//     procedure ClonarEventos(Source: TControl);
//  end;

type
  TVertScrollBoxHelper = class helper for TVertScrollBox
      procedure AddLabel(AText:String);
  end;

type
  TShapeHelper = class helper for TShape
    procedure AddText(Texto :String; FontCor: TAlphaColor = TAlphaColorRec.Dimgray ;
      FontSize: Real = 10);
    procedure Cor(Cor: TAlphaColor);
    procedure ReplaceColor(Cor:TAlphaColor);
    procedure Sombra(Cor :TAlphaColor);
    procedure ImageByName(Name:String);
    procedure AddIcone(Name:String);
end;

type
   TSpeedButtonHelper = class helper for TSpeedButton
     procedure AddIcone(Name:String);
     procedure ClonarEventos(Source: TSpeedButton);
   end;

type
  TLayoutHelper = class helper for TLayout
     procedure CarregaTela;
     procedure BotaoAddClick(Sender : TObject);
     procedure BotaoSaveClick(Sender :TObject);
     procedure BotaoEditClick(Sender :TObject);
     procedure BotaoBackClick(Sender :TObject);
     procedure BotaoDeleteClick(Sender :TObject);
     procedure BotaoLocalizarClick(Sender :TObject);

     procedure Clear;

     function AppCadastro(SQL :String) :TLayout ;
     ///<summary> <b>Define como cor primaria</b> </summary>
     function CorPadrao(Color :TAlphaColor) :TLayout;

     function IndexColunas(StrIndex : String):TLayout;
     function IndexFields(StrIndex : String):TLayout;
     function IndexFilters(StrIndex : String):TLayout;

     function Substituir(Text,Text2 : String):TLayout;
     ///<summary> <b>Define o título</b> </summary>
     function BarTitulo(Text :string) :TLayout;
     function Criar : TLayout;

     procedure BeforePost(DataSet: TDataSet);
     procedure BeforeOpen(DataSet: TDataSet);
     procedure AfterOpen(DataSet: TDataSet);

     procedure Aviso(Msg , Botao1 , Botao2 : String);
     procedure BotaoCancelarClick(Sender :TObject);
     procedure BotaoConfirmarClick(Sender: TObject);

     procedure BotaoOkClick(Sender: TObject);
     procedure BotaoExitClick(Sender: TObject);


     procedure AvisoFinish(Sender :TObject);

     procedure AnimaFinish(Sender: TObject);
     procedure FloatAnimation1Finish(Sender: TObject);
     procedure FloatAnimation2Finish(Sender: TObject);


     procedure AjusteEnter(Sender: TObject);

end;

//procedure DarkTheme;

procedure Voltar(Sender :TObject);
function DicionarioText(Text :String) : String;
procedure ImageLoad;

var

  FundoOpaco,
  BodyBackground,
  BarBackground,
  BotaoEditBackground,
  BotaoDeleteBackground,
  Icones,
  FundoBotaoAdd,
  FundoBotaoSave : TRectangle;

  BarText :TLabel;


  TabControl :TTabControl;

  TabItemLista,
  TabitemCadastro : TTabItem;

  I : Integer;

  BotaoDelete,
  BotaoEdit,
  BotaoAdd,
  BotaoSave,
  BotaoBack,
  BotaoExit : TSpeedButton;

  Dados,
  Dados2 : TFDQuery;

  BotaoLocalizar :TEditButton;

  EditLocalizar :TEdit;

  VertDados,
  VertScroll :TVertScrollBox;

  PrimaryColor :TAlphaColor = TAlphaColorRec.Cornflowerblue;

  Titulo : String = 'Cadastro';
  TextButtonEdit : String = 'EDITAR';
  TextButtonDelete : String = 'REMOVER';

  AnimaEntrada,
  AnimaSaida : TFloatAnimation;

  NewRecord :Boolean;
  LayoutPrincipal : TControl;
  Card :TFmxObject;

  ColunasCard,
  ColunasField,
  ColunasFilter,
  Table,
  Query :String;

  Dicionario : TDictionary<String,string>;

  SQLite :TFDConnection;

  TableCreate,
  TriggerCreate :TStringBuilder;

  CampoNome  :TLabel;

  ListIcons :TImageList;

implementation

procedure Voltar(Sender :TObject);
begin

end;

function DicionarioText(Text :String) : String;
begin
   if Dicionario.ContainsKey(Text) then
      Result := Dicionario.Items[Text]
   else
      Result := Text
end;

{ TLayoutHelper }
procedure TLayoutHelper.BeforeOpen(DataSet: TDataSet);
var
   Filter :TArray<string> ;
   Fil :String;
begin

   if ColunasFilter <> '' then begin
      Filter := TRegEx.Split(ColunasFilter,',');
      for I := 0 to TRegEx.Matches(ColunasFilter,',').Count do
         if I = 0 then
            Fil :=  ' WHERE '+ Filter[i] +'  LIKE "%???%"'
         else
            Fil :=   Fil + ' OR '+ Filter[i] +'  LIKE "%???%"';


   end else begin
      Fil :=  ' WHERE True AND ID LIKE "%???%" ';
   end;


   if EditLocalizar.Text <> '' then
      Fil :=  (Fil).Replace('???',EditLocalizar.Text)
   else
      Fil := ' LIMIT 25';

   Dados.SQL.Text := Query +  Fil  ;
end;

procedure TLayoutHelper.BeforePost(DataSet: TDataSet);
begin
   NewRecord := (DataSet.Fields[0].AsInteger < 0 );
end;

function TLayoutHelper.AppCadastro(SQL :String) :TLayout;
begin
   LayoutPrincipal := TLayout(Self.Parent);

   Query := SQL;
   ColunasCard := '';
   ColunasField := '';

   Dados := TFDQuery.Create(Self);
   Dados.Connection := SQLite;

   Dados.BeforePost := BeforePost;
   Dados.BeforeOpen := BeforeOpen;
   Dados.AfterOpen := AfterOpen;
   Dados.AfterPost := AfterOpen;

   Self.Clear;

   BarBackground := TRectangle.Create(Self);
   BarBackground.Align := TAlignLayout.Top;
   BarBackground.Height := 50;
   BarBackground.Cor(PrimaryColor);
   BarBackground.Sombra(PrimaryColor);
   Self.AddObject(BarBackground);

   BotaoBack := TSpeedButton.Create(BarBackground);
   BarBackground.AddObject(BotaoBack);
   //BotaoBack'.StyleLookup := '';

   BotaoBack.Width := 50;
   BotaoBack.Align := TAlignLayout.Left;
   BotaoBack.Size.PlatformDefault := False;
   BotaoBack.IconTintColor := TAlphaColorRec.White;
   BotaoBack.StyledSettings := [];
   BotaoBack.Visible := False;
   BotaoBack.OnClick := BotaoBackClick;
   BotaoBack.AddIcone('Back');

   BotaoExit := TSpeedButton.Create(BarBackground);
   BarBackground.AddObject(BotaoExit);
   //BotaoBack'.StyleLookup := '';

   BotaoExit.Width := 50;
   BotaoExit.Align := TAlignLayout.Left;
   BotaoExit.Size.PlatformDefault := False;
   BotaoExit.IconTintColor := TAlphaColorRec.White;
   BotaoExit.StyledSettings := [];
   BotaoExit.OnClick := BotaoExitClick;
   BotaoExit.Visible := True;

   BotaoExit.AddIcone('Exit');



   BarText := TLabel.Create(Self);
   BarText.FontColor := TAlphaColorRec.White;
   BarText.Text := Titulo;
   BarText.Margins.Left := 10;
   BarText.Font.Family := 'Roboto';
   BarText.Font.Size := 20;
   BarText.StyledSettings := [];
   BarText.Align := TAlignLayout.Client;
   BarBackground.AddObject(BarText);

   BodyBackground := TRectangle.Create(Self);
   BodyBackground.Align := TAlignLayout.Client;
   BodyBackground.Cor(TAlphaColorRec.White);
   Self.AddObject(BodyBackground);

   TabControl := TTabControl.Create(Self);
   BodyBackground.AddObject(TabControl);
   TabControl.TabPosition := TTabPosition.None;
   TabControl.Align := TAlignLayout.Client;

   TabItemLista := TTabItem.Create(TabControl);
   TabControl.AddObject(TabItemLista);

   EditLocalizar := TEdit.Create(TabItemLista);

   EditLocalizar.Margins.Top := 38;
   EditLocalizar.Margins.Left := 15;
   EditLocalizar.Margins.Right := 15;

   EditLocalizar.Align := TAlignLayout.Top;
   TabItemLista.AddObject(EditLocalizar);

   CampoNome := TLabel.Create(EditLocalizar);
   CampoNome.Text :='O que você esta procurando?';
   CampoNome.StyledSettings := [];
   CampoNome.FontColor := TAlphaColorRec.Dimgray;
   EditLocalizar.AddObject(CampoNome);
   CampoNome.Width :=    EditLocalizar.Width;
   CampoNome.Position.Y := -16;
   CampoNome.Position.X := 2;

   BotaoLocalizar := TEditButton.Create(EditLocalizar);
   BotaoLocalizar.StyleLookup := 'searcheditbutton';
   BotaoLocalizar.OnClick :=  BotaoLocalizarClick;
   EditLocalizar.AddObject(BotaoLocalizar);

   VertDados := TVertScrollBox.Create(TabItemLista);
   TabItemLista.AddObject(VertDados);
   VertDados.Align := TAlignLayout.Client;
   VertDados.Margins.Top := 10;
   VertDados.Padding.Top := 10;
   VertDados.Padding.Left := 15;

   FundoBotaoAdd := TRectangle.Create(TabItemLista);
   TabItemLista.AddObject(FundoBotaoAdd);
   FundoBotaoAdd.XRadius := 25;
   FundoBotaoAdd.YRadius := 25;
   FundoBotaoAdd.Height := 50 ;
   FundoBotaoAdd.Width :=  50;
   FundoBotaoAdd.Position.Y := Self.Height - FundoBotaoAdd.Height - 20 - 50;
   FundoBotaoAdd.Position.x := Self.Width -  FundoBotaoAdd.Height - 20 ;
   FundoBotaoAdd.Anchors := [TAnchorKind.akBottom,TAnchorKind.akRight];
   FundoBotaoAdd.Sombra(TAlphaColorRec.Black);


   BotaoAdd := TSpeedButton.Create(FundoBotaoAdd);
   FundoBotaoAdd.AddObject(BotaoAdd);
   BotaoAdd.StyleLookup := 'transparentcirclebuttonstyle';
   BotaoAdd.Align := TAlignLayout.Client;
   BotaoAdd.Size.PlatformDefault := False;
   BotaoAdd.IconTintColor := TAlphaColorRec.White;
   BotaoAdd.StyledSettings := [];
   BotaoAdd.OnClick := BotaoAddClick;

   TabitemCadastro := TTabItem.Create(TabControl);
   TabControl.AddObject(TabitemCadastro);
   TabitemCadastro.Text := 'TabItem2';

   VertScroll := TVertScrollBox.Create(TabitemCadastro);
   TabitemCadastro.AddObject(VertScroll);
   VertScroll.Align := TAlignLayout.Client;
   VertScroll.Padding.Top := 10;
   VertScroll.Padding.Left := 15;
   VertScroll.Padding.Right := 15;
   VertScroll.Padding.Bottom := 10;

   FundoBotaoSave := TRectangle.Create(TabitemCadastro);
   TabitemCadastro.AddObject(FundoBotaoSave);

   FundoBotaoSave.XRadius := 25;
   FundoBotaoSave.YRadius := 25;
   FundoBotaoSave.Height := 50 ;
   FundoBotaoSave.Width :=  50;

   FundoBotaoSave.Position.Y := Self.Height - FundoBotaoSave.Height - 20 - 50;
   FundoBotaoSave.Position.x := Self.Width -  FundoBotaoSave.Height - 20 ;
   FundoBotaoSave.Anchors := [TAnchorKind.akBottom,TAnchorKind.akRight];

   BotaoSave :=  TSpeedButton.Create(FundoBotaoSave);
   FundoBotaoSave.AddObject(BotaoSave);
   BotaoSave.StyleLookup := 'transparentcirclebuttonstyle';

   BotaoSave.Align := TAlignLayout.Center;
   BotaoSave.Width := FundoBotaoSave.Width;
   BotaoSave.Height := FundoBotaoSave.Width;
   BotaoSave.Size.PlatformDefault := False;
   BotaoSave.IconTintColor := TAlphaColorRec.White;
   BotaoSave.StyledSettings := [];
   BotaoSave.OnClick := BotaoSaveClick;
   BotaoSave.BringToFront;

   ImageLoad;

end;

procedure TLayoutHelper.Aviso(Msg , Botao1 , Botao2 : String);
var
   FundoMSG :TRectangle;
   FundoBotoes :TLayout;
   Mensagem :TText;
   PanelBotoes :TGridPanelLayout;
   BotaoCancelar,
   BotaoConfirmar :TSpeedButton;
   BotaoNaoBackground,
   BotaoSimBackground : TRectangle;
begin

   FundoOpaco := TRectangle.Create(LayoutPrincipal);
   FundoOpaco.Cor(TAlphaColorRec.Black);
   FundoOpaco.Stroke.Color := TAlphaColorRec.Null;
   FundoOpaco.Stroke.Thickness := 0;
   FundoOpaco.Opacity := 0.5;
   FundoOpaco.Align := TAlignLayout.Contents;
   LayoutPrincipal.AddObject(FundoOpaco);

   FundoMSG := TRectangle.Create(LayoutPrincipal);
   FundoMSG.Cor(TAlphaColorRec.White);
   FundoMSG.Stroke.Color := TAlphaColorRec.Null;
   FundoMSG.Height := 0;
   FundoMSG.Align := TAlignLayout.Bottom;
   LayoutPrincipal.AddObject(FundoMSG);

   Mensagem := TText.Create(FundoMSG);
   FundoMSG.AddObject(Mensagem);
   Mensagem.Text := Msg;
   Mensagem.Align := TAlignLayout.Top;
   Mensagem.Height := 50;
   Mensagem.TextSettings.FontColor := TAlphaColorRec.Dimgray;

   FundoBotoes := TLayout.Create(FundoMSG);
   FundoMSG.AddObject(FundoBotoes);
   FundoBotoes.Align := TAlignLayout.Center;

   PanelBotoes := TGridPanelLayout.Create(FundoBotoes);
   PanelBotoes.Align := TAlignLayout.Center;
   PanelBotoes.Width := 150;
   PanelBotoes.Height := 25;
   PanelBotoes.RowCollection.BeginUpdate;
   PanelBotoes.ColumnCollection.BeginUpdate;

   PanelBotoes.RowCollection.Clear;
   PanelBotoes.ColumnCollection.Clear;

   PanelBotoes.RowCollection.Add;
   PanelBotoes.RowCollection.Items[0].Value := 100;

   if (Botao1 <> '') and (Botao2 <> '') then begin

      PanelBotoes.ColumnCollection.Add;
      PanelBotoes.ColumnCollection.Items[0].Value := 100 / 2;
      PanelBotoes.ColumnCollection.Add;
      PanelBotoes.ColumnCollection.Items[1].Value := 100 / 2;

      BotaoNaoBackground := TRectangle.Create(PanelBotoes);
      BotaoNaoBackground.Align := TAlignLayout.Client;
      BotaoNaoBackground.Margins.Right := 5;
      BotaoNaoBackground.Cor(PrimaryColor);
      BotaoNaoBackground.Fill.Color := TAlphaColorRec.White;
      PanelBotoes.AddObject(BotaoNaoBackground);

      BotaoCancelar :=  TSpeedButton.Create(BotaoNaoBackground);
      BotaoNaoBackground.AddObject(BotaoCancelar);
      BotaoCancelar.Text := Botao1;
      BotaoCancelar.Font.Size := 10 ;
      BotaoCancelar.Align := TAlignLayout.Client;
      BotaoCancelar.Size.PlatformDefault := False;
      BotaoCancelar.FontColor := PrimaryColor;
      BotaoCancelar.StyledSettings := [];
      BotaoCancelar.Tag := Dados.Fields[0].AsInteger;
      BotaoCancelar.OnClick := BotaoCancelarClick;

      BotaoSimBackground := TRectangle.Create(PanelBotoes);
      BotaoSimBackground.Align := TAlignLayout.Client;
      BotaoSimBackground.Margins.Left := 5;
      BotaoSimBackground.Cor(PrimaryColor);
      PanelBotoes.AddObject(BotaoSimBackground);

      BotaoConfirmar :=  TSpeedButton.Create(BotaoSimBackground);
      BotaoSimBackground.AddObject(BotaoConfirmar);
      BotaoConfirmar.Text := Botao2;
      BotaoConfirmar.Font.Size := 10 ;
      BotaoConfirmar.Align := TAlignLayout.Client;

      BotaoConfirmar.TintColor := PrimaryColor;
      BotaoConfirmar.Size.PlatformDefault := False;
      BotaoConfirmar.FontColor := TAlphaColorRec.White;
      BotaoConfirmar.StyledSettings := [];

      BotaoConfirmar.Tag := Dados.Fields[0].AsInteger;
      BotaoConfirmar.OnClick := BotaoConfirmarClick;

      {$IF DEFINED(Android)}
      BotaoCancelar.StyleLookup := 'buttonstyle';
      BotaoConfirmar.StyleLookup := 'buttonstyle';
      {$ENDIF)}

   end else begin
      PanelBotoes.ColumnCollection.Add;
      PanelBotoes.ColumnCollection.Items[0].Value := 100;

      BotaoSimBackground := TRectangle.Create(PanelBotoes);
      BotaoSimBackground.Align := TAlignLayout.Client;
      BotaoSimBackground.Margins.Left := 5;
      BotaoSimBackground.Cor(PrimaryColor);
      PanelBotoes.AddObject(BotaoSimBackground);

      BotaoConfirmar :=  TSpeedButton.Create(BotaoSimBackground);
      BotaoSimBackground.AddObject(BotaoConfirmar);
      BotaoConfirmar.Text := Botao2;
      BotaoConfirmar.Font.Size := 10 ;
      BotaoConfirmar.Align := TAlignLayout.Client;

      BotaoConfirmar.TintColor := PrimaryColor;
      BotaoConfirmar.Size.PlatformDefault := False;
      BotaoConfirmar.FontColor := TAlphaColorRec.White;
      BotaoConfirmar.StyledSettings := [];

      BotaoConfirmar.Tag := Dados.Fields[0].AsInteger;
      BotaoConfirmar.OnClick := BotaoOkClick;
      PanelBotoes.Width := 75;
      {$IF DEFINED(Android)}
      BotaoConfirmar.StyleLookup := 'buttonstyle';
      {$ENDIF)}
   end;

   FundoBotoes.AddObject(PanelBotoes);

   AnimaEntrada := TFloatAnimation.Create(FundoMSG);
   FundoMSG.AddObject(AnimaEntrada);
   AnimaEntrada.Delay := 0.2;
   AnimaEntrada.Duration := 0.2;
   AnimaEntrada.PropertyName := 'Height';
   AnimaEntrada.StartValue := 0;
   AnimaEntrada.StopValue := 100;

   AnimaEntrada.Start;

   AnimaSaida := TFloatAnimation.Create(FundoMSG);
   FundoMSG.AddObject(AnimaSaida);
   AnimaSaida.Delay := 0.2;
   AnimaSaida.Duration := 0.2;
   AnimaSaida.PropertyName := 'Height';
   AnimaSaida.StartValue := 100;
   AnimaSaida.StopValue := 0;
   AnimaSaida.OnFinish := AvisoFinish;
end;

procedure TLayoutHelper.AvisoFinish(Sender: TObject);
begin
   FundoOpaco.DisposeOf;
end;

procedure TLayoutHelper.AnimaFinish(Sender: TObject);
begin
   Dados.Close;
   Dados.Open;
end;

function TLayoutHelper.BarTitulo(Text: string): TLayout;
begin
   BarText.Text := Text;
end;

procedure TLayoutHelper.BotaoCancelarClick(Sender: TObject);
begin
   AnimaSaida.Start;
end;

procedure TLayoutHelper.BotaoAddClick(Sender: TObject);
begin
   if Dados.Active then begin
      BotaoExit.Visible := False;
      BotaoBack.Visible := True;
      Dados.Insert;
      CarregaTela;
   end;
end;

procedure TLayoutHelper.BotaoBackClick(Sender: TObject);
begin
   BotaoBack.Visible := False;
   BotaoExit.Visible := True;
   Dados.Cancel;
   TabControl.GotoVisibleTab(0,TTabTransition.Slide);
end;

procedure TLayoutHelper.BotaoDeleteClick(Sender: TObject);
begin
   Card := ((Sender as TSpeedButton).Parent).Parent;
   Dados.Locate(Dados.Fields[0].FieldName, inttostr(TSpeedButton(Sender).Tag ),[]);
   Aviso(DicionarioText('Gostaria de excluir o registro?'),DicionarioText('Não'),DicionarioText('Sim'));
end;

procedure TLayoutHelper.BotaoConfirmarClick(Sender: TObject);
var
   PositionY :Real;
begin

   PositionY :=  TRectangle(Card).Position.Y;
   for I := 1 to VertDados.ComponentCount - 1  do begin
      if TRectangle(VertDados.Components[I]).Position.Y > PositionY then begin
         TRectangle(VertDados.Components[I]).AnimateFloat('Position.Y',
                    TRectangle(VertDados.Components[I]).Position.Y -(TRectangle(Card).Height+4),
                    0.2,
                    TAnimationType.&In,
                    TInterpolationType.Back);
      end;
   end;

   Card.DisposeOf;
   Dados.Delete;
   AnimaSaida.Start;
end;

procedure TLayoutHelper.BotaoEditClick(Sender: TObject);
begin
   BotaoExit.Visible := False;
   Dados.Locate(Dados.Fields[0].FieldName, inttostr(TSpeedButton(Sender).Tag ),[]);
   Dados.Edit;
   CarregaTela;
end;

procedure TLayoutHelper.BotaoExitClick(Sender: TObject);
begin
 
end;

procedure TLayoutHelper.BotaoLocalizarClick(Sender: TObject);
begin
   Dados.Close;
   Dados.Open;
end;

procedure TLayoutHelper.BotaoOkClick(Sender: TObject);
begin
   AnimaSaida.Start;
end;

procedure TLayoutHelper.BotaoSaveClick(Sender: TObject);
var Campo1, Campo2 :String;
    V :Extended;
begin

   for I := VertScroll.ComponentCount - 1 downto 1 do begin

      if VertScroll.Components[I].ClassName <> 'TLabel' then begin

         if VertScroll.Components[I].ClassName = 'TEdit' then begin

            if FieldTypeNames[Dados.FieldByName((VertScroll.Components[I] as TEdit).StyleName).DataType] = 'AutoInc' then
               Dados.FieldByName((VertScroll.Components[I] as TEdit).StyleName).AsString := (VertScroll.Components[I] as TEdit).Text
            else if not Dados.FieldByName((VertScroll.Components[I] as TEdit).StyleName).ReadOnly then begin
               if FieldTypeNames[Dados.FieldByName((VertScroll.Components[I] as TEdit).StyleName).DataType] = 'Float' then begin

                  if (VertScroll.Components[I] as TEdit).Text <> '' then begin
                     if TryStrToFloat((VertScroll.Components[I] as TEdit).Text,v) then
                        Dados.FieldByName((VertScroll.Components[I] as TEdit).StyleName).AsFloat := V
                     else begin
                        (VertScroll.Components[I] as TEdit).SetFocus;
                        Aviso('Informe um valor válido','','OK'  );
                        Abort;
                     end;

                  end else
                     Dados.FieldByName((VertScroll.Components[I] as TEdit).StyleName).AsString := '';

               end else
                 Dados.FieldByName((VertScroll.Components[I] as TEdit).StyleName).AsString := (VertScroll.Components[I] as TEdit).Text

            end;
         end

         else

         if VertScroll.Components[I].ClassName = 'TDateEdit' then begin

            if not Dados.FieldByName((VertScroll.Components[I] as TDateEdit).StyleName).ReadOnly then begin
               if (VertScroll.Components[I] as TDateEdit).Text = '' then
                  Dados.FieldByName((VertScroll.Components[I] as TDateEdit).StyleName).AsVariant := Null
               else
                  Dados.FieldByName((VertScroll.Components[I] as TDateEdit).StyleName).AsDateTime := (VertScroll.Components[I] as TDateEdit).Date
            end;

         end

         else

         if VertScroll.Components[I].ClassName = 'TSwitch' then begin
            if not Dados.FieldByName((VertScroll.Components[I] as TSwitch).StyleName).ReadOnly then
               Dados.FieldByName((VertScroll.Components[I] as TSwitch).StyleName).AsBoolean := (VertScroll.Components[I] as TSwitch).IsChecked

         end

         else

         if VertScroll.Components[I].ClassName = 'TCheckBox' then begin
            if not Dados.FieldByName((VertScroll.Components[I] as TCheckBox).StyleName).ReadOnly then
               Dados.FieldByName((VertScroll.Components[I] as TCheckBox).StyleName).AsBoolean := (VertScroll.Components[I] as TCheckBox).IsChecked

         end

         else


         if VertScroll.Components[I].ClassName = 'TComboEdit' then begin

            if (VertScroll.Components[I] as TComboEdit).Text = '' then begin
                Dados.FieldByName((VertScroll.Components[I] as TComboEdit).StyleName).AsVariant := Null;
            end else begin

               Dados2 := TFDQuery.Create(nil);
               Dados2.Connection := Dados.Connection;

               Dados2.Open('PRAGMA table_info('+ ((VertScroll.Components[I] as TComboEdit).StyleName).Replace('ID_','')+')');
               Dados2.First;
               Campo1 := Dados2.Fields[1].AsString;
               Dados2.Next;
               Campo2 := Dados2.Fields[1].AsString;

               Dados2.Open('SELECT '+Campo1+',' + Campo2  +
                           ' FROM '+((VertScroll.Components[I] as TComboEdit).StyleName).Replace('ID_','') +
                           ' WHERE '+ Campo2 + ' = "'+(VertScroll.Components[I] as TComboEdit).Text+'"');


               if (VertScroll.Components[I] as TComboEdit).ItemIndex <> -1 then begin // já existe

                  Dados.FieldByName((VertScroll.Components[I] as TComboEdit).StyleName).AsInteger := Dados2.Fields[0].AsInteger;
               end else begin
                  Dados2.Append;
                  Dados2.FieldByName(Campo2).AsString := (VertScroll.Components[I] as TComboEdit).Text;
                  Dados2.Post;

                  Dados.FieldByName((VertScroll.Components[I] as TComboEdit).StyleName).AsInteger := Dados2.Fields[0].AsInteger;

               end;

               Dados2.DisposeOf;
            end;
         end

         else

         if VertScroll.Components[I].ClassName = 'TComboBox' then begin

            if (VertScroll.Components[I] as TComboBox).ItemIndex = -1 then begin
                Dados.FieldByName((VertScroll.Components[I] as TComboBox).StyleName).AsVariant := Null;
            end else begin


//                SQLite.ExecSQLScalar()
//
//                Showmessage( (VertScroll.Components[I] as TComboBox).Items[(VertScroll.Components[I] as TComboBox).ItemIndex]);

                Dados2 := TFDQuery.Create(nil);
                Dados2.Connection := Dados.Connection;

                Dados2.Open('PRAGMA table_info('+ ((VertScroll.Components[I] as TComboBox).StyleName).Replace('ID_','')+')');
                Dados2.First;
                Campo1 := Dados2.Fields[1].AsString;
                Dados2.Next;
                Campo2 := Dados2.Fields[1].AsString;

                Dados2.Open('SELECT '+Campo1+',' + Campo2  +
                           ' FROM '+  ((VertScroll.Components[I] as TComboBox).StyleName).Replace('ID_','') +
                           ' WHERE '+ Campo2 + ' = "'+ ((VertScroll.Components[I] as TComboBox).Items[(VertScroll.Components[I] as TComboBox).ItemIndex])+'"');

                Dados.FieldByName((VertScroll.Components[I] as TComboBox).StyleName).AsInteger := Dados2.Fields[0].AsInteger;

                Dados2.DisposeOf;
            end;
         end

         else

         if VertScroll.Components[I].ClassName = 'TMemo' then begin
            if not Dados.FieldByName((VertScroll.Components[I] as TMemo).StyleName).ReadOnly Then
               Dados.FieldByName((VertScroll.Components[I] as TMemo).StyleName).Value := (VertScroll.Components[I] as TMemo).Lines.Text;
         end;

      end;
   end;

   try
      Dados.Post;

   except
      on E:Exception do  begin
         Aviso(DicionarioText((E.message).Replace('[FireDAC][Phys][SQLite] ERROR:','')),'','OK'  );


         abort;
      end;
   end;

   BotaoBack.Visible := False;
   BotaoExit.Visible := True;
   TabControl.GotoVisibleTab(0,TTabTransition.Slide);
end;

procedure TLayoutHelper.CarregaTela;
var I : Integer;
    CampoEdit  :TEdit;
    CampoDate  :TDateEdit;

    CampoBool  :TSwitch;
    CampoCheck  :TCheckBox;


    CampoMemo  :TMemo;
    CampoCombo :TComboEdit;
    CampoCombobox :TComboBox;
    Campo1,Campo2 :String;
begin

   for I := VertScroll.ComponentCount - 1 downto 1 do
       VertScroll.Components[I].DisposeOf ;

   ColunasField := ColunasField.Replace(',',' ').Replace('  ',' ').Trim;
   if ColunasField = '' then begin
      for I := 0 to Dados.FieldCount -1 do begin
          ColunasField := ColunasField + ' ' + Dados.Fields[I].FieldName ;
      end;
   end;

   for I := 0 to Dados.FieldCount -1 do begin

      if AnsiContainsText(ColunasField,' '+ Dados.Fields[i].FieldName) then begin
         VertScroll.AddLabel(Dados.Fields[i].FieldName);

         If Dados.Fields[i].ReadOnly then begin
            CampoNome := TLabel.Create(VertScroll);
            CampoNome.Text := Dados.Fields[i].AsString;
            CampoNome.StyledSettings := [];
            CampoNome.FontColor := TAlphaColorRec.Dimgray;
            VertScroll.AddObject(CampoNome);
            CampoNome.Align := TAlignLayout.Top;
            CampoNome.AutoSize := True;
            CampoNome.Position.Y := 500;
         end else

         if (FieldTypeNames[Dados.Fields[i].DataType] = 'AutoInc') or (FieldTypeNames[Dados.Fields[i].DataType] = 'String')  then begin
            CampoEdit := TEdit.Create(VertScroll);
            VertScroll.AddObject(CampoEdit);
            CampoEdit.OnEnter := AjusteEnter;
            CampoEdit.Enabled := not (FieldTypeNames[Dados.Fields[i].DataType] = 'AutoInc') ;
            CampoEdit.Text := Dados.Fields[i].AsString;
            CampoEdit.StyledSettings := [];
            CampoEdit.Align := TAlignLayout.Top;
            CampoEdit.Position.Y :=  CampoNome.Position.Y;
            CampoEdit.StyleName := Dados.Fields[i].FieldName;

            if AnsiLowerCase(Dados.Fields[i].FieldName) = 'senha' then
               CampoEdit.Password := True;

            CampoEdit.ReadOnly := Dados.Fields[i].ReadOnly;

            CampoEdit.ReturnKeyType := TReturnKeyType.Next;

         end else if FieldTypeNames[Dados.Fields[i].DataType] = 'Float' then begin
            CampoEdit := TEdit.Create(VertScroll);
            VertScroll.AddObject(CampoEdit);
            CampoEdit.OnEnter := AjusteEnter;

            if Dados.Fields[i].AsString <> '' then
               CampoEdit.Text := FormatFloat('0.00',Dados.Fields[i].AsFloat)
            else
               CampoEdit.Text := '';
            CampoEdit.StyledSettings := [];
            CampoEdit.Align := TAlignLayout.Top;
            CampoEdit.Position.Y :=  CampoNome.Position.Y;
            CampoEdit.StyleName := Dados.Fields[i].FieldName;
            CampoEdit.FilterChar := '0123456789,';
            CampoEdit.ReadOnly := Dados.Fields[i].ReadOnly;
            CampoEdit.ReturnKeyType := TReturnKeyType.Next;
         end else if (FieldTypeNames[Dados.Fields[i].DataType] = 'Date') or (FieldTypeNames[Dados.Fields[i].DataType] = 'DateTime') then begin
            CampoDate := TDateEdit.Create(VertScroll);
            VertScroll.AddObject(CampoDate);
            CampoDate.IsEmpty := True;
            CampoDate.OnEnter := AjusteEnter;
            CampoDate.Text := Dados.Fields[i].AsString;
            CampoDate.StyledSettings := [];
            CampoDate.Align := TAlignLayout.Top;
            CampoDate.Position.Y :=  CampoNome.Position.Y;
            CampoDate.StyleName := Dados.Fields[i].FieldName;

            CampoDate.ReadOnly := Dados.Fields[i].ReadOnly;

         end else if FieldTypeNames[Dados.Fields[i].DataType] = 'Time' then begin

         end else if FieldTypeNames[Dados.Fields[i].DataType] = 'WideMemo' then begin
            CampoMemo := TMemo.Create(VertScroll);
            VertScroll.AddObject(CampoMemo);
            CampoMemo.OnEnter := AjusteEnter;
            CampoMemo.Text := Dados.Fields[i].AsString;
            CampoMemo.StyledSettings := [];
            CampoMemo.Align := TAlignLayout.Top;
            CampoMemo.Position.Y :=  CampoNome.Position.Y;

            CampoMemo.StyleName := Dados.Fields[i].FieldName;
            CampoMemo.WordWrap := True;
            CampoMemo.Size.Height := 96;
            CampoMemo.ReadOnly := Dados.Fields[i].ReadOnly;

         end else if FieldTypeNames[Dados.Fields[i].DataType] = 'Integer' then begin

            if LeftStr(Dados.Fields[i].FieldName,3) = 'ID_' then begin
               Dados2 := TFDQuery.Create(nil);
               Dados2.Connection := Dados.Connection;

               Dados2.Open('PRAGMA table_info('+ (Dados.Fields[i].FieldName).Replace('ID_','')+')');

               Dados2.First;
               Campo1 := Dados2.Fields[1].AsString;
               Dados2.Next;
               Campo2 := Dados2.Fields[1].AsString;

               if Campo1 <> '' then begin


                  if Dados2.RecordCount > 2 then begin
                     Dados2.Open('SELECT '+Campo1+',' + Campo2  +' FROM '+(Dados.Fields[i].FieldName).Replace('ID_',''));

                     CampoCombobox := TComboBox.Create(VertScroll);
                     VertScroll.AddObject(CampoCombobox);

                     Dados2.IndexFieldNames := Campo2;
                     Dados2.First;
                     while not Dados2.Eof do begin
                         CampoCombobox.Items.Add(Dados2.Fields[1].AsString);
                         if Dados2.Fields[0].AsString = Dados.Fields[i].AsString then
                            CampoCombobox.ItemIndex := Dados2.RecNo-1;

                         Dados2.Next;
                     end;

                     CampoCombobox.OnEnter := AjusteEnter;
                     CampoCombobox.StyleName := Dados.Fields[i].FieldName;
                     CampoCombobox.Align := TAlignLayout.Top;
                     CampoCombobox.Position.Y :=  CampoNome.Position.Y;
                  end else begin
                     Dados2.Open('SELECT '+Campo1+',' + Campo2  +' FROM '+(Dados.Fields[i].FieldName).Replace('ID_',''));

                     CampoCombo := TComboEdit.Create(VertScroll);
                     VertScroll.AddObject(CampoCombo);

                     Dados2.IndexFieldNames := Campo2;
                     Dados2.First;
                     while not Dados2.Eof do begin
                         CampoCombo.Items.Add(Dados2.Fields[1].AsString);
                         if Dados2.Fields[0].AsString = Dados.Fields[i].AsString then
                            CampoCombo.ItemIndex := Dados2.RecNo;

                         Dados2.Next;
                     end;
                     CampoCombo.OnEnter := AjusteEnter;
                     CampoCombo.StyleName := Dados.Fields[i].FieldName;
                     CampoCombo.Align := TAlignLayout.Top;
                     CampoCombo.Position.Y :=  CampoNome.Position.Y;
                  end;
               end;
               Dados2.DisposeOf;

            end;

         end else if FieldTypeNames[Dados.Fields[i].DataType] = 'Boolean' then begin

            {$IF DEFINED(Android)}
            CampoBool := TSwitch.Create(VertScroll);
            CampoNome.AddObject(CampoBool);
            if not Dados.Fields[i].IsNull then
               CampoBool.IsChecked := Dados.Fields[i].Value
            else
               CampoBool.IsChecked := True;
            CampoNome.Height := 32;
            CampoNome.Margins.Top := 10;
            CampoNome.Margins.Bottom := 10;
            CampoBool.Align := TAlignLayout.Right;
            CampoBool.Position.Y :=  CampoNome.Position.Y;
            CampoBool.StyleName := Dados.Fields[i].FieldName;
            CampoBool.OnEnter := AjusteEnter;
            {$ENDIF}

            {$IF DEFINED(MSWINDOWS)}
            CampoCheck := TCheckBox.Create(VertScroll);
            VertScroll.AddObject(CampoCheck);
            if not Dados.Fields[i].IsNull then
               CampoCheck.IsChecked := Dados.Fields[i].Value
            else
               CampoCheck.IsChecked := True;

            CampoCheck.Text := CampoNome.Text;
            CampoCheck.Height := 32;
            CampoCheck.Margins.Top := 10;
            CampoCheck.Margins.Bottom := 10;
            CampoCheck.Align := TAlignLayout.Top;
            CampoCheck.Position.Y :=  CampoNome.Position.Y;
            CampoCheck.StyleName := Dados.Fields[i].FieldName;
            CampoCheck.OnEnter := AjusteEnter;
            CampoNome.DisposeOf;
            {$ENDIF}

         end;
      end;
   end;

   TabControl.Next(TTabTransition.Slide);
end;


procedure TLayoutHelper.Clear;
var I : Integer;
begin
   for I := Self.ControlsCount - 1 downto 0 do
      Self.Controls[I].DisposeOf
end;

function TLayoutHelper.Criar: TLayout;
var Msg :string;
begin

   FundoBotaoAdd.ImageByName('Fundo');
   FundoBotaoSave.ImageByName('Fundo');
   FundoBotaoAdd.AddIcone('Add');
   FundoBotaoSave.AddIcone('Post');


   try
     Dados.Open;
   except
      on E:Exception do  begin

         Msg := (E.message).Replace('[FireDAC][Phys][SQLite] ERROR:','');

         Msg := (Msg).Replace('no such table:','Ops, não encontramos a tabela');;

         Msg := (Msg).Replace('no such column:','Ops, existe um problema com o campo');;

         if ContainsStr(Msg,'syntax error') then
            Msg := 'Ops, existe um problema com sua solicitação'+  Msg.Replace(': syntax error','').Replace('near','') ;

         Showmessage(Msg);

         abort;
      end;
   end;
end;

procedure EncerraAnimation;
begin

end;

function TLayoutHelper.CorPadrao(Color: TAlphaColor): TLayout;
begin
   PrimaryColor := Color;

   BarBackground.Cor(Color);
   ImageLoad;
end;

procedure ImageLoad;
begin
   FundoBotaoAdd.ImageByName('Fundo');
   FundoBotaoSave.ImageByName('Fundo');
   FundoBotaoAdd.AddIcone('Add');
end;


function TLayoutHelper.Substituir(Text, Text2: String): TLayout;
begin
   Dicionario.AddOrSetValue(Text,Text2);
end;

{ TShapeHelper }

procedure TShapeHelper.Cor(Cor: TAlphaColor);
begin
   if Fill.Kind <> TBrushKind.Bitmap then begin
      Fill.Color := Cor;
      Stroke.Color := Cor;
   end;
end;

procedure TShapeHelper.AddIcone(Name: String);
var
   Item: TCustomBitmapItem;
   Size: TSize;
begin

   Icones := TRectangle.Create(Self);
   Self.AddObject(Icones);
   Icones.Align := TAlignLayout.Center;
   Icones.Fill.Kind := TBrushKind.Bitmap;
   Icones.Stroke.Kind := TBrushKind.None;
   Icones.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
   Icones.ImageByName(Name);
   Icones.HitTest := False;
   Icones.ReplaceColor(TAlphaColorRec.White);
   Icones.Height := 25 ;
   Icones.Width :=  25;

end;

procedure TShapeHelper.ImageByName(Name: String);
var
   Item: TCustomBitmapItem;
   Size: TSize;
   i :integer;
   Icone:Boolean;
begin
   icone := False;
   for I := 0 to ListIcons.Source.Count -1 do begin
      if ListIcons.Source[i].Name = Name then begin
         ListIcons.BitmapItemByName(Name, Item, Size);
         Icone := True;
      end;
   end;

   if Icone then begin
      Self.Fill.Kind := TBrushKind.Bitmap;
      Self.Stroke.Kind := TBrushKind.None;
      Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
      Self.Fill.Bitmap.Bitmap := Item.MultiResBitmap.Bitmaps[1.0];
      if Name = 'Fundo' then
         Self.ReplaceColor(BarBackground.Fill.Color)
      else begin
         Self.ReplaceColor(TAlphaColorRec.White)
      end;

   end else begin
      Self.Fill.Color := BarBackground.Fill.Color;
      Self.Stroke.Color := BarBackground.Fill.Color;
   end;

end;


procedure TShapeHelper.ReplaceColor(Cor: TAlphaColor);
begin
   Self.Fill.Bitmap.Bitmap.ReplaceOpaqueColor(Cor);
end;

procedure TShapeHelper.Sombra(Cor: TAlphaColor);
var
   Shadow :TShadowEffect;
begin
   Shadow := TShadowEffect.Create(Self);
   Self.AddObject(Shadow);
   Shadow.Distance := 1;
   Shadow.Direction := 45;
   Shadow.Softness := 0.1;
   Shadow.Opacity := 0.1;
   Shadow.ShadowColor := Cor
end;

procedure TShapeHelper.AddText(Texto :String; FontCor: TAlphaColor = TAlphaColorRec.Dimgray ;
 FontSize: Real = 10);
var T :TText;
begin
   if Texto <> '' then begin
      T := TText.Create(Self);
      T.Text := Texto;
      T.Align := TAlignLayout.Top;
      T.Margins.Left := 10;
      T.TextSettings.HorzAlign := TTextAlign.Leading;
      T.AutoSize := True;
      T.TextSettings.FontColor := FontCor;
      T.TextSettings.Font.Size := FontSize;
      T.Position.Y := Self.Height;
      Self.AddObject(T);
   end;
end;

procedure TLayoutHelper.AfterOpen(DataSet: TDataSet);
var
   R :TRoundRect;
   FX :TFloatAnimation;
   I,J :Integer;
   Fields :TArray<String>;
begin


   for I := 1 to VertDados.ComponentCount - 1  do begin

       TRectangle(
       VertDados.Components[I]).AnimateFloat('Position.X',
                     -500  ,
                    0.1 * I,
                    TAnimationType.&In,
                    TInterpolationType.Back);
   end;

   for I := VertDados.ComponentCount - 1 downto 1 do
       VertDados.Components[I].DisposeOf ;

   DataSet.First;

   while not DataSet.Eof do begin
      I := DataSet.RecNo-1;

      R := TRoundRect.Create(VertDados);
      R.Fill.Color := TAlphaColors.White;
      R.Stroke.Color := TAlphaColors.White;
      R.Height := 80;
      R.Tag := I;
      R.Width := EditLocalizar.Width;
      R.Position.X := (VertDados.Width + 10) * I;
      R.Corners := [];
      R.Padding.Top := 7;
      R.Padding.Left := 5;

      R.Sombra(TAlphaColors.Black);

      if ColunasCard = '' then ColunasCard := DataSet.Fields[1].FieldName;

      if ColunasCard <> '*' then begin

         Fields := TRegEx.Split(ColunasCard,',');
         for J := 0 to TRegEx.Matches(ColunasCard,',').Count do begin
            if DataSet.FindField(Fields[J]) <> nil then begin
               if J = 0 then
                  R.AddText(DataSet.FieldByName(Fields[J]).AsString, TAlphaColorRec.Dimgray,12)
               else
                  R.AddText(DataSet.FieldByName(Fields[J]).AsString);

            end;
         end;
         R.Height := (TRegEx.Matches(ColunasCard,',').Count+1) * 25;
         if R.Height = 25 then  R.Height := 35;

         R.Position.Y := I * (R.Height + 4);

         BotaoEditBackground := TRectangle.Create(R);
         BotaoEditBackground.Height := 25;
         BotaoEditBackground.Width := 75;
         BotaoEditBackground.Position.Y :=  R.Height - 5 - BotaoEditBackground.Height;
         BotaoEditBackground.Position.X :=  R.Width -10 - BotaoEditBackground.Width;
         BotaoEditBackground.Cor(PrimaryColor);
         R.AddObject(BotaoEditBackground);

         BotaoEdit :=  TSpeedButton.Create(BotaoEditBackground);
         BotaoEditBackground.AddObject(BotaoEdit);
         BotaoEdit.Text := DicionarioText('EDITAR');
         BotaoEdit.Font.Size := 8;
         BotaoEdit.Align := TAlignLayout.Client;
         BotaoEdit.Width := FundoBotaoSave.Width;
         BotaoEdit.Height := FundoBotaoSave.Width;
         BotaoEdit.Size.PlatformDefault := False;
         BotaoEdit.FontColor := TAlphaColorRec.White;
         BotaoEdit.StyledSettings := [];
         BotaoEdit.Tag := Dados.Fields[0].AsInteger;
         BotaoEdit.OnClick := BotaoEditClick;

         BotaoDeleteBackground := TRectangle.Create(R);
         BotaoDeleteBackground.Height := BotaoEditBackground.Height;
         BotaoDeleteBackground.Width := BotaoEditBackground.Width;
         BotaoDeleteBackground.Position.Y :=  BotaoEditBackground.Position.Y;
         BotaoDeleteBackground.Position.X :=  BotaoEditBackground.Position.X - BotaoDeleteBackground.Width - 10 ;
         BotaoDeleteBackground.Cor(PrimaryColor);
         R.AddObject(BotaoDeleteBackground);

         BotaoDelete :=  TSpeedButton.Create(R);
         BotaoDeleteBackground.AddObject(BotaoDelete);
         BotaoDelete.Text := DicionarioText('REMOVER');
         BotaoDelete.Font.Size := 8;
         BotaoDelete.Align := TAlignLayout.Client;
         BotaoDelete.Width := FundoBotaoSave.Width;
         BotaoDelete.Height := FundoBotaoSave.Width;
         BotaoDelete.Size.PlatformDefault := False;
         BotaoDelete.FontColor := TAlphaColorRec.White;
         BotaoDelete.StyledSettings := [];
         BotaoDelete.Tag := Dados.Fields[0].AsInteger;
         BotaoDelete.OnClick := BotaoDeleteClick;

         {$IF DEFINED(Android)}
         BotaoEdit.StyleLookup := 'buttonstyle';
         BotaoDelete.StyleLookup := 'buttonstyle';
         {$ENDIF)}

      end else begin

         for J := 0 to Dados.FieldCount -1 do begin
             if J = 0 then
                R.AddText(Dados.Fields[J].AsString, TAlphaColorRec.Dimgray,12)
             else
                R.AddText(Dados.Fields[J].AsString);

         end;

         R.Height := (Dados.FieldCount+1) * 25;
         if R.Height = 25 then  R.Height := 35;

         R.Position.Y := I * (R.Height + 4);



          FundoBotaoAdd.Visible := False;

      end;

      VertDados.AddObject(R);

      FX := TFloatAnimation.Create(nil);
      FX.Delay := I/100;
      FX.Duration := 0.1 * (I+1);
      FX.PropertyName := 'Position.X';
      FX.StartFromCurrent := True;
      FX.StopValue := EditLocalizar.Margins.Left;
      FX.OnFinish := FloatAnimation1Finish;
      FX.Tag := I;

      R.AddObject(FX);
      FX.Start;
      DataSet.Next;
   end;

end;



procedure TLayoutHelper.FloatAnimation1Finish(Sender: TObject);
begin

end;

procedure TLayoutHelper.FloatAnimation2Finish(Sender: TObject);
begin
end;

function TLayoutHelper.IndexColunas(StrIndex: String): TLayout;
begin
   ColunasCard := StrIndex;
end;

function TLayoutHelper.IndexFields(StrIndex: String): TLayout;
begin
   ColunasField := StrIndex;
end;

function TLayoutHelper.IndexFilters(StrIndex: String): TLayout;
begin
    ColunasFilter := StrIndex;
end;

procedure TLayoutHelper.AjusteEnter(Sender: TObject);
begin
  {$IF DEFINED(Android)}
  VertScroll.Margins.Bottom := 250;
  VertScroll.ViewportPosition := PointF(VertScroll.ViewportPosition.X, TControl(Sender).Position.Y - 90);
  {$ENDIF}
end;

{ TVertScrollBoxHelper }

procedure TVertScrollBoxHelper.AddLabel(AText: String);
begin
   CampoNome := TLabel.Create(VertScroll);
   CampoNome.Text := DicionarioText(AText);
   CampoNome.StyledSettings := [];
   CampoNome.FontColor := TAlphaColorRec.Dimgray;
   VertScroll.AddObject(CampoNome);
   CampoNome.Align := TAlignLayout.Top;
   CampoNome.Position.Y := 500;
end;

{ TFDConnectionHelper }

function TFDConnectionHelper.Add(FieldName: String): TFDConnection;
begin
   FieldName := (FieldName+',').Replace(',,',',');
   TableCreate.Append(FieldName);
end;

function TFDConnectionHelper.AddDATE(FieldName: String): TFDConnection;
begin
   TableCreate.Append(FieldName+' DATETIME,');
end;

function TFDConnectionHelper.AddDATE(FieldName,
  ReplaceName: String): TFDConnection;
begin
   AddDATE(FieldName);
   Dicionario.AddOrSetValue(FieldName,ReplaceName);
end;

function TFDConnectionHelper.AddDATE(FieldName, ReplaceName,
  Msg: String): TFDConnection;
begin
   AddDATE(FieldName, ReplaceName);
   if Msg = '' then
      Msg := ReplaceName +' deve ser informado';
   TriggerCreate.Append(' WHEN NEW.'+FieldName+' IS NULL THEN RAISE (ABORT,"' +Msg+ ' ") ');
end;

function TFDConnectionHelper.AddFLOAT(FieldName,
  ReplaceName: String): TFDConnection;
begin
   AddFLOAT(FieldName);
   Dicionario.AddOrSetValue(FieldName,ReplaceName);
end;

function TFDConnectionHelper.AddTEXT(FieldName,
  ReplaceName: String): TFDConnection;
begin
   AddTEXT(FieldName);
   Dicionario.AddOrSetValue(FieldName,ReplaceName);
end;


function TFDConnectionHelper.AddVARCHAR(FieldName: String;
  Size: Integer): TFDConnection;
begin
   TableCreate.Append(FieldName+' VARCHAR('+Inttostr(Size)+'),');
end;

function TFDConnectionHelper.AddVARCHAR(FieldName: String; Size: Integer;
  ReplaceName: String): TFDConnection;
begin
   AddVARCHAR(FieldName,Size);
   Dicionario.AddOrSetValue(FieldName,ReplaceName);
end;


function TFDConnectionHelper.AddVARCHAR(FieldName: String; Size: Integer;
  ReplaceName, Msg: String; Key :Boolean = false ): TFDConnection;
begin

   AddVARCHAR(FieldName,Size,ReplaceName);

   if Msg = '' then
      Msg := ReplaceName +' deve ser informado';
      TriggerCreate.Append(' WHEN NEW.'+FieldName+' = "" THEN RAISE (ABORT,"' +Msg+ ' ") ');

   if Key then begin

        Msg := ReplaceName +' já existe ';

        TriggerCreate.Append(' WHEN 0 < (SELECT COUNT(*) FROM ' +Table +' WHERE '+FieldName+' = NEW.'+FieldName+') THEN RAISE (ABORT,"' +Msg+  '")');

   end;


end;

function TFDConnectionHelper.AddFLOAT(FieldName: String): TFDConnection;
begin
   TableCreate.Append(FieldName+' FLOAT(15,2),');
end;

function TFDConnectionHelper.AddTEXT(FieldName: String): TFDConnection;
begin
   TableCreate.Append(FieldName+' TEXT,');
end;

function TFDConnectionHelper.CreateTable(TableName: String): TFDConnection;
begin
   Table := TableName;
   TriggerCreate.Clear;
   TableCreate.Clear;
   TableCreate.Append('CREATE TABLE IF NOT EXISTS '+Table+'('+
                      'ID INTEGER PRIMARY KEY AUTOINCREMENT,');
end;

procedure TFDConnectionHelper.Execute;
var Msg :String;
begin
   try

      SQLite.ExecSQL((TableCreate.ToString+')').Replace(',)',')'));

      if TriggerCreate.ToString <> '' then begin
         SQLite.ExecSQL('DROP TRIGGER IF EXISTS Validar_'+Table+';'+
                        'CREATE TRIGGER IF NOT EXISTS Validar_'+Table+
                        ' BEFORE INSERT ON '+Table +
                        ' BEGIN  '+
                        '    SELECT '+
                        '    CASE '+
                        TriggerCreate.ToString +
                        '    END;'+
                        ' END;  ');
      end;

   except
      on E:Exception do  begin

         Msg := (E.message).Replace('[FireDAC][Phys][SQLite] ERROR:','');

         Msg := (Msg).Replace('no such table:','Ops, não encontramos a tabela');;

         Msg := (Msg).Replace('no such column:','Ops, existe um problema com o campo');;

         if ContainsStr(Msg,'syntax error') then
            Msg := 'Ops, existe um problema com sua solicitação'+  Msg.Replace(': syntax error','').Replace('near','') ;

         Showmessage(Msg);

         abort;
      end;

   end;
end;

{ TSpeedButtonHelper }

procedure TSpeedButtonHelper.AddIcone(Name: String);
var
   Item: TCustomBitmapItem;
   Size: TSize;
begin

   Icones := TRectangle.Create(Self);
   Self.AddObject(Icones);
   Icones.Align := TAlignLayout.Center;
   Icones.Fill.Kind := TBrushKind.Bitmap;
   Icones.Stroke.Kind := TBrushKind.None;
   Icones.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
   Icones.ImageByName(Name);
   Icones.HitTest := False;
   Icones.ReplaceColor(TAlphaColorRec.White);
   Icones.Height := 25 ;
   Icones.Width :=  25;

end;


procedure TSpeedButtonHelper.ClonarEventos(Source: TSpeedButton);
var
  I: Integer;
  PropList: TPropList;
begin
  for I := 0 to GetPropList(Source.ClassInfo, [tkMethod], @PropList) - 1 do
    SetMethodProp(Self, PropList[I], GetMethodProp(Source, PropList[I]));

end;

initialization
   Dicionario := TDictionary<String,string>.Create;
   TableCreate := TStringBuilder.Create;
   TriggerCreate := TStringBuilder.Create;
   SQLite := TFDConnection.Create(nil);
   SQLite.Params.DriverID := 'SQLite';
   SQLite.Params.Password := '123';
   SQLite.Params.Database := System.IOUtils.TPath.Combine(
                             System.IOUtils.TPath.GetDocumentsPath,
                             'user.db');

   ListIcons := TImageList.Create(nil);

finalization

   TableCreate.DisposeOf;
   TriggerCreate.DisposeOf;
   Dicionario.DisposeOf;
   SQLite.DisposeOf;
end.
