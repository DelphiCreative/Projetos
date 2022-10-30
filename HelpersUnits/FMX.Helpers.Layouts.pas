unit FMX.Helpers.Layouts;

interface

uses
   System.Classes,FMX.Controls, FMX.Ani, FMX.Layouts, FMX.Objects, FMX.Types;

type
  TGridPanelLayoutHelper = class helper for TGridPanelLayout
     procedure CreateGrid(const Row,Col:Integer);
     constructor Create(AOwner :TComponent;const Row, Col  :Integer); overload;
  end;

type
  TLayoutHelper = class helper for TLayout
     procedure Finish(Sender :TObject);
     procedure AnimaCard(Card :TRectangle); overload;
     procedure AnimaCard(Card :TRectangle; aProperty :String);overload;
     constructor Create(AOwner :TComponent;AlignLayout : TAlignLayout) overload;
  end;


implementation

{ TLayoutHelper }

procedure TLayoutHelper.AnimaCard(Card: TRectangle; aProperty: String);
var
   FloatOpacity, FloatPositionX :TFloatAnimation;
begin
   BeginUpdate;
   Card.Height := Self.Height;
   Card.Width := Self.Width - 10;
   Card.Align := TAlignLayout.None;
   Card.Stroke.Thickness := 0;

   if aProperty = 'L' then begin
      Card.Position.X :=  Self.Width;
      Card.Opacity := 0;
   end else if aProperty = 'R' then begin
      Card.Position.X :=   Self.Width * -1 ;
      Card.Opacity := 0;
   end;

   if Self.ControlsCount = 1 then begin
      FloatPositionX := TFloatAnimation.Create(Self.Controls[0]);
      Self.Controls[0].AddObject(FloatPositionX);
      FloatPositionX.Duration := 0.3;
      FloatPositionX.StartFromCurrent := True;

      if aProperty = 'L' then begin
         FloatPositionX.StopValue :=  Self.Width * -1;
         FloatPositionX.PropertyName := 'Position.X';

      end else if aProperty = 'R' then begin
         FloatPositionX.PropertyName := 'Position.X';
         FloatPositionX.StopValue :=  Self.Width ;
      end;

      FloatPositionX.OnFinish := Finish;

      FloatOpacity := TFloatAnimation.Create(Self.Controls[0]);
      Self.Controls[0].AddObject(FloatOpacity);
      FloatOpacity.Duration := 0.3;
      FloatOpacity.PropertyName := 'Opacity';
      FloatOpacity.StartValue := 1;
      FloatOpacity.StopValue := 0;

      FloatOpacity.Start;
      FloatPositionX.Start;
   end;

   Self.AddObject(Card);

   FloatPositionX := TFloatAnimation.Create(Card);
   Card.AddObject(FloatPositionX);
   FloatPositionX.Duration := 0.3;
   FloatPositionX.PropertyName := 'Position.X';
   FloatPositionX.StartFromCurrent := True;
   FloatPositionX.StopValue := 10 ;

   FloatOpacity := TFloatAnimation.Create(Card);
   Card.AddObject(FloatOpacity);
   FloatOpacity.Duration := 0.3;
   FloatOpacity.PropertyName := 'Opacity';
   FloatOpacity.StartValue := 0;
   FloatOpacity.StopValue := 1;

   FloatPositionX.Start;
   FloatOpacity.Start;
   EndUpdate;
end;

procedure TLayoutHelper.AnimaCard(Card: TRectangle);
var
   FloatHeight, FloatWidth, FloatOpacity, FloatPositionX  : TFloatAnimation;
