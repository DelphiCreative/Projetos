unit FMX.Helper.FlowLayout;

interface

uses
   System.Classes,FMX.Types, FMX.Layouts, FMX.Objects, System.UITypes,
   System.Types, TypInfo;

type
  TFlowLayoutHelper = class helper for TFlowLayout
  public
    procedure LoadStrings(AStrings: TArray<String>; RectangleClick: TNotifyEvent = nil);
    procedure AddText(AText: string; AClick: TNotifyEvent);
    procedure SelectItem(SelectedText: String);
    function ItemSelected: String;
  private
    procedure ItemClick(Sender: TObject);
  end;

implementation

procedure TFlowLayoutHelper.AddText(AText: string; AClick: TNotifyEvent);
var
  rct: TRectangle;
  txt: TText;
begin

  rct := TRectangle.Create(Self);
  rct.Parent := Self;

  txt := TText.Create(rct);
  txt.Text := AText;
  txt.Align := TAlignLayout.Center;
  txt.Width := Self.Width;
  txt.AutoSize := True;
  txt.HitTest := False;
  txt.Parent := rct;

  Self.AddObject(rct);

  rct.Fill.Color := TAlphaColors.Seashell;
  rct.Stroke.Thickness := 0;
  rct.Hint := txt.Text;
  rct.AddObject(txt);
  rct.Width := txt.Width + 10;
  rct.Height := txt.Height + 10;
  rct.Margins.Top := 5;
  rct.Margins.Right := 10;
  rct.XRadius := 10;
  rct.YRadius := 10;
  rct.OnClick := AClick;

end;

procedure TFlowLayoutHelper.LoadStrings(AStrings: TArray<String>;
  RectangleClick: TNotifyEvent = nil );
var
  i: Integer;
  ActualClickEvent :TNotifyEvent;
begin

  if Assigned(RectangleClick) then
     ActualClickEvent := RectangleClick
  else
     ActualClickEvent := ItemClick;

  Self.BeginUpdate;
  try
    Self.DeleteChildren;

    for i := 0 to High(AStrings) do
      AddText(AStrings[i], ActualClickEvent);

  finally
    Self.EndUpdate;
  end;

end;

procedure TFlowLayoutHelper.SelectItem(SelectedText: String);
var
  i: Integer;
  rct: TRectangle;
begin
  for i := 0 to Self.ControlsCount - 1 do
  begin
    if Self.Controls[i] is TRectangle then
    begin
      rct := TRectangle(Self.Controls[i]);
      rct.Fill.Color := TAlphaColors.Seashell;

      if (rct.Hint = SelectedText) then
      begin
        rct.Fill.Color := TAlphaColors.Lightblue;
      end;
    end;
  end;
end;

procedure TFlowLayoutHelper.ItemClick(Sender: TObject);
var
  i: Integer;
  rct : TRectangle;
  rctSender: TRectangle;
  flowLayout: TFlowLayout;
begin

  if not (Sender is TRectangle) then Exit;

  rctSender := TRectangle(Sender);
  if not (rctSender.Parent is TFlowLayout) then Exit;

  flowLayout := TFlowLayout(rctSender.Parent);

  for i := 0 to flowLayout.ControlsCount - 1 do
  begin
    if flowLayout.Controls[i] is TRectangle then
    begin
      rct := TRectangle(flowLayout.Controls[i]);
      rct.Fill.Color := TAlphaColors.Seashell;
    end;
  end;

  rctSender.Fill.Color := TAlphaColors.Lightblue;
  flowLayout.TagString := rctSender.Hint;
end;


function TFlowLayoutHelper.ItemSelected: String;
begin
  Result := Self.TagString;
end;

end.
