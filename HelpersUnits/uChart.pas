unit uChart;

interface

uses
  System.JSON,
  System.Net.URLClient,System.Net.HttpClient, System.Net.HttpClientComponent,
  FMX.Graphics, FMX.Objects, FMX.Types,

  System.Generics.Collections,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Controls, FMX.Forms,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.PlatForm,FMX.Effects,
  RegularExpressions, FMX.SearchBox,
  FMX.Dialogs,FMX.ListBox;

type
   TRectangleHelper = class helper for TRectangle
   procedure ChartTimeline(Valores : String;Tipo :Integer = 1; Cor :TAlphaColor = TAlphaColors.Skyblue); overload;
   procedure ChartBarHorizontal(Titulo, Rotulos, Valores: String); overload;
   procedure ChartBarVertical(Titulo,Valores : String); overload;
   procedure ChartBarVertical(Titulo,Valores : String; Cor :TAlphaColor); overload;
   procedure ChartBarHorizontal(Titulo,Valores : String); overload;
   procedure ChartBarHorizontal(Titulo,Valores : String; Cor :TAlphaColor); overload;
   procedure ChartCircular(Titulo:String;Valor :Integer); overload;
   procedure ChartCircular(Titulo:String;Valor :Integer;Cor :TAlphaColor); overload;
   procedure ChartCalendario(Data :TDate; Valores :String;
      Color :TAlphaColor = TAlPhaColors.White;Estilo :Integer = 1 ); overload;
   procedure ChartCalendario(Data: TDate; Valores: TDataSet); overload;

   function Top(_size :Single) :TRectangle;
   function Left(_size :Single) :TRectangle;
   function Bottom(_size :Single) :TRectangle;
   function Right(_size :Single) :TRectangle;
   function MarginAll(_size :Single):TRectangle; overload;
   function PaddingAll(_size :Single):TRectangle; overload;
   function SizeH(H :Real) :TRectangle; overload;
   function SizeW(H :Real) :TRectangle; overload;
   function PositionXY(APositionX,APositionY :Single) :TRectangle;

   function TextCenter(aText: String; aFontSize:Single; aFontColor :TAlphaColor):TRectangle; overload;
   procedure LoadFromFile(const aFileName :string);
   procedure LoadFromURL(const aFileName :string);
   procedure Color(aColor :TAlphaColor);
   procedure Sombrear;
   constructor Create(AOwner :TComponent; AlignLayout : TAlignLayout;
       aColor :TAlphaColor) overload;
   constructor Create(AOwner :TComponent; AlignLayout : TAlignLayout;
       aHint : string = '' ) overload;
   constructor Create(AOwner :TComponent; aColor :TAlphaColor) overload;
   constructor Create(AOwner :TComponent; aText :AnsiString;
     aFontSize:Single; aFontColor,ABackgroundColor :TAlphaColor) overload;
end;

type
  TTipo = (vertical,horizontal,circular,calendario,timeline);

type
  TSerie = class
    Valor,
    Cor :Integer;
    Hint :String;
  end;

type
  TGrafico = class

  private
    FValores: TDictionary<String, TSerie>;
    FMax: Integer;
    FTipo: TTipo;
    FTitulo: String;
    FCor: TAlphaColor;
    FCorFundo: TAlphaColor;
    procedure SetValores(const Value: TDictionary<String, TSerie>);
    procedure SetMax(const Value: Integer);
    procedure SetTipo(const Value: TTipo);
    procedure SetTitulo(const Value: String);
    procedure SetCor(const Value: TAlphaColor);
    procedure SetCorFundo(const Value: TAlphaColor);

    procedure Serie(Comp :TVertScrollBox; Por1 :Integer;
      Texto :String); overload;
    procedure Serie(Comp :TVertScrollBox; Texto,Texto2 :String;Tipo :Integer = 1); overload;
    procedure Serie(Comp :THorzScrollBox ;Por1 :Integer;
      Texto :String); overload;

    procedure Serie(Comp :TCircle; Valor :Integer); overload;

  protected
    property Valores : TDictionary<String,TSerie> read FValores write SetValores;
    property Tipo :TTipo read FTipo write SetTipo;
  public
    property Max :Integer read FMax write SetMax;
    property Titulo :String read FTitulo write SetTitulo;
    property Cor :TAlphaColor read FCor write SetCor;
    property CorFundo :TAlphaColor read FCorFundo write SetCorFundo;
    constructor Create(Comp : TRectangle;Tipo :TTipo);
    destructor Destroy; override;
    procedure AddSerie(int1 : Integer ;Hint :string);

    procedure CardMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure CardDragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure CardDragDrop(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);

    procedure DiaClick(Sender :TObject);
