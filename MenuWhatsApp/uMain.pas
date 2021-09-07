unit uMain;

interface

uses
  System.Generics.Collections, System.StrUtils,  FMX.MultiResBitmap,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FMX.ScrollBox, FMX.Memo, System.ImageList, FMX.ImgList;

type
   TImageHelper = class helper for TImage
     procedure ImageByName(Name :String; ImageList:TImageList);
   end;


type
  TForm1 = class(TForm)
    VertScrollBox1: TVertScrollBox;
    Button1: TButton;
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDQuery1: TFDQuery;
    Memo1: TMemo;
    Rectangle1: TRectangle;
    Memo2: TMemo;
    Button3: TButton;
    Button4: TButton;
    ImageList1: TImageList;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Rectangle2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure Rectangle2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ListaFundo :TObjectList<TRectangle>;
    ListaMensagem :TObjectList<TText>;
    ListaIcone: TObjectList<TImage>;
    procedure DesenhaLayout;
    procedure DesenharLayout(M: Boolean = False);
    procedure OrganizaLayout;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin

   FDQuery1.Open(' SELECT * FROM ( '+
                 ' SELECT ID, ID_Contato,  Max(HoraEnvio) Hora, Mensagem  FROM mensagens GROUP BY ID_Contato ) Mensagem '+
                 ' INNER JOIN contatos ON contatos.ID = mensagem.ID_Contato '+
                 ' ORDER BY Hora DESC ');


   DesenhaLayout;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   OrganizaLayout;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   FDConnection1.ExecSQL(Memo1.Lines.Text);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
   FDConnection1.ExecSQL(Memo2.Lines.Text);
   FDConnection1.Commit;
   OrganizaLayout;
end;

procedure TForm1.DesenhaLayout;
begin

   ListaFundo.Clear;
   FDQuery1.First;
   VertScrollBox1.BeginUpdate;

   while not FDQuery1.eof do begin
      DesenharLayout;

      FDQuery1.Next;
   end;

   VertScrollBox1.EndUpdate;

end;

procedure TForm1.DesenharLayout(M: Boolean = False);
var
   ImagePopup :TImage;
   Fundo :TRectangle;

   Layout :TLayout;
   Sigla,
   Usuario :TText;
   Hora : TText;
   Imagem,
   FundoMsgs :TCircle;
   QuantMsgs :TText;
   Mensagem  :TText;
   Linha :TLine;


