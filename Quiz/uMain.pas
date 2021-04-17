unit uMain;

interface

uses
  System.JSON,System.Generics.Collections, FMX.Ani,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, FMX.Objects,
  FMX.TabControl, FMX.Layouts, FMX.Effects;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    TabControl1: TTabControl;
    GridPanelLayout1: TGridPanelLayout;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    ShadowEffect1: TShadowEffect;
    Text1: TText;
    Text2: TText;
    procedure RespostaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label2Click(Sender: TObject);
    procedure Text2Click(Sender: TObject);
    procedure Text1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Animacao :TFloatAnimation;
    Fundo :TRectangle;
    ListaText : TObjectList<TText>;
    procedure Quiz(AJSON :String);
    procedure AnimacaoFinish(Sender: TObject);
    procedure ContinuarClick(Sender: TObject);
    procedure Proximo;
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses Firebase.Realtime;

var RT : TRealtime;

procedure TForm2.AnimacaoFinish(Sender: TObject);
begin
   if TFloatAnimation(Sender).Tag = 0 then begin
      TFloatAnimation(Sender).Tag := 2;
      TFloatAnimation(Sender).StopValue := Self.Height + 100;
   end else if TFloatAnimation(Sender).Tag = 1 then begin
      TFloatAnimation(Sender).Tag := 3;
      TFloatAnimation(Sender).Duration := 1.5;
      TFloatAnimation(Sender).Delay := 1;
      TFloatAnimation(Sender).StopValue := Self.Height + 150;
      TFloatAnimation(Sender).Start;
   end  else Fundo.DisposeOf;
end;

procedure TForm2.ContinuarClick(Sender: TObject);
begin
   Animacao.Start;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   ListaText.DisposeOf;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
   Rectangle2.Visible := false;
   Rectangle3.Visible := false;
   Label1.Visible := false;
   Label2.Visible := false;

   RT := TRealtime.Create('democursofirebase-default-rtdb','5UybNyF0LT2fx3mLQQsQypBF7AoM5vnH2q89WFsK');

   Quiz( RT.Collection('Quiz').Open );
//   Quiz(Memo1.Text);

end;

procedure TForm2.Label2Click(Sender: TObject);
begin
   TabControl1.Previous;
end;

procedure TForm2.Proximo;
var
   I,J,A : Integer;
   Respondeu : Boolean;
   Texto :TText;

   FundoBotao,
   Resultado : TRectangle;