//    procedure AddSerie()
  end;

implementation

uses
  System.IOUtils, FMX.Helpers.Text;

var
  Serie :TSerie;
  i :Integer;
  Vert : TVertScrollBox;
  horz : THorzScrollBox;
  circ  : TCircle;
  rFundo,
  rBar :  TRectangle;
  sTitulo : TText;
  Sombra: TShadowEffect;
  topo, mes   : TLayout;
  lista :TListBox;
  serc :TSearchBox;

{ TGrafico }

procedure TGrafico.AddSerie(int1 : Integer ;Hint :string);
begin

   if Tipo = vertical then begin
      Serie(Vert,int1,Hint);
   end else if Tipo = horizontal then begin
      Serie(Horz,int1,Hint);
   end else if Tipo = circular then begin

   end;
   inc(i)

end;

procedure TGrafico.CardDragDrop(Sender: TObject; const Data: TDragObject;
  const Point: TPointF);
begin
   if Sender is TVertScrollBox then begin
      TControl(Data.Source).Position.Y:= Point.Y;
      TControl(Sender).AddObject(TControl(Data.Source));
   end;
end;

procedure TGrafico.CardDragOver(Sender: TObject; const Data: TDragObject;
  const Point: TPointF; var Operation: TDragOperation);
begin
   Operation := TDragOperation.Copy;


end;

procedure TGrafico.CardMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var Svc: IFMXDragDropService;
    DragData: TDragObject;
    DragImage: TBitmap;
begin
   if TPlatformServices.Current.SupportsPlatformService(IFMXDragDropService, Svc) then begin
      DragImage       := TControl(Sender).MakeScreenshot;
      DragData.Source := Sender;
      DragData.Data   := DragImage;
      try
        Svc.BeginDragDrop(Application.MainForm, DragData, DragImage);
      finally
         DragImage.Free;
      end;
   end;

end;

constructor TGrafico.Create(Comp : TRectangle;Tipo :TTipo);
var Line1: TLine;

begin

   for I := Comp.ComponentCount - 1 downto 0 do
      Comp.Components[I].Free;

   Cor      := TAlphaColors.Cornflowerblue;
   CorFundo := Comp.Fill.Color;
   Max      := 0;

   Sombra := TShadowEffect.Create(Comp);
   Sombra.Distance := 1;
   Sombra.Direction := 45;
   Sombra.Softness := 0.3;
   Sombra.Opacity := 0.1;
   Sombra.ShadowColor := TAlphaColors.Black;
   Sombra.Parent :=  Comp;

   topo := TLayout.Create(Comp);
   topo.Align := TAlignLayout.Top;
   topo.Size.Height := 33;
   topo.Size.PlatformDefault := False;
   topo.Parent := Comp;

   i := 0;
   Self.Tipo := Tipo;
   if Tipo = vertical then begin
      Vert                := TVertScrollBox.Create(topo);
      Vert.Parent         := Comp;
      Vert.Align          := TAlignLayout.Client;
      vert.Height         := Comp.Height - 60 ;
      vert.Width          := Comp.Width ;
      Vert.Margins.Top    := 5;
      Vert.Margins.Left   := 15;
      Vert.Margins.Right  := 15;
      Vert.Margins.Bottom := 5;
      Vert.OnDragOver     := CardDragOver;
      Vert.OnDragDrop     := CardDragDrop;
   end else if Tipo = horizontal then begin
      Line1               := TLine.Create(Comp);
      Line1.LineType      := TLineType.Top;
      Line1.Position.X    := 368;
      Line1.Position.Y    := 352;
      Line1.Size.Width    := 146;
      Line1.Size.Height   := 30;
      Line1.Size.PlatformDefault := False;
      Line1.Align         := TAlignLayout.Bottom;
      Line1.Parent        := Comp;

      horz := THorzScrollBox.Create(topo);
      horz.Parent         := Comp;
      horz.Align          := TAlignLayout.Client;
      horz.Margins.Top    := 5;
      horz.Margins.Left   := 5;
      horz.Margins.Right  := 5;
      horz.Margins.Bottom := 0;

   end else if Tipo = circular then begin
      circ := TCircle.Create(Comp);
      circ.Parent := Comp;
      circ.Stroke.Color := Comp.Fill.Color;
      circ.Align := TAlignLayout.Center;
      circ.Size.Width := 90;
      circ.Size.Height := 90;
      circ.Size.PlatformDefault := False
   end else if Tipo = calendario then begin
      mes := TLayout.Create(Comp);
      mes.Align := TAlignLayout.Client;
      mes.Size.PlatformDefault := False;
      mes.Margins.Top    := 5;
      mes.Margins.Left   := 5;
      mes.Margins.Right  := 5;
      mes.Margins.Bottom := 5;
      mes.Parent         := Comp;

      Line1               := TLine.Create(topo);
      Line1.LineType      := TLineType.Bottom;
      Line1.Size.Height   := 1;
      Line1.Margins.Left  := 5;
      Line1.Margins.Right := 5;
      Line1.Size.PlatformDefault := False;
      Line1.Align         := TAlignLayout.Bottom;
      Line1.Parent        := topo;
      Line1.Stroke.Color  := Cor;

   end else if Tipo = timeline then begin
      Vert                := TVertScrollBox.Create(topo);
      Vert.Parent         := Comp;
      Vert.Align          := TAlignLayout.Client;
      vert.Height         := Comp.Height - 60 ;
      vert.Width          := Comp.Width ;
      Vert.Margins.Top    := 5;
      Vert.Margins.Left   := 15;
      Vert.Margins.Right  := 15;
      Vert.Margins.Bottom := 5;
      Vert.OnDragOver     := CardDragOver;
      Vert.OnDragDrop     := CardDragDrop;
   end;