begin
   Fundo := TRectangle.Create(VertScrollBox1);
   Fundo.Fill.Color   := TAlphaColorRec.White;
   Fundo.Width        := VertScrollBox1.Width;
   Fundo.Name         := 'Card_'+FDQuery1.FieldByName('ID_Contato').AsString;
   Fundo.Tag          := FDQuery1.FieldByName('ID_Contato').AsInteger;
   Fundo.Position.X   := 0;
   Fundo.Position.Y   := Fundo.Height * (FDQuery1.RecNo-1) ;
   Fundo.Stroke.Color := TAlphaColorRec.White;
   Fundo.OnMouseMove  := Rectangle2MouseMove;
   Fundo.HitTest      := True;
   Fundo.OnClick      := Rectangle2Click;
   VertScrollBox1.AddObject(Fundo);

   Linha := TLine.Create(Fundo);
   Linha.LineType := TLineType.Bottom;
   Linha.Align := TAlignLayout.Bottom;
   Linha.Height := 1;
   Linha.Stroke.Color := TAlphaColorRec.Darkgrey;
   Fundo.AddObject(Linha);

   Imagem := TCircle.Create(Fundo);
   Imagem.Align := TAlignLayout.Left;
   Imagem.Margins.Top := 5;
   Imagem.Margins.Left := 5;
   Imagem.Margins.Right := 5;
   Imagem.Margins.Bottom := 5;
   //Imagem.Fill.Color := TAlphaColorRec.Red;
   Imagem.Stroke.Thickness := 0;
   Fundo.AddObject(Imagem);

   Sigla := TText.Create(Layout);
   Sigla.Text := AnsiUpperCase(LeftStr(FDQuery1.FieldByName('Nome').AsString,2));
   Sigla.Align := TAlignLayout.Center;
   //Sigla.TextSettings.Font.Family := 'Calibri';
   Sigla.TextSettings.Font.Size := 14;
   Sigla.TextSettings.HorzAlign := TTextAlign.Center;
   Sigla.TextSettings.VertAlign := TTextAlign.Center;
   Sigla.HitTest := False;
   Sigla.AutoSize := True;
   Imagem.AddObject(Sigla);

   Layout := TLayout.Create(Fundo);
   Layout.Align := TAlignLayout.Client;
   Layout.Padding.Top := 7;
   Layout.HitTest :=FAlse;
   Fundo.AddObject(Layout);

   Usuario := TText.Create(Layout);
   Usuario.Text := FDQuery1.FieldByName('Nome').AsString;
   Usuario.Align := TAlignLayout.Top;
   Usuario.Height := 20;
   Usuario.TextSettings.Font.Family := 'Calibri';
   Usuario.Align := TAlignLayout.Top;
   Usuario.TextSettings.HorzAlign := TTextAlign.Leading;
   Usuario.HitTest := False;
   Layout.AddObject(Usuario);

   Hora := TText.Create(Fundo);
   Hora.Text := LeftStr(FDQuery1.FieldByName('Hora').AsString,5);
   Hora.hint := FDQuery1.FieldByName('Hora').AsString;
   Hora.Align := TAlignLayout.Client;
   Hora.TextSettings.Font.Family := 'Calibri';
   Hora.Margins.Right := 10;
   Hora.HitTest := False;
   Hora.TextSettings.FontColor := TAlphaColorRec.Darkgrey;
   Hora.TextSettings.HorzAlign := TTextAlign.Trailing;
   Hora.Name :=  'Hor_'+FDQuery1.FieldByName('ID_Contato').AsString;
   Usuario.AddObject(Hora);

   Mensagem := TText.Create(Fundo);
   Mensagem.Text := FDQuery1.FieldByName('Mensagem').AsString;
   Mensagem.Name :=  'Msg_'+FDQuery1.FieldByName('ID_Contato').AsString;
   Mensagem.TextSettings.FontColor := TAlphaColorRec.Darkgrey;
   Mensagem.Position.Y := Fundo.Height;
   Mensagem.Align := TAlignLayout.Top;
   Mensagem.HitTest := False;
   Mensagem.Height := 20;
   Mensagem.Margins.Right := 10;
   Mensagem.TextSettings.HorzAlign := TTextAlign.Leading;
   Layout.AddObject(Mensagem);

   FundoMsgs := TCircle.Create(Fundo);
   FundoMsgs.Align := TAlignLayout.Right;
   FundoMsgs.Fill.Color:= TAlphaColorRec.Darkgreen;
   FundoMsgs.Stroke.Thickness := 0;
   FundoMsgs.Width := Mensagem.Height-6;
