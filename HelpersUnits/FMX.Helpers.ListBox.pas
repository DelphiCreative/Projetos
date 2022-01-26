unit FMX.Helpers.ListBox;

interface

uses
  System.Classes, FMX.Controls, FMX.Types, FMX.Listbox;

type
  TListBoxHelper = class helper for TListBox
     procedure Search;
  end;

type
  TListBoxItemHelper = class helper for TListBoxItem
     constructor Create(AOwner :TComponent; aText :String; aHeight :Single) overload;
  end;

implementation

{ TListBoxItemHelper }

constructor TListBoxItemHelper.Create(AOwner: TComponent; aText: String;aHeight :Single);
begin
   inherited Create(AOwner);
   TFMXObject(AOwner).AddObject(Self);
   Height := aHeight;
   Text := aText;
end;

{ TListBoxHelper }

procedure TListBoxHelper.Search;
begin
//
end;

end.