end;

destructor TGrafico.Destroy;
begin
  inherited;

  Valores.Free;

end;

procedure TGrafico.DiaClick(Sender: TObject);
begin
   serc.Text := (TText(Sender).Text);
end;

procedure TGrafico.Serie(Comp: TVertScrollBox; Por1 :Integer;
  Texto :String);
begin
   rFundo := TRectangle.Create(Comp);
   rFundo.Parent        := Comp;
   rFundo.Align         := TAlignLayout.Top;
   rFundo.Fill.Color    := CorFundo ;
   rFundo.Margins.Top   := 2;
   rFundo.Width         := Comp.Width;
   rFundo.Position.X    := 5;
   rFundo.Position.Y    := 170;
   rFundo.ClipChildren  := True;

   rFundo.Height        := Comp.Height  / Max -5 ;
   rFundo.Size.PlatformDefault := False;
   rFundo.Stroke.Kind   := TBrushKind.None;
   rFundo.OnDragOver    := CardDragOver;
   rFundo.OnDragDrop    := CardDragDrop;
   rFundo.OnMouseDown   := CardMouseDown;

   rBar := TRectangle.Create(rFundo);

   rBar.Align                := TAlignLayout.Left;
   rBar.Fill.Color           := Cor ;
   rBar.HitTest              := False;
   rBar.Size.Width           :=  0;
   rBar.Size.PlatformDefault := False;
   rFundo.AddObject(rBar);
   rBar.Stroke.Kind          := TBrushKind.None;
   rBar.ClipChildren         := True;

   sTitulo := TText.Create(rFundo);
   sTitulo.Parent := rFundo;
   sTitulo.Align  := TAlignLayout.Contents;
   sTitulo.Position.X := 0;
   sTitulo.Position.Y := 0;
   sTitulo.TextSettings.HorzAlign := TTextAlign.Leading;
   sTitulo.Width      := rFundo.Width;
   sTitulo.HitTest    := False;
   sTitulo.Text := Texto;

   rBar.AnimateFloat('Width',(rFundo.Width / 100) * Por1,1, TAnimationType.In,TInterpolationType.Cubic);


end;


procedure TGrafico.Serie(Comp: THorzScrollBox; Por1: Integer; Texto: String);
begin

   rFundo := TRectangle.Create(Comp);
   rFundo.Parent        := Comp;
   rFundo.Align         := TAlignLayout.Left;
   rFundo.Margins.Left  := 5;
   rFundo.Margins.Top   := 10;
   rFundo.Margins.Right := 5;
   rFundo.Height        := Comp.Height;
   rFundo.Width         := Comp.Width  / Max -10 ;
   rFundo.Position.X    := 0;
   rFundo.Position.Y    := 170;
   rFundo.Size.PlatformDefault := False;
   rFundo.Stroke.Kind   := TBrushKind.None;
   rFundo.ClipChildren  := True;

   rBar := TRectangle.Create(rFundo);
   rBar.Align      := TAlignLayout.Bottom;
   rBar.Fill.Color := TAlphaColors.Cornflowerblue;
   rBar.Name  := 'Ret_'+Inttostr(i);
   rBar.Size.Height           :=  0;
   rBar.Size.PlatformDefault := False;
   rBar.ClipChildren := True;
   rBar.Parent       := rFundo;
   rBar.Stroke.Kind  := TBrushKind.None;
   rBar.Hint         := Texto;
   rBar.ShowHint     := True;

   rBar.AnimateFloat('Height',(rFundo.Height  / 100) * Por1,1, TAnimationType.In,TInterpolationType.Cubic);

