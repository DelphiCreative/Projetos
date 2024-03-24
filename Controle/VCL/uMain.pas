unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, ShellAPi, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Clientes1: TMenuItem;
    Produtos1: TMenuItem;
    N1: TMenuItem;
    Categorias1: TMenuItem;
    Subcategorias1: TMenuItem;
    Movimentao1: TMenuItem;
    Compras1: TMenuItem;
    Vendas1: TMenuItem;
    Relatrios1: TMenuItem;
    Clientes2: TMenuItem;
    Produtos2: TMenuItem;
    N2: TMenuItem;
    Vendas2: TMenuItem;
    Compras2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    FDConnection: TFDConnection;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CreateMenuItems(const AParent: TMenuItem; const APath: string);
    procedure MenuItemClick(Sender: TObject);

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses System.IOUtils;
{ TForm1 }

procedure TForm1.CreateMenuItems(const AParent: TMenuItem; const APath: string);
var
  SR: TSearchRec;
  MenuItem: TMenuItem;
begin
  if FindFirst(APath + '\*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr and faDirectory) <> 0 then
      begin
        if (SR.Name <> '.') and (SR.Name <> '..') then
        begin
          MenuItem := TMenuItem.Create(Self);
          MenuItem.Caption := SR.Name;
          CreateMenuItems(MenuItem, APath + '\' + SR.Name);
          if MenuItem.Count > 0 then
            AParent.Add(MenuItem)
          else
            MenuItem.Free;
        end;
      end
      else if (ExtractFileExt(SR.Name) = '.exe') then
      begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.Caption := ChangeFileExt(SR.Name, '');
        MenuItem.OnClick := MenuItemClick;
        MenuItem.Tag := Integer(Pointer(APath + '\' + SR.Name));
        MenuItem.Hint := (APath + '\' + SR.Name);

        AParent.Add(MenuItem);
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin

   FDConnection.Params.Database := 'C:\Git\Projetos\BarChartRaceDelphi\Vendas.sdb';
   FDConnection.Params.DriverID := 'SQlite';

   FDConnection.Connected := True;

   var path := TPath.Combine(TPath.GetDirectoryName(Application.ExeName),'Menus');

   CreateMenuItems(MainMenu1.Items, path);
end;

procedure TForm1.MenuItemClick(Sender: TObject);
var params : string;
begin

   params := FDConnection.Params.Database + ' ' + FDConnection.Params.DriverID;

  ShellExecute(0, 'open', PChar(TMenuItem(Sender).hint) , PChar(params) , nil, SW_SHOWNORMAL);
end;

end.