//   FundoMsgs.Position.X := 0;
   FundoMsgs.Margins.Top := 3;
   FundoMsgs.Margins.Bottom := 3;

   FundoMsgs.Name :=  'FundoQtd_'+FDQuery1.FieldByName('ID_Contato').AsString;
   FundoMsgs.Visible := M;
   Mensagem.AddObject(FundoMsgs);

   ImagePopup := TImage.Create(Fundo);
   ImagePopup.Align := TAlignLayout.Right;
   ImagePopup.Width := Mensagem.Height-6;
   ImagePopup.Margins.Top := 3;
   ImagePopup.Margins.Bottom := 3;
   ImagePopup.ImageByName('SetaBaixo',ImageList1);
   ImagePopup.Name :=  'FundoPopup_'+FDQuery1.FieldByName('ID_Contato').AsString;
   ImagePopup.Visible := False;
   ListaIcone.Add(ImagePopup);
   Mensagem.AddObject(ImagePopup);


   QuantMsgs := TText.Create(Fundo);
   if M then begin
     QuantMsgs.Text := '1'
   end else
     QuantMsgs.Text := '0';

   QuantMsgs.Name := 'Qtd_'+FDQuery1.FieldByName('ID_Contato').AsString;
   QuantMsgs.TextSettings.Font.Size := 10;
   QuantMsgs.TextSettings.FontColor := TAlphaColorRec.White;
   QuantMsgs.TextSettings.Font.Style := [TFontStyle.fsBold];
   QuantMsgs.Align := TAlignLayout.Client;
   FundoMsgs.AddObject(QuantMsgs);

   ListaFundo.Add(Fundo);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

   ListaFundo := TObjectList<TRectangle>.Create;
   ListaIcone := TObjectList<TImage>.Create;

   FDConnection1.DriverName := 'SQlite';
   FDConnection1.Params.Database := 'test.db';
   FDConnection1.Connected := true;

   FDConnection1.ExecSQL('CREATE TABLE IF NOT EXISTS contatos('+
                         'id INTEGER PRIMARY KEY AUTOINCREMENT , '+
                         'Nome VARCHAR(25),'+
                         'Telefone VARCHAR(18)); '+

                         'CREATE TABLE IF NOT EXISTS mensagens('+
                         'id INTEGER PRIMARY KEY AUTOINCREMENT ,'+
                         'id_Contato VARCHAR(25),'+
                         'Mensagem VARCHAR(18), '+
                         'Visualizada BOOLEAN, '+
                         'DataEnvio DATE, '+
                         'HoraEnvio TIME)');


end;

procedure TForm1.OrganizaLayout;
var Msg : TText;
    Circ :TCircle;
begin
   FDQuery1.Open(' SELECT * FROM ( '+
                 ' SELECT ID, ID_Contato,  Max(HoraEnvio) Hora, Mensagem  FROM mensagens GROUP BY ID_Contato ) Mensagem '+
                 ' INNER JOIN contatos ON contatos.ID = mensagem.ID_Contato '+
                 ' ORDER BY Hora DESC ');

   FDQuery1.First;
   while not FDQuery1.Eof do begin
      if VertScrollBox1.FindComponent('Card_'+FDQuery1.FieldByName('ID_Contato').AsString) <> nil then begin

         Msg :=  TText(
                   TRectangle(
                     VertScrollBox1.FindComponent('Card_'+FDQuery1.FieldByName('ID_Contato').AsString).
                     FindComponent('Msg_'+FDQuery1.FieldByName('ID_Contato').AsString)));

         Msg.Text := FDQuery1.FieldByName('Mensagem').AsString;

         Msg := TText(
           TRectangle(
             VertScrollBox1.FindComponent('Card_'+FDQuery1.FieldByName('ID_Contato').AsString).
             FindComponent('Hor_'+FDQuery1.FieldByName('ID_Contato').AsString)));

         Msg.Text := LeftStr( FDQuery1.FieldByName('Hora').AsString,5);


         if Msg.Hint <> FDQuery1.FieldByName('Hora').AsString then begin
            Msg.Hint :=FDQuery1.FieldByName('Hora').AsString;
            Msg :=  TText(
                      TRectangle(
                      VertScrollBox1.FindComponent('Card_'+FDQuery1.FieldByName('ID_Contato').AsString).
                        FindComponent('Qtd_'+FDQuery1.FieldByName('ID_Contato').AsString)));

            Msg.Text := InttoStr(StrtoInt(Msg.Text) + 1);

         end else begin
            Msg.Hint :=FDQuery1.FieldByName('Hora').AsString;
            Msg := TText(
                     TRectangle(
                     VertScrollBox1.FindComponent('Card_'+FDQuery1.FieldByName('ID_Contato').AsString).
                       FindComponent('Qtd_'+FDQuery1.FieldByName('ID_Contato').AsString)));


         end;

         Circ :=  TCircle(
             TRectangle(
               VertScrollBox1.FindComponent('Card_'+FDQuery1.FieldByName('ID_Contato').AsString).
               FindComponent('FundoQtd_'+FDQuery1.FieldByName('ID_Contato').AsString)));

         Circ.Visible := not( Msg.Text = '0');

         TRectangle( VertScrollBox1.FindComponent('Card_'+FDQuery1.FieldByName('ID_Contato').AsString))
               .AnimateFloat('Position.Y',(TRectangle( VertScrollBox1.FindComponent('Card_'+FDQuery1.FieldByName('ID_Contato').AsString)).Height * (FDQuery1.RecNo-1)) ,
                0.5 ,  TAnimationType.&In,TInterpolationType.Back );
      end else DesenharLayout(True);

      FDQuery1.Next;
   end;