end;

procedure TGrafico.Serie(Comp: TCircle; Valor: Integer);
var
  Pie :TPie;
  Cir :TCircle;
begin

  Pie              := TPie.Create(Comp);
  Pie.Parent       := Comp;
  Pie.Align        := TAlignLayout.Client;
  Pie.Fill.Color   := Cor;
  Pie.Stroke.Color := CorFundo;
  Pie.Size.Width           := 90;
  Pie.Size.Height          := 90;
  Pie.Size.PlatformDefault := False;
  Pie.StartAngle := 0;
  Pie.RotationAngle := -90;
  Pie.EndAngle := 0;

  Cir := TCircle.Create(Pie);
  Cir.Parent      := Pie;
  Cir.Fill.Color := Comp.Stroke.Color;;
  Cir.Stroke.Kind := TBrushKind.None;
  Cir.Align       := TAlignLayout.Center;
  Cir.Size.Width  := 50;
  Cir.Size.Height := 50;
  Cir.Size.PlatformDefault := False;

  sTitulo := TText.Create(Cir);
  sTitulo.Parent        := Cir;
  sTitulo.Align         := TAlignLayout.Client;
  sTitulo.Position.X    := 0;
  sTitulo.Position.Y    := 0;
  sTitulo.RotationAngle := 90;
  sTitulo.TextSettings.HorzAlign := TTextAlign.Center;
  sTitulo.Width         := Cir.Width;
  sTitulo.HitTest       := False;
  sTitulo.Text := Inttostr(Valor)+'%';

  Pie.AnimateFloat('StartAngle',Valor*3.6,1, TAnimationType.In,TInterpolationType.Cubic);


end;

procedure TGrafico.Serie(Comp: TVertScrollBox; Texto,Texto2: String;Tipo :Integer = 1);
var
   Layout : TLayout;
   Circle: TCircle;
   CalloutRectangle: TCalloutRectangle;
   Label2,Label1 : TLabel;
   Rectangle  : TRectangle;
   Shaddow    :TShadowEffect;
begin
   Layout:= TLayout.Create(Comp);
   Layout.Parent  := Vert;
   Layout.Align   := TAlignLayout.Top;
   Layout.Height  := 73;
   Layout.Width   := Comp.Width;
   Layout.Padding.Right := 10;

   Layout.Position.Y := 2000;

   Circle:= TCircle.Create(Layout);
   Circle.Parent := Layout;

   CalloutRectangle:= TCalloutRectangle.Create(Layout);
   CalloutRectangle.Parent := Layout;
   CalloutRectangle.Align := TAlignLayout.None;
   CalloutRectangle.Fill.Color := TAlphaColors.White;
   CalloutRectangle.Anchors := [TAnchorKind.akLeft,TAnchorKind.akBottom,TAnchorKind.akTop,TAnchorKind.akTop];
   CalloutRectangle.Margins.Top := 2;
   CalloutRectangle.Margins.Right := 2;
   CalloutRectangle.Margins.Bottom := 2;
   CalloutRectangle.Position.X := 46;
   CalloutRectangle.Position.Y := 2;
   CalloutRectangle.Size.Width := Layout.Width - 50;
   CalloutRectangle.Size.Height := Layout.Height - 6;
   CalloutRectangle.Stroke.Kind := TBrushKind.None;
   CalloutRectangle.CalloutWidth := 10;
   CalloutRectangle.CalloutLength := 10;
   CalloutRectangle.CalloutPosition := TCalloutPosition.Left;

   Label2 := TLabel.Create(Layout);
   Label2.Align := TAlignLayout.Center;
   Label2.TextSettings.VertAlign := TTextAlign.Center;
   Label2.TextSettings.HorzAlign := TTextAlign.Center;
   Label2.Size.Width := 34;
   Label2.Size.Height := 17;
   Label2.Text := '';
   Label2.Text := Texto;
   Label2.TabOrder := 0;
   Label2.Parent := Circle;

   if Tipo = 1 then begin
      Circle.Fill.Color := Cor;
      Circle.Position.X := 17;
      Circle.Position.Y := 8;
      Circle.Size.Width := 16;
      Circle.Size.Height := 17;
      Circle.Stroke.Kind :=TBrushKind.None;
      CalloutRectangle.CalloutOffset := 10;
      Label2.Visible := False;
   end else begin
      Circle.Fill.Color := TAlphaColors.White;
      Circle.Position.X := 4;
      Circle.Position.Y := 12;
      Circle.Size.Width := 40;
      Circle.Size.Height := 40;
      Circle.Stroke.Color :=Cor;
      Circle.Stroke.Thickness := 3;
      CalloutRectangle.CalloutOffset := 0;
   end;

   Label1 := TLabel.Create(Layout);
   Label1.Align := TAlignLayout.Client;
   Label1.Margins.Left := 15;
   Label1.Margins.Top := 5;
   Label1.Margins.Bottom := 5;
   Label1.TextSettings.VertAlign := TTextAlign.Leading;
   Label1.TabOrder := 0;
   Label1.Text := Texto2;
   Label1.Parent := CalloutRectangle;

   Rectangle := TRectangle.Create(Layout);
   Rectangle.Parent := Layout;
   Rectangle.SendToBack;
   Rectangle.Fill.Color := Cor;
   Rectangle.Position.X := 24;
   Rectangle.Position.Y := 0;
   Rectangle.Size.Width := 3;
   Rectangle.Size.Height := Layout.Height;
   Rectangle.Stroke.Kind := TBrushKind.None;

   Shaddow :=TShadowEffect.Create(Layout);
   Shaddow.Distance := 1;
   Shaddow.Direction := 45;
   Shaddow.Softness := 0.3;
   Shaddow.Opacity := 0.1;
   Shaddow.ShadowColor := TAlphaColors.Black;
   Shaddow.Parent := CalloutRectangle;