begin

   Card.Align := TAlignLayout.Center;
   Card.Stroke.Thickness := 0;
   Card.Width := 10;
   Card.Height := 10;

   if Self.ControlsCount = 1 then begin
      FloatPositionX := TFloatAnimation.Create(Self.Controls[0]);
      Self.Controls[0].AddObject(FloatPositionX);

      FloatPositionX.Duration := 0.3;
      FloatPositionX.PropertyName := 'Position.X';
      FloatPositionX.StartValue := 0;

      if Self.Tag = 0 then begin
         FloatPositionX.StopValue :=  Self.Width * -1;
         Self.Tag := 1;
      end else begin

         FloatPositionX.StopValue :=  Self.Width * 2;
         Self.Tag := 0;
      end;

      FloatPositionX.OnFinish := Finish;

      FloatOpacity := TFloatAnimation.Create(Self.Controls[0]);
      Self.Controls[0].AddObject(FloatOpacity);
      FloatOpacity.Duration := 0.3;
      FloatOpacity.PropertyName := 'Opacity';
      FloatOpacity.StartValue := 1;
      FloatOpacity.StopValue := 0;

      FloatOpacity.Start;
      FloatPositionX.Start;
   end;

   Self.AddObject(Card);

   FloatHeight := TFloatAnimation.Create(Card);
   Card.AddObject(FloatHeight);
   FloatHeight.Duration := 0.3;
   FloatHeight.PropertyName := 'Size.Height';
   FloatHeight.StartValue := 0;
   FloatHeight.StopValue := Self.Height-10;

   FloatWidth := TFloatAnimation.Create(Card);
   Card.AddObject(FloatWidth);
   FloatWidth.Duration := 0.3;
   FloatWidth.PropertyName := 'Size.Width';
   FloatWidth.StartValue := 0;
   FloatWidth.StopValue := Self.Width-10;

   FloatOpacity := TFloatAnimation.Create(Card);
   Card.AddObject(FloatOpacity);
   FloatOpacity.Duration := 0.3;
   FloatOpacity.PropertyName := 'Opacity';
   FloatOpacity.StartValue := 0;
   FloatOpacity.StopValue := 1;

   FloatHeight.Start;

   FloatWidth.Start;
   FloatOpacity.Start ;

end;

constructor TLayoutHelper.Create(AOwner: TComponent; AlignLayout: TAlignLayout);
begin
   inherited Create(AOwner);
   Size.PlatformDefault := False;
   Align := AlignLayout;
   TFMXObject(AOwner).AddObject(Self);

   if  TControl(AOwner).Height <= TControl(AOwner).Width then
       Self.Height := TControl(AOwner).Height
   else
       Self.Height := TControl(AOwner).Width;

   Self.Width := Self.Height;


end;

procedure TLayoutHelper.Finish(Sender: TObject);
var I :Integer;
begin
   for I := 0 to Self.Controls.Count - 2 do
       Self.Controls[I].Free;
end;

{ TGridPanelLayoutHelper }

constructor TGridPanelLayoutHelper.Create(AOwner: TComponent; const Row,
  Col: Integer);
begin
   inherited Create(AOwner);
   Self.Align := TAlignLayout.Client;
   CreateGrid(Row, Col );
end;

procedure TGridPanelLayoutHelper.CreateGrid(const Row, Col: Integer);
var I :Integer;
begin

   Self.RowCollection.BeginUpdate;
   Self.ColumnCollection.BeginUpdate;

   for I := 0 to Self.ControlsCount -1 do
      Self.Controls[0].Free;

   Self.RowCollection.Clear;
   Self.ColumnCollection.Clear;

   for I := 0 to Row -1 do begin
      Self.RowCollection.Add;
      Self.RowCollection.Items[i];
      Self.RowCollection.Items[I].Value := 100;
      Self.RowCollection.Items[I].SizeStyle := TGridPanelLayout.TSizeStyle.Percent;
   end;


   for I := 0 to Col -1 do begin
      Self.ColumnCollection.Add;
      Self.ColumnCollection.Items[i];
      Self.ColumnCollection.Items[I].Value := 100;
      Self.ColumnCollection.Items[I].SizeStyle := TGridPanelLayout.TSizeStyle.Percent;
   end;

   Self.ColumnCollection.EndUpdate;
   Self.RowCollection.EndUpdate;

end;

end.
