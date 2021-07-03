unit uMain;

interface

uses
  FMX.Objects, FMX.StdCtrls, FMX.Effects, FMX.TabControl, FMX.MultiView,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs;

type
  TForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Fundo, BarraTitulo : TRectangle;
    Sombra : TShadowEffect;
    Titulo : TText;

    BotaoMenu, BotaoSair :TSpeedButton;
    IconeMenu, IconeSair :TImage;

    AppControl : TTabControl;
    AppHome, AppLista :TTabItem;

    MenuLateral :TMultiView;

  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.FormCreate(Sender: TObject);
begin
   Fundo := TRectangle.Create(Self);
   Self.AddObject(Fundo);
   Fundo.Align := TAlignLayout.Client;
   Fundo.Fill.Color := TAlphaColorRec.White;
   Fundo.Stroke.Color := TAlphaColorRec.White;

   BarraTitulo := TRectangle.Create(Self);
   Self.AddObject(BarraTitulo);
   BarraTitulo.Align := TAlignLayout.Top;
   BarraTitulo.Fill.Color := TAlphaColorRec.DarkRed;
   BarraTitulo.Stroke.Color := TAlphaColorRec.DarkRed;

   Sombra := TShadowEffect.Create(BarraTitulo);
   BarraTitulo.AddObject(Sombra);
   Sombra.Opacity := 0.5;
   Sombra.Softness := 0.2;
   Sombra.ShadowColor := BarraTitulo.Fill.Color;

   BotaoMenu := TSpeedButton.Create(BarraTitulo);
   BarraTitulo.AddObject(BotaoMenu);
   BotaoMenu.Align := TAlignLayout.Left;
   BotaoMenu.Width := BarraTitulo.Height;

   IconeMenu := TImage.Create(BotaoMenu);
   BotaoMenu.AddObject(IconeMenu);
   IconeMenu.Align := TAlignLayout.Center;
   IconeMenu.HitTest := False;
   IconeMenu.Height := 25;
   IconeMenu.Width := 25;

   BotaoSair := TSpeedButton.Create(BarraTitulo);
   BarraTitulo.AddObject(BotaoSair);
   BotaoSair.Align := TAlignLayout.Right;
   BotaoSair.Width := BarraTitulo.Height;

   IconeSair := TImage.Create(BotaoSair);
   BotaoSair.AddObject(IconeSair);
   IconeSair.HitTest := False;
   IconeSair.Align := TAlignLayout.Center;
   IconeSair.Height := 25;
   IconeSair.Width := 25;

   MenuLateral := TMultiView.Create(Self);
   Self.AddObject(MenuLateral);
   MenuLateral.Mode := TMultiViewMode.Drawer;
   MenuLateral.MasterButton := BotaoMenu;
   Titulo := TText.Create(BarraTitulo);
   BarraTitulo.AddObject(Titulo);
   Titulo.Align := TAlignLayout.Client;
   Titulo.Text := 'APP DO ZERO';
   Titulo.TextSettings.HorzAlign := TTextAlign.Leading;
   Titulo.TextSettings.FontColor := TAlphaColorRec.White;
   Titulo.TextSettings.Font.Size := 18;


   AppControl := TTabControl.Create(Fundo);
   AppControl.Align := TAlignLayout.Client;
   Fundo.AddObject(AppControl);

   AppHome := TTabItem.Create(AppControl);
   AppHome.Text := 'HOME';
   AppControl.AddObject(AppHome);

   AppLista := TTabItem.Create(AppControl);
   AppLista.Text := 'LISTA';
   AppControl.AddObject(AppLista);

end;

end.