end;

procedure TGrafico.SetCor(const Value: TAlphaColor);
begin
  FCor := Value;
end;

procedure TGrafico.SetCorFundo(const Value: TAlphaColor);
begin
  FCorFundo := Value;
end;

procedure TGrafico.SetMax(const Value: Integer);
begin
  FMax := Value;
end;

procedure TGrafico.SetTipo(const Value: TTipo);
begin
  FTipo := Value;
end;

procedure TGrafico.SetTitulo(const Value: String);
begin
   FTitulo := Value;

   sTitulo := TText.Create(Topo);
   sTitulo.Align  := TAlignLayout.Client;
   sTitulo.Parent := Topo;
   sTitulo.Text   := Titulo;

end;

procedure TGrafico.SetValores(const Value: TDictionary<String, TSerie>);
begin
  FValores := Value;
end;

{ TRectangleHelper }

procedure TRectangleHelper.ChartBarHorizontal(Titulo, Rotulos, Valores: String);
var
  g : TGrafico;
  i : Integer;
  arr_rotulos,arr_series,arr_valor :TArray<String>;
  Max :Integer;
  tit :string;
begin
   for I := Self.ComponentCount - 1 downto 0 do
      Self.Components[I].Free;

   Max :=  TRegEx.Matches(Rotulos,'}').Count;

   if Max > 1 then begin
      arr_rotulos := TRegEx.Split(Rotulos,'}');
      for I := 0 to TRegEx.Matches(Rotulos,'}').Count-1 do begin
         rFundo := TRectangle.Create(Self);
         rFundo.Parent        := Self;
         rFundo.Fill.Color    := Self.Fill.Color;
         rFundo.Stroke.Color    := Self.Fill.Color;
         rFundo.Align         := TAlignLayout.Left;
         rFundo.Margins.Left  := 5;
         rFundo.Margins.Top   := 10;
         rFundo.Margins.Right := 5;
         rFundo.Height        := Self.Height;

         rFundo.Width        := Self.Width  / Max - 10  ;
         rFundo.Size.PlatformDefault := False;

         arr_valor := TRegEx.Split(arr_rotulos[i],':');
         tit := arr_valor[0];

         rFundo.ChartBarHorizontal(tit.Replace('{','') ,arr_rotulos[i].
                                         Replace(Tit+':','').
                                         Replace(Tit+'}','')
                                         ,TAlphaColors.Red)

      end;

   end else begin
      arr_valor := TRegEx.Split(Rotulos,':');
      tit := arr_valor[0];
      Self.ChartBarHorizontal(titulo ,Rotulos.
                                     Replace(Tit+':','').
                                     Replace(Tit+'}','') ,TAlphaColors.Red)
   end;
end;

procedure TRectangleHelper.ChartBarVertical(Titulo, Valores :String);
var
   g : TGrafico;
   i : Integer;
   arr_series,arr_valor :TArray<String>;

