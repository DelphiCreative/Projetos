unit uMain;

interface

uses
  {$IF DEFINED(android)}
  Androidapi.Helpers,
  FMX.Helpers.Android,
  {$ENDIF}
  FMX.VirtualKeyboard,
  FMX.Platform,
  FMX.DialogService.Async,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects, FMX.Objects, FMX.Controls.Presentation, FMX.TabControl,
  FMX.MultiView, FMX.Layouts, FMX.ScrollBox, FMX.Memo, FMX.Ani, FMX.ListBox,
  FMX.Colors;

type
  TForm2 = class(TForm)
    TabControl: TTabControl;
    TabHome: TTabItem;
    TabCadastro: TTabItem;
    ToolBar1: TToolBar;
    BarraTitulo: TRectangle;
    ShadowEffect1: TShadowEffect;
    BotaoMenu: TSpeedButton;
    Menu: TMultiView;
    Layout1: TLayout;
    Memo1: TMemo;
    MenuCadastro: TRectangle;
    BotaoCadastro: TSpeedButton;
    Label1: TLabel;
    BotaoClientes: TSpeedButton;
    Rectangle2: TRectangle;
    MenuScroll: TVertScrollBox;
    MenuFundo: TRectangle;
    Rectangle3: TRectangle;
    Line1: TLine;
    Label2: TLabel;
    Line2: TLine;
    BotaoFornecedores: TSpeedButton;
    Rectangle4: TRectangle;
    Label3: TLabel;
    Line3: TLine;
    MenuLiquidar: TRectangle;
    BotaoLiquidar: TSpeedButton;
    LabelLiquidarContas: TLabel;
    Line4: TLine;
    BotaoRecebimento: TSpeedButton;
    Rectangle6: TRectangle;
    BotaoPagamento: TSpeedButton;
    Rectangle7: TRectangle;
    Label6: TLabel;
    Line6: TLine;
    BotaoCategoria: TSpeedButton;
    Rectangle8: TRectangle;
    Label4: TLabel;
    Line7: TLine;
    MenuLancamento: TRectangle;
    BotaoLancamento: TSpeedButton;
    Label7: TLabel;
    Line8: TLine;
    BotaoReceita: TSpeedButton;
    Rectangle10: TRectangle;
    Label8: TLabel;
    Line9: TLine;
    BotaoDespesas: TSpeedButton;
    Rectangle11: TRectangle;
    Label9: TLabel;
    Line10: TLine;
    IconeMenu: TImage;
    Label10: TLabel;
    Label11: TLabel;
    Label5: TLabel;
    Line5: TLine;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure BotaoClientesClick(Sender: TObject);
    procedure BotaoCadastroClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure Voltar;
    procedure MenuAparencia(MenuRet : TRectangle);
    procedure Style(Cor :TAlphaColor =  TAlphaColorRec.Cornflowerblue);

  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.FormCreate(Sender: TObject);
begin

   TabControl.TabPosition := TTabPosition.None;
   TabControl.GotoVisibleTab(0);

   Style(TAlphaColorRec.Darkred);

end;

procedure TForm2.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
   Shift: TShiftState);
var
   FService : IFMXVirtualKeyboardService;
begin
   if Key = vkHardwareBack then begin
      TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
      if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then begin
      //  Se Botão Voltar pressionado e o teclado estiver visível não faz nada ...
      end else begin
         Key := 0;
         Voltar;
      end;
   end;
end;

procedure TForm2.MenuAparencia(MenuRet : TRectangle);
var I,J :Integer;
begin
   MenuRet.Height := 48;
   for I := 0 to MenuRet.ControlsCount - 1 do begin
      for J := 0 to (MenuRet.Controls[I]).ControlsCount - 1 do begin
         if (MenuRet.Controls[I]).Controls[J].ClassName = 'TLabel' then begin
            TLabel((MenuRet.Controls[I]).Controls[J]).FontColor := BarraTitulo.Fill.Color;
            TLine(TLabel((MenuRet.Controls[I]).Controls[J]).Controls[0]).Stroke.Color := BarraTitulo.Fill.Color;
         end else if (MenuRet.Controls[I]).Controls[J].ClassName = 'TRectangle' then begin
            TRectangle((MenuRet.Controls[I]).Controls[J]).Fill.Bitmap.Bitmap.ReplaceOpaqueColor(BarraTitulo.Fill.Color);

         end;
      end;
   end;
end;

procedure TForm2.BotaoClientesClick(Sender: TObject);
begin
   //TabControl.GotoVisibleTab(1);
   Menu.HideMaster;
end;


procedure TForm2.Style(Cor: TAlphaColor);
begin
  {$IF DEFINED(android) }
   CallInUIThreadAndWaitFinishing(
   procedure begin
     TAndroidHelper.Activity.getWindow.setStatusBarColor(Cor);
   end);
   {$ENDIF}

   BarraTitulo.Fill.Color := Cor;

   MenuAparencia(MenuCadastro);
   MenuAparencia(MenuLancamento);
   MenuAparencia(MenuLiquidar);
end;

procedure TForm2.Voltar;
begin
   if TabControl.TabIndex = 0 then begin
      TDialogServiceAsync.MessageDialog(('Sair do aplicativo?'),
                                        system.UITypes.TMsgDlgType.mtConfirmation,
                                        [system.UITypes.TMsgDlgBtn.mbYes, system.UITypes.TMsgDlgBtn.mbNo], system.UITypes.TMsgDlgBtn.mbYes,0,
      procedure (const AResult: System.UITypes.TModalResult)
                       begin
                          case AResult of
                              mrYES: begin
                              Close;
                             end;
                          end;
                       end);

   end else begin
      TabControl.GotoVisibleTab(0);
   end;
end;

procedure TForm2.BotaoCadastroClick(Sender: TObject);
begin
   if TSpeedButton(Sender).Height = TRectangle(TSpeedButton(Sender).Parent).Height then begin

      TRectangle(TSpeedButton(Sender).Parent).AnimateFloat('Height',
                                                           TRectangle(TSpeedButton(Sender).Parent).ControlsCount * TSpeedButton(Sender).Height,
                                                           0.3,
                                                           TAnimationType.&In,
                                                           TInterpolationType.Circular
                                                            );

   end else begin
      TRectangle(TSpeedButton(Sender).Parent).AnimateFloat('Height',
                                                           TSpeedButton(Sender).Height,
                                                           0.3,
                                                           TAnimationType.&In,
                                                           TInterpolationType.Circular
                                                           );

   end;
end;

end.