end;

procedure TForm1.Rectangle2Click(Sender: TObject);
var I :Integer;
begin
   if TRectangle(Sender).Fill.Color = TAlphaColorRec.Lightblue then begin
      TRectangle(Sender).Fill.Color := TAlphaColorRec.Lightcoral;

      for I := 0 to ListaFundo.Count -1 do  begin
         if ListaFundo[I].Name <>  TRectangle(Sender).Name then
           ListaFundo[I].Fill.Color :=  TAlphaColorRec.White;

      end;
   end else if TRectangle(Sender).Fill.Color = TAlphaColorRec.Lightcoral then begin
      TRectangle(Sender).Fill.Color := TAlphaColorRec.Lightblue;

      for I := 0 to ListaFundo.Count -1 do  begin
         if ListaFundo[I].Name <>  TRectangle(Sender).Name then
           ListaFundo[I].Fill.Color :=  TAlphaColorRec.White;
      end;
   end;

end;

procedure TForm1.Rectangle2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
var I: Integer;
begin

   for I := 0 to ListaFundo.Count -1 do  begin
      if (ListaFundo[I].Name <> TRectangle(Sender).Name) and (ListaFundo[I].Fill.Color = TAlphaColorRec.Lightblue)  then begin
         ListaFundo[I].Fill.Color := TAlphaColorRec.White;
         ListaIcone[I].Visible := False;
      end else if ListaFundo[I].Fill.Color = TAlphaColorRec.Lightcoral then
            ListaIcone[I].Visible := False;
   end;

   if TRectangle(Sender).Fill.Color = TAlphaColorRec.White then begin
      TRectangle(Sender).Fill.Color := TAlphaColorRec.Lightblue;

      for I := 0 to ListaFundo.Count -1 do  begin
         if (ListaFundo[I].Name = TRectangle(Sender).Name) then begin
            ListaIcone[I].Position.X := 1000;
            ListaIcone[I].Margins.Left := 3;
            ListaIcone[I].Visible := True;
         end;
      end;
   end;

   if TRectangle(Sender).Fill.Color = TAlphaColorRec.Lightcoral then begin
      for I := 0 to ListaFundo.Count -1 do  begin
         if (ListaFundo[I].Name = TRectangle(Sender).Name) then begin
            ListaIcone[I].Position.X := 1000;
            ListaIcone[I].Margins.Left := 3;
            ListaIcone[I].Visible := True;
         end;
      end;
   end;

end;

{ TImageHelper }

procedure TImageHelper.ImageByName(Name :String; ImageList:TImageList);
var
   Item : TCustomBitmapItem;
   Size :TSize;
begin
   if ImageList.BitmapItemByName(Name,Item,Size) then
      Self.Bitmap := Item.MultiResBitmap.Bitmaps[1.0]
end;

end.