begin
   g := TGrafico.Create(Self,Vertical);

   g.Titulo := Titulo;

   arr_series := TRegEx.Split(Valores,';');
   g.Max := TRegEx.Matches(Valores,';').Count +1;

   for I := 0 to TRegEx.Matches(Valores,';').Count do begin
       arr_valor := TRegEx.Split(arr_series[i],':');
       g.AddSerie(strtoint(arr_valor[0]),arr_valor[1]);
   end;

   g.Free;

end;

procedure TRectangleHelper.ChartCircular(Titulo: String;Valor :Integer);
var g : TGrafico;
begin

   g := TGrafico.Create(Self,circular);
   g.Titulo := Titulo;
   g.Serie(circ, Valor);
   g.Free;

end;

procedure TRectangleHelper.ChartBarHorizontal(Titulo, Valores: String);
var
   g : TGrafico;
   i : Integer;
   arr_series,arr_valor :TArray<String>;

begin
   g := TGrafico.Create(Self,horizontal);

   g.Titulo := Titulo;
   arr_series := TRegEx.Split(Valores,';');
   g.Max := TRegEx.Matches(Valores,';').Count +1;

   for I := 0 to TRegEx.Matches(Valores,';').Count do begin
       arr_valor := TRegEx.Split(arr_series[i],':');
       g.AddSerie(strtoint(arr_valor[0]),arr_valor[1]);
   end;

   g.Free;


end;

procedure TRectangleHelper.ChartBarHorizontal(Titulo, Valores: String;
  Cor: TAlphaColor);
var
   g : TGrafico;
   i : Integer;
   arr_series,arr_valor :TArray<String>;

begin
   g := TGrafico.Create(Self,horizontal);

   g.Titulo := Titulo;
   g.Cor := Cor;

   arr_series := TRegEx.Split(Valores,';');
   g.Max := TRegEx.Matches(Valores,';').Count +1;

   for I := 0 to TRegEx.Matches(Valores,';').Count do begin
       arr_valor := TRegEx.Split(arr_series[i],':');
       g.AddSerie(strtoint(arr_valor[0].Replace('}','').Replace('}','') ),arr_valor[1]);
   end;

   g.Free;

end;

procedure TRectangleHelper.ChartBarVertical(Titulo, Valores: String;
  Cor: TAlphaColor);
var
   g : TGrafico;
   i : Integer;
   arr_series,arr_valor :TArray<String>;

begin
   g := TGrafico.Create(Self,Vertical);

   g.Titulo := Titulo;
   g.Cor := Cor;

   arr_series := TRegEx.Split(Valores,';');
   g.Max := TRegEx.Matches(Valores,';').Count +1;

   for I := 0 to TRegEx.Matches(Valores,';').Count do begin
       arr_valor := TRegEx.Split(arr_series[i],':');
       g.AddSerie(strtoint(arr_valor[0]),arr_valor[1]);
   end;

   g.Free;

end;

procedure TRectangleHelper.ChartCalendario(Data: TDate; Valores: String;
  Color :TAlphaColor = TAlPhaColors.White;Estilo :Integer = 1);
var g : TGrafico;
    I,J,A,M :Integer;
    rDia  :TRectangle;
    tDia  :TText;
    Y :Single;
    tab :TFDMemTable;
    arr_dias, arr_eventos :TArray<String>;
    item :TListBoxItem;

