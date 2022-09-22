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
  FMX.Colors, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, System.ImageList, FMX.ImgList, FMX.Memo.Types;

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
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure BotaoClientesClick(Sender: TObject);
    procedure BotaoCadastroClick(Sender: TObject);
    procedure BotaoCategoriaClick(Sender: TObject);
    procedure BotaoFornecedoresClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure Voltar;
    procedure MenuAparencia(MenuRet : TRectangle);
    procedure Style(Cor :TAlphaColor =  TAlphaColorRec.Cornflowerblue);
    procedure SQLiteDB;
    procedure ExitClick(Sender :TObject);

  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses FMX.Fast;

procedure TForm2.FormCreate(Sender: TObject);
begin

   TabControl.TabPosition := TTabPosition.None;
   TabControl.GotoVisibleTab(0);

   Style(TAlphaColorRec.Darkred);

   ListIcons := ImageList1;

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

procedure TForm2.BotaoCategoriaClick(Sender: TObject);
begin
   SQLiteDB;

   Dicionario.AddOrSetValue('ID_Cidade','Cidade');

   Layout1.AppCadastro('SELECT * FROM Cidade')
          .BarTitulo('Cadastro de Cidades')
          .CorPadrao( BarraTitulo.Fill.Color)
          .IndexFilters('ID,Cidade')
          .Criar;

   TabControl.GotoVisibleTab(1);
   Menu.HideMaster;
end;

procedure TForm2.BotaoClientesClick(Sender: TObject);
begin

   SQLiteDB;

   Dicionario.AddOrSetValue('ID','Código');

   Dicionario.AddOrSetValue('Nome','Nome do Cliente');
   Dicionario.AddOrSetValue('Telefone','Celular');
   Dicionario.AddOrSetValue('ID_Cidade','Cidade');


   Layout1.AppCadastro('SELECT * FROM Cliente ' +
                      ' INNER JOIN Cidade ON Cidade.ID = Cliente.ID_Cidade '
                        )

          .BarTitulo('Cadastro de Clientes')
          .CorPadrao( BarraTitulo.Fill.Color)
          .IndexFilters('ID,Nome')
          .IndexColunas('Nome,Email,Telefone,CPF')
          .IndexFields('ID,Nome,CPF,Email,Telefone,ID_Cidade,Ativo')
          .Criar;

   BotaoExit.OnClick := ExitClick;

   TabControl.GotoVisibleTab(1);
   Menu.HideMaster;
end;


procedure TForm2.BotaoFornecedoresClick(Sender: TObject);
begin

   SQLite.CreateTable('fornecedor')
         .Add('ID_Cidade INTEGER,Ativo BOOLEAN')
         .AddVARCHAR('CNPJ',20,'CNPJ','Informe o CNPJ',True)
         .AddVARCHAR('Email',100)
         .AddVARCHAR('Telefone',18)
         .AddVARCHAR('Nome',100,'Nome do Fornecedor','Informe o nome do fornecedor')
         .Execute;

   Layout1.AppCadastro('SELECT fornecedor.ID,'+
                      ' fornecedor.Nome,'+
                      ' fornecedor.CNPJ,'+
                      ' fornecedor.Email,'+
                      ' fornecedor.Telefone,'+
                      ' cidade.* FROM fornecedor ' +
                      ' LEFT JOIN Cidade ON Cidade.ID = fornecedor.ID_Cidade '
                        )

          .BarTitulo('Cadastro de Fornecedor')
          .CorPadrao( BarraTitulo.Fill.Color)
          .IndexFilters('ID,Nome')
          .IndexColunas('Nome,Email,Telefone,CPF')
          .IndexFields('ID,Nome,CNPJ,Email,Telefone,ID_Cidade,Ativo')
          .Criar;

   BotaoExit.OnClick := ExitClick;

   TabControl.GotoVisibleTab(1);
   Menu.HideMaster;


end;

procedure TForm2.ExitClick(Sender: TObject);
begin
   TabControl.GotoVisibleTab(0);
end;

procedure TForm2.SQLiteDB;
begin
   Dicionario.AddOrSetValue('ID','Código');

   SQLite.ExecSQL('CREATE TABLE IF NOT EXISTS Cliente( '+
                  '   ID INTEGER PRIMARY KEY AUTOINCREMENT, '+
                  '   Nome VARCHAR(100), '+
                  '   CPF VARCHAR(14), '+
                  '   Email VARCHAR(100), '+
                  '   Telefone VARCHAR(18), '+
                  '   ID_Cidade INTEGER ' +
                  '   Ativo BOOLEAN '+
                  '   ); ');

   SQLite.ExecSQL('DROP TRIGGER IF EXISTS Validar_Cliente; '+
                 'CREATE TRIGGER IF NOT EXISTS Validar_Cliente '+
                 'BEFORE INSERT ON Cliente '+
                 'BEGIN '+
                 '  SELECT '+
                 '    CASE '+
                 '      WHEN 0 < (select Count(*) from Cliente WHERE CPF = NEW.CPF) THEN RAISE (ABORT,"Cpf já cadastrado ") '+
                 '      WHEN (NEW.Nome IS NULL OR NEW.Nome ="")  THEN RAISE (ABORT,"Informe o nome ") '+
                 '      WHEN (NEW.Email IS NULL OR NEW.Email ="")  THEN RAISE (ABORT,"Informe o e-mail ") '+
                 '      WHEN (NEW.Telefone IS NULL OR NEW.Telefone ="")  THEN RAISE (ABORT,"Informe um telefone ") '+
                 '    END; '+
                 'END; ');

   SQLite.ExecSQL('CREATE TABLE IF NOT EXISTS Cidade( '+
                  '   ID INTEGER PRIMARY KEY AUTOINCREMENT, '+
                  '   Cidade VARCHAR(100)); ');


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
