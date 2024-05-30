unit uMain;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    GridPanelLayout1: TGridPanelLayout;
    rctA1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    imgA1: TImage;
    rctB1: TRectangle;
    imgB1: TImage;
    rctC1: TRectangle;
    imgC1: TImage;
    rctA2: TRectangle;
    imgA2: TImage;
    rctB2: TRectangle;
    imgB2: TImage;
    rctC2: TRectangle;
    imgC2: TImage;
    rctA3: TRectangle;
    imgA3: TImage;
    rctB3: TRectangle;
    imgB3: TImage;
    rctC3: TRectangle;
    imgC3: TImage;
    rctNewGame: TRectangle;
    btnNewGame: TSpeedButton;
    ShadowEffect9: TShadowEffect;
    Text1: TText;
    rctMode: TRectangle;
    btnMode: TSpeedButton;
    ShadowEffect1: TShadowEffect;
    txtMode: TText;
    Label1: TLabel;
    ImgX: TImage;
    ImgO: TImage;
    procedure RectangleClick(Sender: TObject);
    procedure btnModeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Text1Click(Sender: TObject);
    procedure btnNewGameClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Player: Char;
    Moves: TQueue<TRectangle>;
    GameOver: Boolean;
    InfiniteMode: Boolean;

    procedure CheckWin;
    procedure SwitchPlayer;
    procedure ResetGame;
    procedure UpdateMode;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.CheckWin;
const
  Wins: array[0..7, 0..2] of Integer = (
    (0, 1, 2), (3, 4, 5), (6, 7, 8), // Rows
    (0, 3, 6), (1, 4, 7), (2, 5, 8), // Columns
    (0, 4, 8), (2, 4, 6)             // Diagonals
  );
var
  I: Integer;
  Rect1, Rect2, Rect3: TRectangle;
  Win: Boolean;
begin
  for I := 0 to 7 do
  begin
    Rect1 := TRectangle(GridPanelLayout1.Children[Wins[I, 0]]);
    Rect2 := TRectangle(GridPanelLayout1.Children[Wins[I, 1]]);
    Rect3 := TRectangle(GridPanelLayout1.Children[Wins[I, 2]]);
    Win := (Rect1.TagString <> '') and (Rect1.TagString = Rect2.TagString) and (Rect1.TagString = Rect3.TagString);

    if Win then
    begin
      Rect1.Fill.Color := TAlphaColors.Mediumaquamarine;
      Rect2.Fill.Color := TAlphaColors.Mediumaquamarine;
      Rect3.Fill.Color := TAlphaColors.Mediumaquamarine;

      Label1.Text := 'Player ' + Rect1.TagString + ' wins!';
      GameOver := True;
      Exit;
    end;
  end;

  if not InfiniteMode and (Moves.Count = 9) then
  begin
    Label1.Text := 'Empate!';
    GameOver := True;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
  Rect: TRectangle;
  Img: TImage;
begin
  Player := 'X';
  Moves := TQueue<TRectangle>.Create;
  Label1.Text := 'Player: ' + Player;
  GameOver := False;
  UpdateMode;
end;

procedure TForm1.RectangleClick(Sender: TObject);
var
  Rect, NextRect: TRectangle;
  Img: TImage;
begin
  if GameOver then Exit;

  Rect := TRectangle(Sender);
  if Rect.TagString = '' then
  begin
    if Player = 'X' then
      TImage(Rect.Children[0]).Bitmap.Assign(ImgX.Bitmap)
    else
      TImage(Rect.Children[0]).Bitmap.Assign(ImgO.Bitmap);

    Rect.TagString := Player;

    Moves.Enqueue(Rect);

    // Se o modo infinito estiver ativado e já houver mais de 7 movimentos, remova o item mais antigo
    if InfiniteMode and (Moves.Count > 7) then
    begin
      Rect := Moves.Dequeue;
      TImage(Rect.Children[0]).Bitmap := nil;
      Rect.TagString := '';
    end;

    CheckWin;
    if not GameOver then begin
      // Se o modo infinito estiver ativado, marque o próximo item a ser removido
      if InfiniteMode and (Moves.Count >= 7) then
      begin
        NextRect := Moves.Peek;
        TImage(NextRect.Children[0]).Bitmap.ReplaceOpaqueColor(TAlphaColors.Darkgray);
      end;
      SwitchPlayer
    end;
  end;
end;

procedure TForm1.ResetGame;
var
  I: Integer;
  Rect: TRectangle;
begin
  Player := 'X';
  Label1.Text := 'Player: ' + Player;
  Moves.Clear;
  GameOver := False;

  for I := 0 to GridPanelLayout1.ChildrenCount - 1 do
  begin
    if GridPanelLayout1.Children[I] is TRectangle then
    begin
      Rect := TRectangle(GridPanelLayout1.Children[I]);
      TImage(Rect.Children[0]).Bitmap := nil;
      Rect.Fill.Color := TAlphaColors.White;
      Rect.TagString := '';
    end;
  end;
end;

procedure TForm1.btnNewGameClick(Sender: TObject);
begin
   ResetGame;
end;

procedure TForm1.SwitchPlayer;
begin
  if Player = 'X' then
     Player := 'O'
  else
     Player := 'X';

  Label1.Text := 'Player: ' + Player;
end;

procedure TForm1.Text1Click(Sender: TObject);
begin
  ResetGame;
end;

procedure TForm1.UpdateMode;
begin
  InfiniteMode := txtMode.Text = 'INFINITO';
  ResetGame;
end;

procedure TForm1.btnModeClick(Sender: TObject);
begin
   if txtMode.Text = 'NORMAL' then
      txtMode.Text := 'INFINITO'
   else
      txtMode.Text := 'NORMAL';

   UpdateMode;
end;

end.