begin

   Y := 0;
   g := TGrafico.Create(Self,calendario);
   g.Titulo := AnsiUpperCase(FormatDateTime('MMMM YYYY',Data));

   if Estilo > 1 then begin

      mes.Align := TAlignLayout.Top;
      mes.Height := (mes.Height / estilo) -1;

      lista := TListBox.Create(Mes.GetParentComponent );
      lista.Parent := Mes.Parent;
      lista.Align := TAlignLayout.Client;

      serc := TSearchBox.Create(lista);
      serc.Parent := lista;
      serc.Visible := False;

   end;


   A := strToint(FormatdateTime('yyyy',Data));
   M := strtoint(FormatdateTime('mm',Data));
   for I := 1 to (MonthDays[IsLeapYear(A),M]) do begin
      rDia := TRectangle.Create(Mes);
      rDia.Name := 'ret_dia_'+Inttostr(i);
      rDia.Parent     := mes;
      rDia.Width      := mes.Width / 7;
      rDia.Height     := mes.Height /6;
      rDia.Stroke.Color := rDia.Fill.Color;
      rDia.Position.X := (dayofweek(strtodate( Inttostr(i) + '/'+ Inttostr(M) +'/'+ inttoStr(A) ))-1) * rDia.Width;
      rDia.Position.Y := Y;

      if dayofweek(strtodate( Inttostr(i) + '/'+ Inttostr(M) +'/'+ inttoStr(A) )) = 7 then begin
         Y := Y + rDia.Height;
      end;

      tDia := TText.Create(Mes);
      tDia.Parent := rDia;
      tDia.Name := 'txt_dia_'+Inttostr(i);
      tDia.Align  := TAlignLayout.Client;
      tDia.Position.X := 0;
      tDia.Position.Y := 0;
      tDia.TextSettings.HorzAlign := TTextAlign.Center;
      tDia.TextSettings.VertAlign := TTextAlign.Center;
      tDia.TextSettings.Font.Family := 'Roboto';
      tDia.ShowHint := True;
      tDia.OnClick := g.DiaClick;
      tDia.Text := Inttostr(i);
   end;


   if Valores.Trim <> '' then begin
      arr_dias := TRegEx.Split(Valores,';');
      for I := 0 to TRegEx.Matches(Valores,';').Count do begin
         arr_eventos := TRegEx.Split(arr_dias[i],':');

         TRectangle(Mes.FindComponent('ret_dia_'+arr_eventos[0])).Fill.Color := Color;
         TText(Mes.FindComponent('txt_dia_'+arr_eventos[0])).Hint := arr_eventos[1];

         if lista <> nil then begin

            for J := 1 to TRegEx.Matches(arr_dias[i],':').Count do begin
               Item := TlistBoxItem.Create(lista);
               Item.StyleLookup := 'listboxitembottomdetail';
               Item.StyledSettings := [];
               Item.ItemData.Accessory := TListBoxItemData.TAccessory.aMore;
               Item.Size.Height := 40;
               Item.Size.PlatformDefault := False;
               item.Text :=  arr_eventos[0] +' - '+ arr_eventos[J];
               lista.AddObject( Item );
            end;
         end;
      end;
   end;

   g.Free;

end;

procedure TRectangleHelper.ChartCalendario(Data: TDate; Valores: TDataSet);
begin

end;

procedure TRectangleHelper.ChartCircular(Titulo: String; Valor: Integer;
  Cor: TAlphaColor);
var g : TGrafico;
begin
   g := TGrafico.Create(Self,circular);
   g.Titulo := Titulo;
   g.Cor := Cor;
   g.Serie(circ, Valor);

   g.Free;

end;

procedure TRectangleHelper.ChartTimeline(Valores: String;Tipo :Integer = 1;Cor :TAlphaColor = TAlphaColors.Skyblue);
var
   g : TGrafico;
   i : Integer;
   arr_series,arr_valor :TArray<String>;

begin
   if valores.trim <> '' then begin
      g := TGrafico.Create(Self,Vertical);
      g.Cor := Cor;
      arr_series := TRegEx.Split(Valores,';');
      g.Max := TRegEx.Matches(Valores,';').Count +1;

      for I := 0 to TRegEx.Matches(Valores,';').Count do begin
        arr_valor := TRegEx.Split(arr_series[i],':');
        g.Serie(Vert,arr_valor[0],arr_valor[1],Tipo);
      end;

      g.Free;
   end;

end;


constructor TRectangleHelper.Create(AOwner: TComponent;
  AlignLayout: TAlignLayout; aHint : string = '');
begin
   inherited Create(AOwner);
   Align := AlignLayout;
   Hint := aHint;
   TFMXObject(AOwner).AddObject(Self);
   Padding.Top := 5;
   Padding.Left := 5;
   Padding.Right := 5;
   Padding.Bottom := 5;
   Size.PlatformDefault := False;
   Fill.Color := TAlphaColorRec.White;
   Stroke.Color := TAlphaColorRec.White;
   HitTest := False;
end;

constructor TRectangleHelper.Create(AOwner: TComponent;
  AlignLayout: TAlignLayout; aColor: TAlphaColor);
begin
   inherited Create(AOwner);
   Align := AlignLayout;
   TFMXObject(AOwner).AddObject(Self);
   Padding.Top := 2;
   Padding.Left := 2;
   Padding.Right := 2;
   Padding.Bottom := 2;
   Size.PlatformDefault := False;
   Fill.Color := aColor;
   Stroke.Color :=aColor;
   Sombrear;
end;

constructor TRectangleHelper.Create(AOwner: TComponent; aColor: TAlphaColor);
begin
   inherited Create(AOwner);
   TFMXObject(AOwner).AddObject(Self);
   Size.PlatformDefault := False;
   Color(aColor);
   HitTest := False;
end;