begin
   Respondeu := false;

   for I := 0 to ListaText.Count -1 do begin
      if ListaText.Items[I].StyleName = IntToStr(TTabItem(TabControl1.ActiveTab).Index) then begin
         if (ListaText.Items[I].TextSettings.Font.Style <> []) then begin
             Respondeu := True;
         end;
      end;
   end;

   if not Respondeu then begin

      Fundo := TRectangle.Create(Self);
      Fundo.Align := TAlignLayout.Contents;
      Fundo.Fill.Color := TAlphaColorRec.Null;
      Fundo.Stroke.Color := TAlphaColorRec.Null;
      Fundo.Opacity := 0.7;
      Self.AddObject(Fundo);

      Resultado := TRectangle.Create(Self);
     // Resultado.Align := TAlignLayout.Bottom;
      Resultado.Height :=  120;
      Resultado.Position.Y := Self.Height + Resultado.Height;
      Resultado.Width := Self.Width;
      Resultado.Position.X := 0;
      Resultado.Fill.Color := TAlphaColorRec.Black;
      Resultado.Stroke.Color := TAlphaColorRec.Black;
      Self.AddObject(Resultado);

      Texto := TText.Create(Resultado);
      Texto.Text := 'Escolha uma resposta';
      Texto.Align := TAlignLayout.client;
      Texto.TextSettings.Font.Size := 16;
      Texto.TextSettings.FontColor := TAlphaColorRec.Darkgrey;
      Texto.TextSettings.HorzAlign := TTextAlign.Center;
      Resultado.AddObject(Texto);

      Animacao := TFloatAnimation.Create(Resultado);
      Resultado.AddObject(Animacao);
      Animacao.Tag := 1;
      Animacao.Duration := 0.5;
      Animacao.StopValue := (Self.Height - 160) ;
      Animacao.StartFromCurrent := True;
      Animacao.PropertyName := 'Position.Y';
      Animacao.OnFinish := AnimacaoFinish;
      Animacao.Interpolation := TInterpolationType.Linear;
      Animacao.Start;

      abort;

   end;

   if TTabItem(TabControl1.ActiveTab).Index = TabControl1.TabCount-1 then begin
      Rectangle2.Visible := True;
      A := 0;
      for J := 0 to TabControl1.TabCount-1  do begin

         for I := 0 to ListaText.Count -1 do begin
            if ListaText.Items[I].StyleName = IntToStr(J) then begin

               if (ListaText.Items[I].Tag = 1) and (ListaText.Items[I].TextSettings.Font.Style <> []) then begin
                  ListaText.Items[I].TextSettings.FontColor := TAlphaColorRec.Cornflowerblue;
                  A := A + 1;

               end else  if (ListaText.Items[I].Tag = 1) and (ListaText.Items[I].TextSettings.Font.Style = []) then
                  ListaText.Items[I].TextSettings.FontColor := TAlphaColorRec.Cornflowerblue
              else if (ListaText.Items[I].Tag = 0) and (ListaText.Items[I].TextSettings.Font.Style <> []) then
                  ListaText.Items[I].TextSettings.FontColor := TAlphaColorRec.Darkred
            end;
         end;
      end;

      Fundo := TRectangle.Create(Self);
      Fundo.Align := TAlignLayout.Contents;
      Fundo.Fill.Color := TAlphaColorRec.white;
      Fundo.Stroke.Color := TAlphaColorRec.white;
      Fundo.Opacity := 0.7;
      Self.AddObject(Fundo);

      Resultado := TRectangle.Create(Self);
      Resultado.YRadius := 5;
      Resultado.XRadius := 5;
      Resultado.Position.Y := Self.Height + 10;
      Resultado.Width := Self.Width - 70;
      Resultado.Position.X := 35;
      Resultado.Height := Resultado.Width/2;
      Resultado.Fill.Color := TAlphaColorRec.Black;
      Resultado.Stroke.Color := TAlphaColorRec.Black;
      Self.AddObject(Resultado);

      Texto := TText.Create(Resultado);
      Texto.Text := 'Você acertou '+Inttostr(A)+' de ' +Inttostr(TabControl1.TabCount);
      Texto.Align := TAlignLayout.Client;
      Texto.Margins.Left := 10;
      Texto.Margins.Right := 10;
      Texto.Margins.Top := 5;
      Texto.Margins.Bottom  := 5;
      Texto.Position.Y := 500;
      Texto.TextSettings.Font.Size := 20;
      Texto.TextSettings.FontColor := TAlphaColorRec.Darkgrey;
      Texto.TextSettings.HorzAlign := TTextAlign.Center;
      Texto.TextSettings.VertAlign := TTextAlign.Center;
      Resultado.AddObject(Texto);

      FundoBotao := TRectangle.Create(Resultado);
      FundoBotao.Align := TAlignLayout.Bottom;
      FundoBotao.Margins.Bottom := 5;
      FundoBotao.Height := 40;
      FundoBotao.YRadius := 5;
      FundoBotao.XRadius := 5;
      FundoBotao.Margins.Left := FundoBotao.Margins.Bottom;
      FundoBotao.Margins.Right := FundoBotao.Margins.Bottom;
      FundoBotao.Fill.Color := TAlphaColorRec.Cornflowerblue;
      FundoBotao.Stroke.Color := TAlphaColorRec.Cornflowerblue;
      Resultado.AddObject(FundoBotao);

      Texto := TText.Create(FundoBotao);
      Texto.Text := 'VER RESPOSTAS';
      Texto.Align := TAlignLayout.Client;
      Texto.OnClick := ContinuarClick;
      Texto.TextSettings.FontColor := TAlphaColorRec.White;
      FundoBotao.AddObject(Texto);

      Animacao := TFloatAnimation.Create(Resultado);
      Resultado.AddObject(Animacao);
      Animacao.Duration := 0.3;
      Animacao.StopValue := (Self.Height - Resultado.Height)/2 ;
      Animacao.StartFromCurrent := True;
      Animacao.PropertyName := 'Position.Y';
      Animacao.OnFinish := AnimacaoFinish;
      Animacao.Interpolation := TInterpolationType.Linear;
      Animacao.Start;
   end;

   TabControl1.Next;

end;

procedure TForm2.Quiz(AJSON: String);
var
   JSON,JSON2,JSON3,JSON4,JSON5  : TJSONObject;
   I, J, K, L : Integer;
   TabPerguntas :TTabItem;
   Questao : TText;
   FundoVert :TRectangle;
   Check : TRadioButton;
   Vert :TVertScrollBox;
   Respostas :TText;