function TRectangleHelper.Bottom(_size: Single): TRectangle;
begin
   Margins.Bottom := _size;
   Result := Self;
end;

procedure TRectangleHelper.Color(aColor: TAlphaColor);
begin
   Fill.Color := aColor;
   Stroke.Color := aColor;
end;

constructor TRectangleHelper.Create(AOwner :TComponent; aText :AnsiString;
     aFontSize:Single; aFontColor,ABackgroundColor :TAlphaColor) overload;
var T :TText;
begin
  inherited Create(AOwner);
  TFMXObject(AOwner).AddObject(Self);
  Fill.Color := ABackgroundColor;
  Stroke.Color := Fill.Color;
  T := TText.Create(Self);
  T.Text := aText;
  T.Align := TAlignLayout.Center;
  T.TextSettings.FontColor := aFontColor;
  T.TextSettings.Font.Size := aFontSize ;
  T.Width := 1000;
  T.AutoSize := True;
  //  R.AddObject(T);
  Height := T.Height + 10;
  Width := T.Width + 10;

  AddObject(T);

end;

function TRectangleHelper.Left(_size: Single): TRectangle;
begin
   Margins.Left := _size;
   Result := Self;
end;

procedure TRectangleHelper.LoadFromFile(const aFileName: string);
begin
   Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
   Self.Fill.Kind := TBrushKind.Bitmap;
   try
      Self.Fill.Bitmap.Bitmap.LoadFromFile(aFileName);
   except
       Self.Fill.Bitmap.Bitmap := nil;
   end;
end;

procedure TRectangleHelper.LoadFromURL(const aFileName: string);
var
   MyFile :TFileStream;
   NetHTTPClient : TNetHTTPClient;
begin

   Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
   Self.Fill.Kind := TBrushKind.Bitmap;

   TThread.CreateAnonymousThread(
   procedure()
   begin
      MyFile := TFileStream.Create(
                                 TPath.Combine(
                                 TPath.GetDocumentsPath,
                                 TPath.GetFileName(aFileName))
                                ,fmCreate);

      try
        NetHTTPClient := TNetHTTPClient.Create(nil);
        NetHTTPClient.Get(aFileName,MyFile);
      finally
        NetHTTPClient.DisposeOf;
      end;

      TThread.Synchronize(TThread.CurrentThread,
      procedure ()
      begin
         try
            Self.Fill.Bitmap.Bitmap.LoadFromStream(MyFile);
         except
            Self.Fill.Bitmap.Bitmap := nil;
         end;
         MyFile.DisposeOf;
      end);
   end).Start;

end;

function TRectangleHelper.MarginAll(_size: Single): TRectangle;
begin
   Right(_size).Top(_size).Left(_size).Right(_size);
   Result := Self;
end;

function TRectangleHelper.PaddingAll(_size: Single): TRectangle;
begin
   Padding.Rect := TRectF.Create(_size,_size,_size,_size);
   Result := Self;
end;

function TRectangleHelper.PositionXY(APositionX,
  APositionY: Single): TRectangle;
begin
   Position.X := APositionX;
   Position.Y := APositionY;
   Result := Self;
end;

function TRectangleHelper.Right(_size: Single): TRectangle;
begin
   Margins.Right := _size;
   Result := Self;
end;

function TRectangleHelper.SizeH(H: Real): TRectangle;
begin
   Self.Height := H;
end;

function TRectangleHelper.SizeW(H: Real): TRectangle;
begin
   Self.Width := H;
end;

procedure TRectangleHelper.Sombrear;
var Sombra: TShadowEffect;
begin
   Sombra := TShadowEffect.Create(Self);
   Self.Stroke.Thickness := 0;
   Self.AddObject(Sombra);
   Sombra.Distance := 2;
   Sombra.Direction := 45;
   Sombra.Softness := 0.1;
   Sombra.Opacity := 0.1;
   Sombra.ShadowColor := TAlphaColorRec.Black;
end;

function TRectangleHelper.TextCenter(aText: String; aFontSize:Single;
  aFontColor :TAlphaColor):TRectangle;
var T :TText;
begin

  T := TText.Create(Self);
  T.Text := aText;
  T.Align := TAlignLayout.Center;
  T.TextSettings.FontColor := aFontColor;
  T.TextSettings.Font.Size := aFontSize ;
  T.Width := 1000;
  T.AutoSize := True;
  Height := T.Height + 10;
  Width := T.Width + 10;

end;

function TRectangleHelper.Top(_size: Single): TRectangle;
begin
   Margins.Top := _size;
   Result := Self;
end;


end.