begin

   ListaText := TObjectList<TText>.Create;

   Rectangle2.Visible := False;
   Rectangle3.Visible := True;
   Label1.Visible := True;
   Label2.Visible := True;

   JSON := TJSONObject.ParseJSONValue(AJSON) as TJSONObject;

   for I := 0 to JSON.Count -1 do begin
      Label1.Text := (JSON.Pairs[i].JsonString.Value);

      JSON2 := TJSONObject.ParseJSONValue(JSON.Pairs[i].JsonValue.ToString) as TJSONObject;

      for J := 0 to JSON2.Count -1 do begin
         Label2.Text := (JSON2.Pairs[J].JsonString.Value);

         JSON3 := TJSONObject.ParseJSONValue(JSON2.Pairs[i].JsonValue.ToString) as TJSONObject;

         for K := 0 to JSON3.Count -1 do begin

            TabPerguntas := TTabItem.Create(TabControl1);
            TabPerguntas.Text :=  JSON3.Pairs[K].JsonString.Value;
            TabPerguntas.Name :=  'tab_'+JSON3.Pairs[K].JsonString.Value+ IntToStr(K);
            TabControl1.AddObject(TabPerguntas);

            FundoVert := TRectangle.Create(Self);
            FundoVert.Align := TAlignLayout.Client;
            FundoVert.Fill.Color := Rectangle1.Fill.Color;
            FundoVert.Stroke.Color := Rectangle1.Fill.Color;

            TabPerguntas.AddObject(FundoVert);

            Vert := TVertScrollBox.Create(FundoVert);
            Vert.Align := TAlignLayout.Client;
            FundoVert.AddObject(Vert);

            JSON4 := TJSONObject.ParseJSONValue(JSON3.Pairs[k].JsonValue.ToString) as TJSONObject;

            Questao := TText.Create(Vert);
            Questao.Text := InttoStr(K+1)+') '+ JSON4.GetValue('questao').Value;
            Questao.Align := TAlignLayout.Top;
            Questao.Margins.Top := 20;
            Questao.Margins.Left := 25;
            Questao.Margins.Right := 25;
            Questao.Margins.Bottom := 10;
            Questao.TextSettings.Font.Size := 24;
            Questao.TextSettings.HorzAlign := TTextAlign.Leading;
            Questao.AutoSize := true;

            Vert.AddObject(Questao);

            JSON5 :=  TJSONObject.ParseJSONValue(JSON4.GetValue('opcoes').ToString) as TJSONObject;

            for L := 0 to JSON5.Count - 1 do begin

               Respostas := TText.Create(Vert);
               Respostas.StyleName := IntToStr(K);
               Respostas.Text := ' '+JSON5.Pairs[L].JsonString.Value +') '+JSON5.Pairs[L].JsonValue.Value;
               Respostas.Align := TAlignLayout.Top;
               Respostas.AutoSize := True;
               Respostas.Margins.Left := 35;
               Respostas.Margins.Right := 35;
               Respostas.Margins.Top := 10;
               Respostas.Margins.Bottom  := 5;
               Respostas.Position.Y := 500;
               Respostas.TextSettings.Font.Size := 16;
               Respostas.OnClick := RespostaClick;
               Respostas.TextSettings.FontColor := TAlphaColorRec.Darkgrey;
               Respostas.TextSettings.HorzAlign := TTextAlign.Leading;
               ListaText.Add(Respostas);
               Vert.AddObject(Respostas);

               if JSON4.GetValue('correta') <> nil then begin
                  if JSON5.Pairs[L].JsonString.Value <> JSON4.GetValue('correta').Value then
                     Respostas.Tag := 0
                  else
                     Respostas.Tag := 1;
               end;
            end;
         end;
      end;
   end;

   JSON.Free;
   JSON2.Free;
   JSON3.Free;
   JSON4.Free;
   JSON5.Free;

end;

procedure TForm2.RespostaClick(Sender: TObject);
var
   I : Integer;
begin

   for I := 0 to ListaText.Count -1 do begin
      if ListaText.Items[I].StyleName = TText(Sender).StyleName then begin
         ListaText.Items[I].TextSettings.FontColor := TAlphaColorRec.Darkgrey;
         ListaText.Items[I].TextSettings.Font.Style := [];
      end;
   end;

   TText(Sender).TextSettings.FontColor := TAlphaColorRec.Black;
   TText(Sender).TextSettings.Font.Style := [TFontStyle.fsBold];

end;

procedure TForm2.Text1Click(Sender: TObject);
begin
   TabControl1.Previous;
end;

procedure TForm2.Text2Click(Sender: TObject);
begin
   Proximo;
end;

end.
