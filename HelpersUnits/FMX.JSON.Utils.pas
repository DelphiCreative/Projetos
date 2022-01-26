unit FMX.JSON.Utils;

interface

uses
  Data.DB,
  Data.DBXJSONCommon,
  FireDAC.Comp.BatchMove.DataSet,
  FireDAC.Comp.BatchMove,
  FMX.MultiResBitmap,
  System.Types,
  FMX.Layouts,
  System.StrUtils,
  Soap.EncdDecd,
  {$IF CompilerVersion >= 33}
  FireDAC.Comp.BatchMove.JSON,
  {$ENDIF}
  FMX.Dialogs,
  FMX.Grid,
  FMX.Edit,
  FMX.EditBox,
  FMX.ListBox,
  FMX.Objects,
  FMX.Controls,
  FMX.ComboEdit,
  FMX.Memo,
  FMX.Types,
  FMX.NumberBox,
  FMX.StdCtrls,
  FMX.Graphics,
  FMX.Menus,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.DateTimeCtrls,
  RegularExpressions,
  REST.Response.Adapter,
  System.UITypes,
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.JSON,
  System.IOUtils,
  FMX.Ani,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent;

type
  TStringGridHelper = class helper for TStringGrid
    procedure Open(JSON :String;Names :String = '' ); overload;
    procedure AutoAjuste(Column: integer);
  end;

type
  TImageHelper = class helper for TImage
    procedure LoadUrl(url :String);
    procedure LoadJSON(JSArray :String); overload;
  end;

type
  TShapeHelper = class helper for TShape
    procedure WhatsAppClick(Sender :TObject);
    procedure OfertasClick(Sender :TObject);
    procedure RSlideClick(Sender :TObject);
    procedure LoadUrl(url :String);
    procedure LoadJSON(JSArray,Nome :String); overload;
    procedure LoadJSON(JSArray :String); overload;
    procedure ImagemByName(Nome:String);
    procedure LogoByName(Nome:String);

    procedure Text(Texto :String;FontSize :Real = 10);
    procedure OpenDialog;
    procedure URLClick(Sender :TObject);
    procedure Slides;
    procedure SlidesAnimacaoFinish(Sender :TObject);

    procedure SlidesLoja;
    procedure SlidesLojaAnimacaoFinish(Sender :TObject);

    function Base64(y, x :Integer) : String; overload;
    function TamanhoJSA(y, x :Integer) : String;
    procedure OpenJSONArray(value :String);
    procedure Bitmap(base64: string);

    function JSArray :String;
    function Base64 :String; overload;
  end;

type
  TControlHelper = class helper for TControl
    function JSON :String;
    function ID :String;

    function FieldName :String;
    function AddEdit(Titulo,FieldName :String;Decimal :Boolean = False) :TControl;
    function AddDate(Titulo,FieldName :String) :TControl;
    function AddCheck(Titulo,FieldName :String) :TControl;
    function AddNumber(Titulo,FieldName :String) :TControl;
    function AddComboBox(Titulo,FieldName,Itens :String) :TControl;
    function AddImagem(Titulo,FieldName :String ):TControl;
    function AddText(Text :String; FontSize :Real = 12; Bold :Boolean = False;
     VAlign : TTextAlign = TTextAlign.Leading ):TControl;
    function AddTextCenter(Text :String; FontSize :Real = 12; Bold :Boolean = False;
      Cor :TAlphaColor = TAlphaColors.Darkgray ):TControl;
    function AddTextRight(Text :String; FontSize :Real = 12;
       Bold :Boolean = False):TControl;

    procedure ClearFields;
    procedure ClearItens;
    procedure OnClickShape(Sender :TObject);
    procedure OpenFields(JSON :String);
  end;

type
  TCheckBoxHelper = class helper for TCheckBox
    function FieldName :String;
  end;

type
  TListBoxItemHelper = class helper for TListBoxItem
    procedure AddLabel(Text :String; Size :Real = 14);
  end;

type
   TListBoxHelper = class helper for TListBox
     function ID :String;
     procedure Open(JSON :String; Text, Detail: String); overload;
   end;

type
   TJSONObjectHelper = class helper for TJSONObject
     public
      function Value(Name :String) :String;
      function GetBoolean(value :String) : Boolean; overload;
      function GetFloat(value :String) : Extended; overload;
      function GetString(value :String) : String; overload;
      function GetStringData(value :String) : String; overload;
      function GetInteger(value :String) : Integer; overload;
      function GetURL(Categoria,SubCategoria,Produto :String):String;
  end;

type
  TDataSetHelper = class helper for TDataSet
    procedure OpenJSON(JSON:String);
    procedure OpenUser(JSON:String);
    function OpenJSONArray(SQL:String) :String;
    function FieldxValue(Field:String; Value :TEdit):TDataSet;
    {$IF CompilerVersion >= 33}
    function JSONArray :TJSONArray;
    {$ENDIF}
  end;

procedure CreateLabel(Control :TControl;Text :String);
procedure Get(Edit:TEdit); overload;
procedure Get(Date:TDateEdit); overload;
procedure Get(Number:TNumberBox); overload;
procedure Get(Check:TCheckBox); overload;
procedure Get(Combobox: TComboBox); overload;
procedure Get(Shape :TShape); overload;
procedure JSONToFile(JSArray, Path, Nome: String);
function JX(JSON :String) : String;

procedure EnviaPushNovidades(Title,Body,idProduto,IDUser:String);


function Combobox(JSON,Field :String) :String;

var
  JSONObject :TJSONObject;
  FSlide : TLayout;

implementation

uses uContainer, Funcoes, uMain;

procedure EnviaPushNovidades(Title,Body,idProduto,IDUser:String);
var
   client : THTTPClient;
   v_json : TJSONObject;
   v_jsondata : TJSONObject;
   v_data : TStringStream;
   v_response : TStringStream;

   token_celular : string;
   //codigo_projeto : string;
   // api : string;
   url_google : string;
   I,J : Integer;
   JSONObject :TJSONObject;
   JSONValue :TJSONValue;
   JSONArray :TJSONArray;
begin

  { Form2.RT.Collection('push-send')
           .Key('')
            .AddPair('title',Title)
            .AddPair('body',Body).Update;
   }

  // abort;
   for I := 0 to FormMain.JSONPush.Count - 1 do begin
//    TThread.CreateAnonymousThread(
//    procedure ()
//    begin

      JSONValue := TJSONObject.ParseJSONValue(FormMain.JSONPush.Pairs[i].JsonValue.ToJSON);

      if JSONValue is TJSONObject then
         JSONValue := TJSONObject.ParseJSONValue('['+JSONValue.ToJSON+']');

      if JSONValue is TJSONArray then begin
         JSONArray := TJSONObject.ParseJSONValue(JSONValue.ToJSON) as TJSONArray;
         for J := 0 to JSONArray.Count - 1 do begin
            JSONObject := TJSONObject.ParseJSONValue(JSONArray.Items[J].ToJSON) as TJSONObject;

            url_google := 'https://fcm.googleapis.com/fcm/send'; // Firebase
            token_celular := JSONObject.GetValue('token').Value;

            //--------------------------------
            v_json := TJSONObject.Create;
            v_json.AddPair('to', token_celular);
            v_json.AddPair('priority','high');

            v_jsondata := TJSONObject.Create;
            v_jsondata.AddPair('title',Title);
            v_jsondata.AddPair('body', Body);
            v_json.AddPair('notification', v_jsondata);

            v_jsondata := TJSONObject.Create;
            v_jsondata.AddPair('mensagem', Body);
            v_jsondata.AddPair('titulo', Title);
            v_jsondata.AddPair('produto',idProduto);
            v_jsondata.AddPair('user',IDUser);
            v_jsondata.AddPair('tipo','novidades');

            v_json.AddPair('data', v_jsondata);
            client := THTTPClient.Create;
            client.ContentType := 'application/json';
            client.CustomHeaders['Authorization'] := 'key=' + token_cloud_message;

            v_data := TStringStream.Create(v_json.ToString, TEncoding.UTF8);
            v_data.Position := 0;
            try
              v_response := TStringStream.Create;
              client.Post(url_google, v_data, v_response);
              v_response.Position := 0;

            except on e:exception do
               showmessage('Erro: ' + e.Message);
            end;
         end;
      end;
   end;
end;

procedure Get(Number:TNumberBox); overload;
begin
   Number.Text :=JSONObject.Value(Number.FieldName);
end;

procedure Get(Edit:TEdit); overload;
begin
   Edit.Text :=JSONObject.Value(Edit.FieldName);
end;

procedure Get(Date:TDateEdit); overload;
begin
   Date.Text := JSONObject.Value(Date.FieldName).Replace('_','').Replace('//','');
end;

procedure Get(Combobox: TComboBox); overload;
var I :Integer;
begin
   Combobox.ItemIndex := -1;
   for I := 0 to Combobox.Items.Count - 1 do begin
      if JSONObject.Value(Combobox.FieldName) = Combobox.Items[i] then
         Combobox.ItemIndex := I;
   end;
end;

procedure Get(Shape :TShape); overload;
begin
   Shape.LoadJSON(JSONObject.Value(Shape.FieldName));
end;

procedure Get(Check:TCheckBox); overload;
begin
   Check.IsChecked := (JSONObject.Value(Check.FieldName) = 'Sim');
end;

procedure JSONToFile(JSArray, Path, Nome: String);
var
   JSONArray : TJSONArray;
   JSONValue :TJSONValue;
   FileStream: TFileStream;
   Stream : TStream;
   buf: TBytes;
begin

   JSArray := JSArray.Replace('"','');
   if JSArray <> '' then begin
      JSONValue := TJSONObject.ParseJSONValue(JSArray);
      if JSONValue is TJSONArray then begin
         JSONArray := TJSONObject.ParseJSONValue(JSArray) as TJSONArray;
         FileStream := TFileStream.Create(TPath.Combine(Path,Nome), fmCreate);
         Stream := TDBXJSONTools.JSONToStream(jsonArray);
         try
            SetLength(buf, Stream.Size);
            Stream.Position := 0;
            Stream.ReadBuffer(buf[0], Stream.Size);
           FileStream.WriteBuffer(buf[0], Stream.Size);
         finally
            Stream.DisposeOf;
            FileStream.DisposeOf;
            JSONArray.DisposeOf;
         end;
      end;
      JSONVAlue.DisposeOf;
   end;
end;

procedure CreateLabel(Control :TControl;Text :String);
var
   txt :TLabel;
begin
   txt := TLabel.Create(Control);
   txt.Parent := Control;
   txt.Position.Y := -20;
   txt.Size.Width := 161;
   txt.Size.Height := 23;
   txt.Size.PlatformDefault := False;
   txt.Text := Text;
   {$IF DEFINED(android) or DEFINED(iOS)}
    txt.TextSettings.Font.Size := 10;
    txt.TextSettings.Font.Style := [TFontStyle.fsBold];
    txt.StyledSettings := [];

   {$ENDIF}

   txt.TextSettings.HorzAlign := TTextAlign.Leading;
end;

function JX(JSON :String) : String;
var
   arr1, arr2 :TArray<String>;
   js :TStringBuilder;
   I :Integer;
begin

   arr1 := TRegEx.Split(JSON,'{"_id"');
   js := TStringBuilder.Create;
   for I := 1 to TRegEx.Matches(JSON,'{"_id"').Count do begin
      arr2 := TRegEx.Split(arr1[i],'}');
      js.Append('{"_id"'+ arr2[0]+'}');
   end;
   result := '['+js.ToString.Replace('}{','},{')+']';
   js.DisposeOf;
end;


function Combobox(JSON,Field :String) :String;
var
   JSONValue  : TJSONValue;
   JSONArray  : TJSONArray;
   JSONObject : TJSONObject;
   I          : Integer;
   str        : TStringBuilder;
begin


   JSONValue := TJSONObject.ParseJSONValue(JSON);

   if JSONValue is TJSONObject then
      JSONValue := TJSONObject.ParseJSONValue('['+JSONValue.ToJSON+']');

   if JSONValue is TJSONArray then begin
      JSONArray := TJSONObject.ParseJSONValue(JSONValue.ToJSON) as TJSONArray;
      str := TStringBuilder.Create;
      for I := 0 to JSONArray.Count - 1 do begin
         JSONObject := TJSONObject.ParseJSONValue(JSONArray.Items[i].ToJSON) as TJSONObject;
         str.Append(JSONObject.Value(Field)+',');

      end;
      Result := str.ToString.Replace(',,',',');
      str.DisposeOf;
   end else result := '';

end;

{ TListBoxHelper }

function TListBoxHelper.ID: String;
begin
   result := '{"_id":"'+InttoStr(Self.Tag + 1)+'"}';
end;

procedure TListBoxHelper.Open(JSON, Text, Detail: String);
var
   JSONValue  : TJSONValue;
   JSONArray  : TJSONArray;
   JSONObject : TJSONObject;
   ListBox    : TListBoxItem;
   I          : Integer;
begin
   JSON := JX(JSON);

   JSONValue := TJSONObject.ParseJSONValue(JSON);

   if JSONValue is TJSONObject then
      JSONValue := TJSONObject.ParseJSONValue('['+JSONValue.ToJSON+']');

   Self.BeginUpdate;
   Self.Items.Clear;
   if JSONValue is TJSONArray then begin
      JSONArray := TJSONObject.ParseJSONValue(JSONValue.ToJSON) as TJSONArray;
      Self.Tag := 0;
      for I := 0 to JSONArray.Count - 1 do begin
         JSONObject := TJSONObject.ParseJSONValue(JSONArray.Items[i].ToJSON) as TJSONObject;

         ListBox := TListBoxItem.Create(Self);
         ListBox.ItemData.Text := JSONObject.ToJSON;
         ListBox.TextSettings.FontColor := TAlphaColors.Null;
         ListBox.Hint:= JSONObject.ToJSON;
         ListBox.Parent := Self;
         ListBox.StyleLookup := 'listboxitembottomdetail';
         ListBox.StyledSettings := [];
         ListBox.Height := 50;
         ListBox.Size.PlatformDefault := False;
         ListBox.AddLabel(JSONObject.Value(Text));
         ListBox.AddLabel(JSONObject.Value(Detail),12);

         if Self.Tag < StrToInt(JSONObject.Value('_id')) then
            Self.Tag := StrToInt(JSONObject.Value('_id'));

         Self.AddObject(ListBox);
      end;
   end;
   JSONValue.DisposeOf;
   JSONArray.DisposeOf;
   Self.EndUpdate;
end;

{ TJSONObjectHelper }

function TJSONObjectHelper.GetBoolean(value: String): Boolean;
begin
   if Self.GetValue(value) <> nil  then
      if Self.GetValue(value).Value <> '' then
         result := StrToBool(Self.GetValue(value).Value)
      else
         result := false
   else
      result := False;
end;

function TJSONObjectHelper.GetFloat(value: String): Extended;
begin
   if Self.GetValue(value) <> nil  then
      if Self.GetValue(value).Value <> '' then
         result := StrToFloat(Self.GetValue(value).Value)
      else
         result :=0
   else
      result := 0;
end;

function TJSONObjectHelper.GetInteger(value: String): Integer;
begin
   if Self.GetValue(value) <> nil  then
      if Self.GetString(value) <> '' then
         result := StrToInt(Self.GetString(value))
      else
         result := 0
   else
      result := 0;

end;

function TJSONObjectHelper.GetString(value: String): String;
begin
   if Self.GetValue(value) <> nil  then
      result := Self.GetValue(value).Value
   else
      result := '';

end;

function TJSONObjectHelper.GetStringData(value: String): String;
begin
   if Self.GetValue(value) <> nil then

      Result := Copy(Self.GetString(value),7,2) + '/' +
                Copy(Self.GetString(value),5,2) + '/' +
              Copy(Self.GetString(value),1,4)
   else
      Result := '';

end;

function TJSONObjectHelper.GetURL(Categoria, SubCategoria,
  Produto: String): String;
var
   JSONCategoria :TJSONObject;
   JSONSubCategoria :TJSONArray;
   StrCategoria :String;
   JSONVAlue :TJSONValue;
   I : Integer;
   Link : TArray<String>;

begin

   JSONCategoria := Self.GetValue<TJSONObject>(AnsiLowerCase(Categoria)) as TJSONObject;

   JSONSubCategoria := JSONCategoria.GetValue<TJSONArray>(AnsiLowerCase(SubCategoria)) as TJSONArray;

   Link := TRegEx.Split(JSONSubCategoria.ToString,Produto+' =');

   if TRegEx.Matches(JSONSubCategoria.ToString,Produto+' =').Count = 1 then begin
       Link := TRegEx.Split(Link[1],'"');
       Result :=  Link[0].Replace('\/','/').Replace('"','') ;
   end else Result := '';

//   JSONCategoria.DisposeOf;
//   JSONSubCategoria.DisposeOf;
end;

function TJSONObjectHelper.Value(Name: String): String;
begin
   if Self.GetValue(Name) <> nil then
      Result := Self.GetValue(Name).Value
   else
      Result := '';
end;

{ TControlHelper }
function TControlHelper.JSON: String;
var
   I : Integer;
   js :TStringBuilder;
   float :Real;
begin
   js := TStringBuilder.Create;

   for I := 0 to Self.ComponentCount - 1 do begin

      if (Self.Components[i] is TEdit) then begin
         if (Self.Components[i] as TEdit).Tag = 0 then
            js.Append('"'+(Self.Components[i] as TEdit).FieldName+'":"'+(Self.Components[i] as TEdit).Text+'",')
         else begin
            try
             float := strtoFloat((Self.Components[i] as TEdit).Text);
              js.Append('"'+(Self.Components[i] as TEdit).FieldName+'":'+ FormatFloat('0.00',float).Replace(',','.')+',')
            except
               Showmessage('Informe um valor válido');
               abort;
            end;
         end;

         if ((Self.Components[i] as TEdit).FieldName = '_id') then
            Self.Tag := StrToInt((Self.Components[i] as TEdit).Text);

      end

      else if (Self.Components[i] is TDateEdit) then
         js.Append('"'+(Self.Components[i] as TDateEdit).FieldName+'":"'+(Self.Components[i] as TDateEdit).Text+'",')

      else if (Self.Components[i] is TNumberBox)  then
         js.Append('"'+(Self.Components[i] as TNumberBox).FieldName+'":'+ FormatFloat('0.00',(Self.Components[i] as TNumberBox).Value).Replace(',','.')+',')

      else if (Self.Components[i] is TCheckBox) then begin
         if (Self.Components[i] as TCheckBox).IsChecked then
           js.Append('"'+(Self.Components[i] as TCheckBox).FieldName+'":"Sim",')
         else
           js.Append('"'+(Self.Components[i] as TCheckBox).FieldName+'":"Não",')
      end

      else if (Self.Components[i] is TMemo) then
         js.Append('"'+(Self.Components[i] as TMemo).FieldName+'":"'+(Self.Components[i] as TMemo).Text+'",')

      else if (Self.Components[i] is TShape) then
         js.Append('"'+(Self.Components[i] as TShape).FieldName+'":"'+(Self.Components[i] as TShape).Hint+'",')

      else if (Self.Components[i] is TComboBox) then
         if (Self.Components[i] as TComboBox).ItemIndex = -1 then
            js.Append('"'+(Self.Components[i] as TComboBox).FieldName+'":"",')
         else
            js.Append('"'+(Self.Components[i] as TComboBox).FieldName+'":"'+(Self.Components[i] as TComboBox).Items[(Self.Components[i] as TComboBox).ItemIndex] +'",')

      else if (Self.Controls[i] is TComboEdit) then
         js.Append('"'+(Self.Components[i] as TComboEdit).FieldName+'":"'+(Self.Components[i] as TComboEdit).Text+'",')

   end;

   if js.ToString <> '' then
      Result := (js.ToString+',').Replace(',,','');

end;

procedure TControlHelper.OnClickShape(Sender: TObject);
begin
   TShape(Sender).OpenDialog;
end;

procedure TControlHelper.OpenFields(JSON: String);
var
   JSONValue :TJSONValue;
   i :Integer;
begin
   JSONValue := TJSONObject.ParseJSONValue(JSON);

   if JSONValue is TJSONObject then begin
      JSONObject := TJSONObject.ParseJSONValue(JSONValue.ToJSON) as TJSONObject;
   end else
      JSONObject := TJSONObject.ParseJSONValue('{}') as TJSONObject;
   Self.BeginUpdate;
   for I := 0 to Self.ComponentCount - 1 do begin
      if (Self.Components[i] is TEdit) then
         Get((Self.Components[i] as TEdit))
      else if (Self.Components[i] is TDateEdit) then
         Get((Self.Components[i] as TDateEdit))
      else if (Self.Components[i] is TCombobox) then
         Get((Self.Components[i] as TCombobox))
      else if (Self.Components[i] is TNumberBox) then
         Get((Self.Components[i] as TNumberBox))
      else if (Self.Components[i] is TShape) then
         Get((Self.Components[i] as TShape))
      else if (Self.Components[i] is TCheckBox) then
        Get((Self.Components[i] as TCheckBox))
   end;
   Self.EndUpdate;

end;

function TControlHelper.AddCheck(Titulo, FieldName: String): TControl;
var
   check :TCheckBox;
begin
   check := TCheckBox.Create(Self);
   check.Parent := Self;
   check.Align := TAlignLayout.Top;
   check.Margins.Top := 22;
   check.Position.X := 232;
   check.Position.Y := 1000;
   check.Size.Width := 113;
   check.Size.Height := 22;
   check.Size.PlatformDefault := False;
   check.StyleName := FieldName;
   check.Text := Titulo
end;

function TControlHelper.AddComboBox(Titulo, FieldName, Itens: String): TControl;
var
   combobox : TComboBox;
   arr1 :TArray<String>;
   I :Integer;
begin
   combobox := TComboBox.Create(Self);
   combobox.Parent := Self;
   combobox.Align := TAlignLayout.Top;
   combobox.Margins.Top := 22;
   combobox.Position.X := 448;
   combobox.Position.Y := 1000;
   combobox.Size.Width := 148;
   combobox.Size.Height := 22;
   combobox.Size.PlatformDefault := False;
   combobox.StyleName := FieldName;

   if Itens <> '' then begin
      arr1 := TRegEx.Split(Itens,',');
      for I := 0 to TRegEx.Matches(Itens,',').Count  do begin
         combobox.Items.Add(arr1[i]);
      end;
   end;

   CreateLabel(combobox,Titulo);

   result := Self;
end;

function TControlHelper.AddDate(Titulo, FieldName: String): TControl;
var
   date :TDateEdit;
begin
   date := TDateEdit.Create(Self);
   date.Parent := Self;
   date.Align := TAlignLayout.Top;
   date.ShowClearButton := True;
   date.Margins.Top := 22;
   date.IsEmpty := True;
   date.Position.X := 448;
   date.Position.Y := 1000;
   date.Size.Width := 148;
   date.Size.Height := 22;
   date.Size.PlatformDefault := False;
   date.StyleName := FieldName;

   {$IF DEFINED(android) or DEFINED(iOS)}
    date.TextSettings.Font.Size := 12;
    date.TextSettings.Font.Style := [TFontStyle.fsBold];
    date.StyledSettings := [];
    date.ShowClearButton := False;
   {$ENDIF}

   CreateLabel(Date,Titulo);

   result := Self;
end;

function TControlHelper.AddEdit(Titulo,FieldName :String;Decimal :Boolean = False) : TControl;
var
   edt :TEdit;
begin
   edt := TEdit.Create(Self);
   edt.Align := TAlignLayout.Top;
   edt.Margins.Top := 20;

   if Decimal then begin
      edt.Tag := 1 ;
      edt.FilterChar := '0123456789,.';
   end;

   edt.ReadOnly := AnsiLowerCase(FieldName) = 'id';

   edt.ReturnKeyType := TReturnKeyType.Next;
   edt.Position.X := 224;
   edt.Position.Y := 1000;
   edt.Size.Width := 161;
   edt.Size.Height := 22;
   edt.Size.PlatformDefault := False;
   edt.Parent := Self;
   edt.StyleName := FieldName;


   {$IF DEFINED(android) or DEFINED(iOS)}
    edt.TextSettings.Font.Size := 12;
    edt.TextSettings.Font.Style := [TFontStyle.fsBold];
    edt.StyledSettings := [];
   {$ENDIF}



   CreateLabel(edt,Titulo);

   result := Self;
end;

function TControlHelper.AddImagem(Titulo, FieldName: String): TControl;
var
   circle :TCircle;
begin
   circle := TCircle.Create(Self);
   circle.Align := TAlignLayout.Top;
   circle.Parent := Self;
   circle.Margins.Top := 20;
   circle.Position.Y := 1000;
   circle.Size.Width := 150;
   circle.Size.Height := 150;
   circle.StyleName := FieldName;
   circle.Fill.Color := TAlphaColors.White;
   circle.OnClick := OnClickShape;
   result := Self;
end;

function TControlHelper.AddNumber(Titulo, FieldName: String): TControl;
var
   num : TNumberBox;
begin
   num := TNumberBox.Create(Self);
   num.Align := TAlignLayout.Top;
   num.Parent := Self;
   num.Margins.Top := 20;
   num.Max := 10000;
   num.ReturnKeyType := TReturnKeyType.Next;
   num.TabOrder   := 0;
   num.Position.X := 224;
   num.Position.Y := 1000;
   num.Size.Width := 161;
   num.Size.Height := 22;
   num.StyleName := FieldName;
   CreateLabel(num,Titulo);
   result := Self;
end;

function TControlHelper.AddText(Text :String; FontSize :Real = 12;
   Bold :Boolean = False; VAlign : TTextAlign  = TTextAlign.Leading): TControl;
var txt :TText;
begin
    txt := TText.Create(Self);
    txt.AutoSize := True;
    //txt.TextSettings := [];
    txt.Position.Y := 500;
    txt.Align := TAlignLayout.Top;
    txt.TextSettings.HorzAlign := TTextAlign.Leading;
    txt.TextSettings.VertAlign := VAlign;

    if VAlign = TTextAlign.Center then begin
       txt.Align  := TAlignLayout.Client;
      txt.AutoSize := False;
    end;

    txt.TextSettings.Font.Family := 'calibri';
    txt.TextSettings.Font.Size := FontSize;

    if Bold then begin
       txt.TextSettings.Font.Style := [TFontStyle.fsBold];
       txt.TextSettings.Font.Family := 'calibrib';
    end;
    txt.Text := Text;
    Self.AddObject(txt);

    result := Self;

end;

function TControlHelper.AddTextCenter(Text :String; FontSize :Real = 12; Bold :Boolean = False;
      Cor :TAlphaColor = TAlphaColors.Darkgray ): TControl;
var
   txt :TText;
begin
   txt := TText.Create(Self);
    //txt.TextSettings := [];
   txt.Align := TAlignLayout.Client;
   txt.TextSettings.HorzAlign := TTextAlign.Center;
   txt.TextSettings.VertAlign := TTextAlign.Center;
   txt.TextSettings.Font.Family := 'calibri';
   txt.TextSettings.Font.Size := FontSize;

   if Bold then begin
      txt.TextSettings.Font.Style := [TFontStyle.fsBold];
      txt.TextSettings.Font.Family := 'calibrib';
   end;
   txt.TextSettings.FontColor := Cor;
   txt.Text := Text;
   Self.AddObject(txt);

   result := Self;

end;

function TControlHelper.AddTextRight(Text: String; FontSize: Real;
  Bold: Boolean): TControl;
  var txt :TText;
begin
    txt := TText.Create(Self);
    //txt.TextSettings := [];
    txt.Align := TAlignLayout.Client;
    txt.TextSettings.HorzAlign := TTextAlign.Trailing;
    txt.TextSettings.VertAlign := TTextAlign.Center;
    txt.TextSettings.Font.Family := 'calibri';
    txt.TextSettings.Font.Size := FontSize;

    if Bold then begin
       txt.TextSettings.Font.Style := [TFontStyle.fsBold];
       txt.TextSettings.Font.Family := 'calibrib';
    end;
    txt.Text := Text;
    Self.AddObject(txt);

    result := Self;
end;

procedure TControlHelper.ClearFields;
begin
   OpenFields('');
end;

procedure TControlHelper.ClearItens;
var I :Integer;
begin
   Self.BeginUpdate;
   for I := Self.ComponentCount - 1 downto 1 do begin
      Self.Components[i].DisposeOf;
   end;
   Self.EndUpdate;
end;

function TControlHelper.FieldName: String;
var id :String;
begin
   id := AnsiLowerCase(Self.StyleName);
   if id = 'id' then id := '_id';
   Result := id ;
end;

function TControlHelper.ID: String;
begin
   Self.JSON;
   result := IntToStr(Self.Tag) ;
end;

{ TCheckBoxHelper }

function TCheckBoxHelper.FieldName: String;
begin
    Result := AnsiLowerCase(Self.StyleName);
end;

{ TStringGridHelper }

procedure TStringGridHelper.AutoAjuste(Column: integer);
var
   i: integer;
   L, LMax : Single;
begin
   LMax := 0;
   for i := 0 to (Self.RowCount - 1) do begin
     L := Self.Canvas.TextWidth(Self.Cells[Column, i]);
     if (L > LMax)  then
       LMax := L;
   end;

   if LMax < 50 then LMax := 50;

   Self.Columns[Column].Width := LMax + 10;
end;

procedure TStringGridHelper.Open(JSON, Names: String);
var
   Column :TColumn;
   Header : TDictionary<String,integer>;
   JSONValue : TJSONValue;
   JSONArray : TJSONArray;
   JSONObject : TJSONObject;
   Loop1, Loop2 : Integer;
begin

   Header := TDictionary<String,integer>.Create;

   if Names = '' then
      JSON := JX(JSON);

   try
      JSONValue := TJSONObject.ParseJSONValue(JSON);
      if (JSONValue is TJSONObject) then begin
        FreeAndNil(JSONValue);
        JSONValue := TJSONObject.ParseJSONValue('['+JSON+']');
      end;

      if (JSONValue is TJSONArray) then begin
         try
            JSONArray := TJsonObject.ParseJSONValue(JSONValue.ToJSON) as TJSONArray;

            Self.ClearColumns;
            Self.RowCount := JSONArray.Count;

            for Loop1 := 0 to JSONArray.Count - 1 do begin
               try
                  JSONObject := TJSONObject.ParseJSONValue(JsonArray.Items[Loop1].ToJSON) as TJSONObject;
                  for Loop2 := 0 to JSONObject.count-1 do begin
                     if not Header.ContainsKey(JsonObject.Pairs[Loop2].JsonString.Value.Replace('"','')) then begin
                        Column := TColumn.Create(Self);
                        Column.Header := JsonObject.Pairs[Loop2].JsonString.Value.Replace('"','');
                        Column.Parent := Self;

                        Header.Add(JsonObject.Pairs[Loop2].JsonString.Value, Header.Count + 1 );
                     end;

                     try
                        Self.Cells[Header.Items[JsonObject.Pairs[Loop2].JsonString.Value]-1,Loop1] := JsonObject.Pairs[Loop2].JsonValue.Value;
                     except

                     end;
                  end;
               finally
                 jsonObject.Free;
               end;
            end;
         finally
            JSONArray.Free;
         end;
      end;

   finally
     JSONValue.Free;
   end;

   for Loop1 := 0 to Self.ColumnCount - 1 do
      AutoAjuste(Loop1);
   Header.DisposeOf;

end;

{ TShapeHelper }

procedure TShapeHelper.LoadJSON(JSArray, Nome: String);
var
   JSONArray : TJSONArray;
   FileStream: TFileStream;
   Stream : TStream;
   buf: TBytes;
begin

   JSONArray := TJSONObject.ParseJSONValue(JSArray) as TJSONArray;
   FileStream := TFileStream.Create(TPath.Combine(GetCurrentDir,Nome), fmCreate);

   Stream := TDBXJSONTools.JSONToStream(jsonArray);
   try
      SetLength(buf, Stream.Size);
      Stream.Position := 0;
      Stream.ReadBuffer(buf[0], Stream.Size);
      Self.Fill.Kind := TBrushKind.Bitmap;
      Self.Stroke.Kind := TBrushKind.None;
      Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
      Self.Fill.Bitmap.Bitmap.LoadFromStream(Stream);
      FileStream.WriteBuffer(buf[0], Stream.Size);
   finally
      Stream.DisposeOf;
      FileStream.DisposeOf;
      JSONArray.DisposeOf;
   end;

end;



procedure TShapeHelper.Bitmap(base64: string);
var
   Input: TStringStream;
   Output: TBytesStream;
begin
   Input := TStringStream.Create(base64, TEncoding.ASCII);
   try
      Output := TBytesStream.Create;
      try
        Soap.EncdDecd.DecodeStream(Input, Output);
        Output.Position := 0;
        try
          Self.Fill.Bitmap.Bitmap.LoadFromStream(Output);
        except
         raise;
        end;
      finally
        Output.Free;
      end;
   finally
      Input.Free;
   end;
end;



function TShapeHelper.Base64: String;
var
   Input: TBytesStream;
   Output: TStringStream;
   F: TextFile;
begin
   Input := TBytesStream.Create;
   try
      Self.Fill.Bitmap.Bitmap.SaveToStream(Input);
      Input.Position := 0;
      Output := TStringStream.Create('', TEncoding.ASCII);
      try
         Soap.EncdDecd.EncodeStream(Input, Output);
         Result := Output.DataString;

        //Criar um ficheiro txt com o codigo base 64  apenas para exemplo
         AssignFile(f,'imagem.txt');
         Rewrite(f); //abre o arquivo para escrita
         Writeln(f,Result);
         Closefile(f);

      finally
         Output.Free;
      end;
   finally
      Input.Free;
   end;

end;

function TShapeHelper.JSArray: String;
var
   Arquivo : string;
   ArquivoStream: TFileStream;
   JSONArray : TJSONArray;
   ByteArray: array of Byte;
begin
   try
      Arquivo := TPath.Combine(TPath.GetDocumentsPath, 'tmpImg.jpg');

      Self.Fill.Bitmap.Bitmap.SaveToFile(Arquivo);

      ArquivoStream := TFileStream.Create(Arquivo, fmOpenRead);
      JSONArray := TDBXJSONTools.StreamToJSON(ArquivoStream, 0, ArquivoStream.Size);
      ArquivoStream.Position := 0;
      SetLength(ByteArray, ArquivoStream.Size);
      ArquivoStream.Read(ByteArray[0], ArquivoStream.Size);
      Result := JSONArray.toJSON;

   finally
      ArquivoStream.Free;
      JSONArray.Free;

      //DeleteFile(Arquivo);
   end;

end;

procedure TShapeHelper.OpenJSONArray(Value: String);
var
   JSONValue : TJSONValue;
   JSONArray : TJSONArray;
   Stream : TStream;
   buf: TBytes;
begin

   Value := Value.Replace('"','');

   if Value <> '' then begin
      JSONValue := TJSONObject.ParseJSONValue(JSArray);

      if JSONValue is TJSONArray then begin
         JSONArray := TJSONObject.ParseJSONValue(JSArray) as TJSONArray;
         Stream := TDBXJSONTools.JSONToStream(jsonArray);
         try
           SetLength(buf, Stream.Size);
           Stream.Position := 0;
           Stream.ReadBuffer(buf[0], Stream.Size);
           Self.Fill.Kind := TBrushKind.Bitmap;
           Self.Stroke.Kind := TBrushKind.None;
           Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
           Self.Fill.Bitmap.Bitmap.LoadFromStream(Stream);
         finally
           Stream.DisposeOf;
           JSONArray.DisposeOf;
         end;
      end;
      JSONValue.DisposeOf;
   end;

end;

function TShapeHelper.Base64(y, x: Integer): String;
var
   bmpA, bmpB: TBitmap;
   src, trg: TRectF;
begin
   bmpA := nil;
   bmpB := nil;
   try
      bmpA := TBitmap.Create;
      bmpA := (Self.Fill.Bitmap.Bitmap);

      bmpB:= TBitmap.Create;
      bmpB.SetSize(x, y);

      src := RectF(0, 0, bmpA.Width, bmpA.Height);
      trg := RectF(0, 0, x, y);

      bmpB.Canvas.BeginScene;
      bmpB.Canvas.DrawBitmap(bmpA, src, trg, 1);
      bmpB.Canvas.EndScene;
   finally
      Self.Fill.Bitmap.Bitmap := bmpB;
      Result := Self.Base64;
   end;
end;

function TShapeHelper.TamanhoJSA(y, x: Integer): String;
var
   bmpA, bmpB: TBitmap;
   src, trg: TRectF;
begin
   bmpA := nil;
   bmpB := nil;
   try
      bmpA := TBitmap.Create;
      bmpA := (Self.Fill.Bitmap.Bitmap);

      bmpB:= TBitmap.Create;
      bmpB.SetSize(x, y);

      src := RectF(0, 0, bmpA.Width, bmpA.Height);
      trg := RectF(0, 0, x, y);

      bmpB.Canvas.BeginScene;
      bmpB.Canvas.DrawBitmap(bmpA, src, trg, 1);
      bmpB.Canvas.EndScene;
   finally
      Self.Fill.Bitmap.Bitmap := bmpB;
      Result := Self.JSArray;
   end;

end;



procedure TShapeHelper.ImagemByName(Nome: String);
var
   Item: TCustomBitmapItem;
   Size: TSize;
   i :Integer;
begin

   for I := 0 to Container.Imagens.Source.Count - 1 do begin
      if Container.Imagens.Source[I].Name = Nome then begin
         Container.Imagens.BitmapItemByName(Nome, Item, Size);
         Self.Fill.Kind := TBrushKind.Bitmap;
         Self.Stroke.Kind := TBrushKind.None;
         Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
         Self.Fill.Bitmap.Bitmap := Item.MultiResBitmap.Bitmaps[1.0];
         Self.Tag := 1;
      end;
   end;

end;

procedure TShapeHelper.LoadJSON(JSArray: String);
var
   JSONValue : TJSONValue;
   JSONArray : TJSONArray;
   Stream : TStream;
   buf: TBytes;
begin

   JSArray := JSArray.Replace('"','');

   if JSArray <> '' then begin
      JSONValue := TJSONObject.ParseJSONValue(JSArray);

      if JSONValue is TJSONArray then begin
         JSONArray := TJSONObject.ParseJSONValue(JSArray) as TJSONArray;
         Stream := TDBXJSONTools.JSONToStream(jsonArray);
         try
           SetLength(buf, Stream.Size);
           Stream.Position := 0;
           Stream.ReadBuffer(buf[0], Stream.Size);
           Self.Fill.Kind := TBrushKind.Bitmap;
           Self.Stroke.Kind := TBrushKind.None;
           Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
           Self.Fill.Bitmap.Bitmap.LoadFromStream(Stream);
         finally
           Stream.DisposeOf;
           JSONArray.DisposeOf;
         end;
      end;

      JSONValue.DisposeOf;
   end else begin
      Self.Fill.Bitmap.Bitmap := Nil;
      Self.Fill.Kind := TBrushKind.Solid;
      Self.Fill.Color := TAlphaColors.White;
      Self.ImagemByName('sem-imagem');
   end;

end;

procedure TShapeHelper.LoadUrl(url: String);
var
   MyFile: TFileStream;
   NetHTTPClient : TNetHTTPClient;
   ImgUrl : String;
   RStream :TRectangle;
begin
   ImgUrl := (url).Replace('.png','.jpg');

  // showmessage(ImgUrl);
   if ImgUrl <> '' then begin
      Self.BeginUpdate;
      Self.Fill.Kind := TBrushKind.Bitmap;
      Self.Stroke.Kind := TBrushKind.None;
      Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
      if not FileExists(TPath.Combine(TPath.GetDownloadsPath,TPath.GetFileName(ImgUrl))) then begin
         NetHTTPClient := TNetHTTPClient.Create(nil);
         NetHTTPClient.Asynchronous := False;
         NetHTTPClient.ConnectionTimeout := 60000;
         NetHTTPClient.ResponseTimeout := 60000;
         NetHTTPClient.HandleRedirects := True;
         NetHTTPClient.AllowCookies := True;
         NetHTTPClient.UserAgent := 'Embarcadero URI Client/1.0';

         try
            MyFile := TFileStream.Create(TPath.Combine(TPath.GetDownloadsPath,TPath.GetFileName(ImgUrl)),
                                   fmCreate);
         except
            MyFile := TFileStream.Create(TPath.Combine(TPath.GetDownloadsPath,
                    RightStr(ImgUrl,10)+'.jpg'), fmCreate);
         end;

         TThread.CreateAnonymousThread(
         procedure () begin
            try
               NetHTTPClient.Get(url, MyFile);
            finally
               NetHTTPClient.DisposeOf;
            end;

            TThread.Synchronize (TThread.CurrentThread,
            procedure () begin
               try
                  //Showmessage(IntToStr(
//                  if MyFile.Size < 100000 then
                     Self.Fill.Bitmap.Bitmap.LoadFromStream(MyFile)
//                  else
//                     DeleteFile(TPath.Combine(TPath.GetDownloadsPath,TPath.GetFileName(ImgUrl)));
//               var tmpImagem : TBitmap;
//                tmpImagem := TBitmap.Create;
//                tmpImagem := ReduzirImagem(Self.Fill.Bitmap.Bitmap, 300, 300);
//
//                try
//                  tmpImagem.SaveToFile(
//                  TPath.Combine(TPath.GetTempPath, RightStr(ImgUrl,10)+'_.jpg'));
//
//                  TPath.Combine(TPath.GetTempPath, Ret.Name +'.jpg'));
//                finally
//                   Self.Fill.Bitmap.Bitmap.LoadFromFile(TPath.Combine(TPath.GetTempPath, RightStr(ImgUrl,10)+'_.jpg'));
//
//                  tmpImagem.DisposeOf;
//                end;


                //ReduzirImagem()

               except
                  Self.Fill.Bitmap.Bitmap.LoadFromFile(
                  TPath.Combine(TPath.GetDownloadsPath,TPath.GetFileName(ImgUrl)));

               end;

               Self.EndUpdate;
               MyFile.DisposeOf;
            end);
         end).Start;

      end else begin

         TThread.CreateAnonymousThread(
         procedure ()
         begin
            try
                Self.Fill.Bitmap.Bitmap.LoadFromFile(TPath.Combine(TPath.GetDownloadsPath,TPath.GetFileName(ImgUrl)));

            except
                Self.ImagemByName('logo');
            end;
            Self.EndUpdate;
         end).Start;

      end;
   end;
end;

procedure TShapeHelper.LogoByName(Nome: String);
var
   Item: TCustomBitmapItem;
   Size: TSize;
   i :Integer;
begin

   for I := 0 to Container.Logos.Source.Count - 1 do begin
      if Container.Logos.Source[I].Name = Nome then begin
         Container.Logos.BitmapItemByName(Nome, Item, Size);
         Self.Fill.Kind := TBrushKind.Bitmap;
         Self.Stroke.Kind := TBrushKind.None;
         Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
         Self.Fill.Bitmap.Bitmap := Item.MultiResBitmap.Bitmaps[1.0];
         Self.Tag := 1;
      end;
   end;

end;

procedure TShapeHelper.OfertasClick(Sender: TObject);
var
   cache :TArray<string>;
begin
//
   cache := TRegEx.Split(TText(Sender).Hint,'-');
   FormMain.CacheProdutos(cache[0],cache[1]);

end;

procedure TShapeHelper.OpenDialog;
var
   OpenDialog : TOpenDialog;
   Arquivo : string;
   ArquivoStream: TFileStream;
   JSONArray : TJSONArray;
   ByteArray: array of Byte;
begin
   Self.Hint := '';
   try
      OpenDialog := TOpenDialog.Create(nil);
      OpenDialog.InitialDir := TPath.GetPicturesPath;
      OpenDialog.Filter := 'JPG|*.jpg|BMP |*.bmp|PNG |*.png';
      if OpenDialog.Execute then begin
         Self.Fill.Bitmap.Bitmap.LoadFromFile(OpenDialog.FileName);
         Self.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
         Self.Fill.Kind := TBrushKind.Bitmap;
         try
            Arquivo := OpenDialog.FileName;
            ArquivoStream := TFileStream.Create(Arquivo, fmOpenRead);
            JSONArray := TDBXJSONTools.StreamToJSON(ArquivoStream, 0, ArquivoStream.Size);
            ArquivoStream.Position := 0;
            SetLength(ByteArray, ArquivoStream.Size);
            ArquivoStream.Read(ByteArray[0], ArquivoStream.Size);
            Self.Hint := JSONArray.toJSON;
         finally
            ArquivoStream.Free;
            JSONArray.Free;
         end;
         Self.Tag := 1;
      end;
   finally
      OpenDialog.Free;
   end;
end;

procedure TShapeHelper.RSlideClick(Sender: TObject);
begin
   FormMain.SearchBox5.Text := 'Destaque: '+ TRectangle(Sender).Hint +' ';
end;

procedure TShapeHelper.Slides;
var
   I,L :Integer;
   RSlide : TRectangle;
   Animacao : TFloatAnimation;
begin

   FSlide := TLayout.Create(Self);
   FSlide.Position.X := 0;
   FSlide.Position.Y := 0;
   FSlide.Height := Self.Height;
   Self.AddObject(FSlide);

   FormMain.ListSlideLoja.Clear;

   L := Container.tabUsers.RecordCount-1;
   FSlide.Width := L * Self.Width;

   TThread.CreateAnonymousThread(procedure() begin
      Container.tabUsers.BeginBatch;
      Container.tabUsers.First;
      while not Container.tabUsers.Eof do begin
         RSlide := TRectangle.Create(FSlide);
         RSlide.Align := TAlignLayout.Left;
         RSlide.Width := Self.Width;
         RSlide.Fill.Kind := TBrushKind.Bitmap;
         RSlide.Stroke.Kind := TBrushKind.None;
         RSlide.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
         if Trim(Container.tabUsers.FieldByName('logo').AsString) <> '' then
            RSlide.LoadUrl(Container.tabUsers.FieldByName('logo').AsString)
         else
            RSlide.ImagemByName('logo');

         FSlide.AddObject(RSlide);

         FormMain.ListSlideLoja.Add(RSlide);
         Container.tabUsers.Next;
      end;
      Container.tabUsers.EndBatch;

      TThread.Synchronize (TThread.CurrentThread,
         procedure () begin
            Animacao := TFloatAnimation.Create(FSlide);
            Animacao.Delay := 3;
            Animacao.Duration := 1;
            Animacao.OnFinish := SlidesAnimacaoFinish;
            Animacao.PropertyName := 'Position.X';
            Animacao.StartValue := 0;
            Animacao.StartFromCurrent := True;
            Animacao.StopValue := 0;
            Animacao.Tag := 0;

            FSlide.AddObject(Animacao);
            Animacao.Start;
         end);
   end).Start;


end;



procedure TShapeHelper.SlidesLoja;
var
   I,L :Integer;
   RSlide,IMG,R : TRectangle;
   Animacao : TFloatAnimation;
   Blur:TPixelateEffect;
   T :TText;

begin

   FSlide := TLayout.Create(Self);
   FSlide.Position.X := 0;
   FSlide.Position.Y := 0;
   FSlide.Height := Self.Height;
   Self.AddObject(FSlide);

   FormMain.ListSlideLoja.Clear;

   if (Container.tabSlidesLoja.Active) then begin
       Container.tabSlidesLoja.Open;
       Container.tabSlidesLoja.Filtered := False;
       Container.tabSlidesLoja.Filter :=  'destaque = True';
       Container.tabSlidesLoja.Filtered := True;

       L := Container.tabSlidesLoja.RecordCount -1;
       FSlide.Width := L * Self.Width;

       TThread.CreateAnonymousThread(procedure() begin
         Container.tabSlidesLoja.BeginBatch;
         Container.tabSlidesLoja.First;
         while not Container.tabSlidesLoja.Eof do begin

            RSlide := TRectangle.Create(FSlide);
            RSlide.Align := TAlignLayout.Left;
            RSlide.Width := Self.Width;
            RSlide.Fill.Kind := TBrushKind.Bitmap;
            RSlide.Stroke.Kind := TBrushKind.None;
            RSlide.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
            RSlide.Hint := Container.tabSlidesLoja.FieldByName('_id').AsString;

            //RSlide.OnClick :=  RSlideClick;
            if Container.tabCacheIMG.Locate('_id',Container.tabSlidesLoja.FieldByName('_id').AsString,[]) then begin
               IMG := TRectangle.Create(RSlide);
               IMG.Align := TAlignLayout.Client;
               IMG.LoadJSON(Container.tabCacheIMG.Fields[4].AsString);
               RSlide.AddObject(IMG);
            end;

            FSlide.AddObject(RSlide);
            FormMain.ListSlideLoja.Add(RSlide);
            Container.tabSlidesLoja.Next;
         end;
         Container.tabSlidesLoja.EndBatch;

//         TThread.Synchronize (TThread.CurrentThread,
//           procedure () begin
//
//         end);
      end).Start;
   end;



end;

procedure TShapeHelper.SlidesLojaAnimacaoFinish(Sender: TObject);
begin

end;

procedure TShapeHelper.SlidesAnimacaoFinish(Sender: TObject);
begin

end;

procedure TShapeHelper.Text(Texto :String;FontSize :Real = 10);
var
   Arr,ArrFont,ArrReplace :TArray<string>;
   fontReplace :String;
   I  : Integer;
   T,T2  : TText;
   FL  : TFlowLayout;
   L,FFundo  : TLayout;
   B : TSpeedButton;
   Font, Criar : Boolean;
   FSize  : Integer;

   RWhatsApp :TRectangle;
begin
   if Texto <> '' then begin

      Font := False;

      Texto := (StringReplace(Texto,#$D#$A,' <br>',[rfReplaceAll]));
      Texto := (StringReplace(Texto,#$A,' <br>',[rfReplaceAll]));

      Self.BeginUpdate;
      Self.HitTest := False;
      Self.ClipChildren := True;
      for I := Self.ComponentCount - 1  downto 0 do
        Self.Components[i].DisposeOf;

      FL := TFlowLayout.Create(Self);
      Self.AddObject(FL);
      FL.Align := TAlignLayout.Client;
      FL.HitTest := False;
      FL.ClipChildren := True;
      Arr := TRegEx.Split(texto,' ');
      for i := 0 to TRegEx.Matches(texto,' ').Count do begin
         Criar := True;

         FontReplace := '';
         if AnsiContainsText(arr[i],'<p>') then begin
            L := TLayout.Create(FL);
            L.Width := 2000;
            L.Height := 16;
            Fl.AddObject(L);
         end;

         if AnsiContainsText(arr[i],'<br>') then begin
            L := TLayout.Create(FL);
            L.Width := 2000;
            L.Height := 2;
            Fl.AddObject(L);
         end;

         if AnsiContainsText(arr[i],'<ofertas>') then begin
            FFundo := TLayout.Create(FL);
            FFundo.Width := 100;
            FFundo.Height := 22;
            FFundo.Margins.Top := 4;
            FL.AddObject(FFundo);


            B := TSpeedButton.Create(FFundo);
            B.Hint := arr[i]
                       .Replace('<red>','')
                       .Replace('<yellow>','')
                       .Replace('<blue>','')
                       .Replace('<green>','')
                       .Replace('<r>','')
                       .Replace('<s>','')
                       .Replace('<b>','')
                       .Replace('<i>','')
                       .Replace('<br>','')
                       .Replace('<p>','')
                       .Replace('<whatsapp>','')
                       .Replace('<ofertas>','')
                       .Replace(fontReplace,'')
                       .Replace('</font>','');


            B.Align := TAlignLayout.Client;
            B.Size.PlatformDefault := False;
            B.OnClick := OfertasClick;
            B.StyleLookup := 'listitembutton';
            B.TintColor := TAlphaColors.White;
            B.Text := '';
            FFundo.AddObject(B);


            RWhatsApp := TRectangle.Create(B);
            RWhatsApp.Align := TAlignLayout.Left;
            RWhatsApp.Width := 24;
            RWhatsApp.Margins.Top := 2;
            RWhatsApp.Margins.Bottom := 2;
            RWhatsApp.Height := 24;
            RWhatsApp.ImagemByName('ofertas48');
            RWhatsApp.HitTest := False;
            B.AddObject(RWhatsApp);

            T2 := TText.Create(B);
            T2.Text := 'Catálogo';
            T2.Align := TAlignLayout.Client;
            T2.Margins.Left := 2;
            if Self.Fill.Color = TAlphaColors.White then
               T2.TextSettings.FontColor := TAlphaColors.Black
            else
               T2.TextSettings.FontColor := TAlphaColors.White;

            T2.TextSettings.HorzAlign := TTextAlign.Leading;
            T2.TextSettings.VertAlign := TTextAlign.Center;
            T2.TextSettings.Font.Size := 12 ;
            T2.TextSettings.Font.Family := 'calibri';
            T2.HitTest := False;
            T2.TextSettings.Font.Style := [];

            B.AddObject(T2);
            Criar := False;
         end;

         if AnsiContainsText(arr[i],'<whatsapp>') then begin
            FFundo := TLayout.Create(FL);
            FFundo.Width := 26;
            FFundo.Margins.Top := 4;
            FFundo.Height := 22;
            FL.AddObject(FFundo);

            B := TSpeedButton.Create(FFundo);
            B.Hint := arr[i]
                       .Replace('<red>','')
                       .Replace('<yellow>','')
                       .Replace('<blue>','')
                       .Replace('<green>','')
                       .Replace('<r>','')
                       .Replace('<s>','')
                       .Replace('<b>','')
                       .Replace('<i>','')
                       .Replace('<br>','')
                       .Replace('<p>','')
                       .Replace('<whatsapp>','')
                       .Replace('<ofertas>','')
                       .Replace(fontReplace,'')
                       .Replace('</font>','');


            B.Align := TAlignLayout.Client;
            B.Size.PlatformDefault := False;
            B.OnClick := WhatsAppClick;
            B.StyleLookup := 'listitembutton';
            B.TintColor := TAlphaColors.White;
            B.Text := '';
            FFundo.AddObject(B);


            RWhatsApp := TRectangle.Create(B);
            RWhatsApp.Align := TAlignLayout.Left;
            RWhatsApp.Width := 24;
            RWhatsApp.Height := 24;
            RWhatsApp.ImagemByName('whatsapp48');
            RWhatsApp.HitTest := False;
            B.AddObject(RWhatsApp);

            T2 := TText.Create(B);
            T2.Text := '';//'Fale Conosco';
            T2.Align := TAlignLayout.Client;
            T2.Margins.Left := 2;
            if Self.Fill.Color = TAlphaColors.White then
               T2.TextSettings.FontColor := TAlphaColors.Black
            else
               T2.TextSettings.FontColor := TAlphaColors.White;

            T2.TextSettings.HorzAlign := TTextAlign.Leading;
            T2.TextSettings.VertAlign := TTextAlign.Center;
            T2.TextSettings.Font.Size := 12 ;
            T2.TextSettings.Font.Family := 'calibri';
            T2.HitTest := False;
            T2.TextSettings.Font.Style := [];

            B.AddObject(T2);
            Criar := False;
         end;

         if Criar then begin

         T := TText.Create(FL);

         T.Text := arr[i];

         if Self.Fill.Color = TAlphaColors.White then
            T.TextSettings.FontColor := TAlphaColors.Black
         else
            T.TextSettings.FontColor := TAlphaColors.White;

         T.TextSettings.Font.Size := FontSize ;
         T.TextSettings.Font.Family := 'calibri';
         T.AutoSize := True;
         T.HitTest := False;

         T.TextSettings.Font.Style := [];

         if AnsiContainsText(arr[i],'<b>') then begin
            T.TextSettings.Font.Style := T.TextSettings.Font.Style + [TFontStyle.fsBold];
            T.TextSettings.Font.Family := 'calibrib';
         end;
         if AnsiContainsText(arr[i],'<i>') then
            T.TextSettings.Font.Style := T.TextSettings.Font.Style + [TFontStyle.fsItalic];

         if AnsiContainsText(arr[i],'<s>') then
            T.TextSettings.Font.Style := T.TextSettings.Font.Style + [TFontStyle.fsUnderline];

         if AnsiContainsText(arr[i],'<r>') then
            T.TextSettings.Font.Style := T.TextSettings.Font.Style + [TFontStyle.fsStrikeOut];

         if AnsiContainsText(arr[i],'www.') then begin
            T.TextSettings.FontColor := TAlphaColors.Steelblue;
            T.Cursor := crHandPoint;
            T.OnClick := URLClick;
         end;

         if AnsiContainsText(arr[i],'<red>') then
            T.TextSettings.FontColor := TAlphaColors.Red
         else if AnsiContainsText(arr[i],'<green>') then
            T.TextSettings.FontColor := TAlphaColors.Green
         else if AnsiContainsText(arr[i],'<white>') then
            T.TextSettings.FontColor := TAlphaColors.White
         else if AnsiContainsText(arr[i],'<black>') then
            T.TextSettings.FontColor := TAlphaColors.Black

         else if AnsiContainsText(arr[i],'<yellow>') then
            T.TextSettings.FontColor := TAlphaColors.Yellow
         else if AnsiContainsText(arr[i],'<blue>') then
            T.TextSettings.FontColor := TAlphaColors.Cornflowerblue;

         if AnsiContainsText(arr[i],'<font=') then begin
            Font := True;
            ArrFont := TRegEx.Split(arr[i],'<font=');
            ArrReplace := TRegEx.Split(ArrFont[1],'>');
            fontReplace := '<font='+(ArrReplace[0])+'>';
            FSize := StrToInt(ArrReplace[0]);
         end;

         if Font then
            T.TextSettings.Font.Size := FSize;;

         if AnsiContainsText(arr[i],'</font>') then
            Font := False;

         T.Height := 28;
         T.Width := 500;

         T.Text := arr[i]
                   .Replace('<red>','')
                   .Replace('<yellow>','')
                   .Replace('<blue>','')
                   .Replace('<green>','')
                   .Replace('<r>','')
                   .Replace('<s>','')
                   .Replace('<b>','')
                   .Replace('<i>','')
                   .Replace('<br>','')
                   .Replace('<p>','')
                   .Replace('<whatsapp>','')
                   .Replace('<ofertas>','')
                   .Replace(fontReplace,'')
                   .Replace('</font>','')
                   ;

         T.TextSettings.HorzAlign := TTextAlign.Center;
         T.TextSettings.VertAlign := TTextAlign.Trailing;

         FL.AddObject(T);
         end;

      end;

      FL.EndUpdate;
      Self.AddObject(FL);
      Self.EndUpdate;
   end;

end;

procedure TShapeHelper.URLClick(Sender: TObject);
begin
  AbrirUrl(TText(Sender).Text);
end;

procedure TShapeHelper.WhatsAppClick(Sender: TObject);
begin
   FormMain.Switchs;

   if (not FormMain.Telefone.IsChecked) then begin
      FormMain.TelefoneAcesso('Permitir que o aplicativo envie mensagens?');
   end;

   if (FormMain.Telefone.IsChecked) then
      Whats(TText(Sender).Hint,'');
end;

{ TDataSetHelper }
{$IF CompilerVersion >= 33}
function TDataSetHelper.JSONArray: TJSONArray;
var
   JSONStream : TStringStream;
   JSONWriter : TFDBatchMoveJSONWriter;
   DataSetReader :TFDBatchMoveDataSetReader;
   BatchMove :TFDBatchMove;
begin
   JSONStream := TStringStream.Create;
   JSONWriter := TFDBatchMoveJSONWriter.Create(nil);
   DataSetReader := TFDBatchMoveDataSetReader.Create(nil);
   DataSetReader.DataSet := Self;
   BatchMove := TFDBatchMove.Create(nil);
   BatchMove.Reader := DataSetReader;
   BatchMove.Writer := JSONWriter;
   try
      Self.Active := True;
      JSONWriter.Stream := JSONStream;
      BatchMove.Execute;
      Result := TJSONObject.ParseJSONValue( JSONStream.DataString) as TJSONArray;
   finally
     JSONStream.DisposeOf;
     JSONWriter.DisposeOf;
     DataSetReader.DisposeOf;
     BatchMove.DisposeOf;
   end;
end;
{$ENDIF}

function TDataSetHelper.FieldxValue(Field: String;
  Value: TEdit): TDataSet;
begin
   Self.FieldByName(Field).Value := Value.Text;
  Result := Self;
end;

function TDataSetHelper.OpenJSONArray(SQL:String) :String;
var
   I:Integer;
   s :TStringBuilder;
begin

   {Self.Open(SQL);}
   s := TStringBuilder.Create;
   Self.First;
   while not Self.eof do begin
      s.Append('{');
      for I := 0 to Self.FieldCount -1 do begin

         s.Append('"'+Self.Fields[I].FieldName+'":"'+Self.Fields[I].AsString+'",');

      end;
      s.Append('},');
      Self.Next;
   end;
   s.Append(',');

   result := StringReplace(StringReplace(s.ToString ,',}','}',[rfReplaceAll]),',,','',[rfReplaceAll]);

   S.Free;

end;

procedure TDataSetHelper.OpenUser(JSON: String);
var
  I :Integer;
  str :TStringBuilder;
  JSONArray: TJSONArray;
  JSONDataSet : TCustomJSONDataSetAdapter;

begin
  //JSON := Memo1.Text;

   JSONObject := TJSONObject.ParseJSONValue(JSON) as TJSONObject;
   str := TStringBuilder.Create;
   str.Append('[');
   for I := 0 to JSONObject.Count - 1 do begin

      str.Append(JSONObject.Pairs[i].JsonValue.ToJSON+',');

   end;
   str.Append(']');


   JSONArray := TJSONObject.ParseJSONValue(
   (str.ToString).Replace(',]',']')
   ) as TJSONArray;
   JSONDataSet := TCustomJSONDataSetAdapter.Create(Nil);

   try
      JSONDataSet.Dataset := Self;

      JSONDataSet.UpdateDataSet(JSONArray);
   finally
      str.DisposeOf;
      JSONObject.DisposeOf;
      JSONDataSet.Free;
      JSONArray.Free;
   end;

end;

procedure TDataSetHelper.OpenJSON(JSON: String);
var
   JSONArray: TJSONArray;
   JSONDataSet : TCustomJSONDataSetAdapter;
begin
   if (JSON = EmptyStr) then Exit;

   JSON := JX(JSON);

   JSONArray := TJSONObject.ParseJSONValue(JSON) as TJSONArray;
   JSONDataSet := TCustomJSONDataSetAdapter.Create(Nil);

   try
      JSONDataSet.Dataset := Self;

      JSONDataSet.UpdateDataSet(JSONArray);
   finally
      JSONDataSet.Free;
      JSONArray.Free;
   end;
end;

{ TListBoxItemHelper }

procedure TListBoxItemHelper.AddLabel(Text: String; Size: Real);
var
   txt :TLabel;
begin
   txt := TLabel.Create(Self);
   txt.Parent := Self;
   txt.Align := TAlignLayout.Top;
   txt.Size.Width := 161;
   txt.Size.Height := 23;
   txt.Margins.Left := 10;;
   txt.Size.PlatformDefault := False;
   txt.TextSettings.Font.Size := Size;
   txt.StyledSettings := [TStyledSetting.FontColor];
   txt.Text := Text;
   txt.TextSettings.HorzAlign := TTextAlign.Leading;
end;

{ TImageHelper }

procedure TImageHelper.LoadJSON(JSArray: String);
begin
//
end;

procedure TImageHelper.LoadUrl(url: String);
var
   MyFile: TFileStream;
   NetHTTPClient : TNetHTTPClient;
   ImgUrl : String;
   //RStream :TRectangle;
begin
   ImgUrl := (url).Replace('.png','.jpg');

   if ImgUrl <> '' then begin
      Self.BeginUpdate;
      if not FileExists(TPath.Combine(TPath.GetDownloadsPath,TPath.GetFileName(ImgUrl))) then begin
         NetHTTPClient := TNetHTTPClient.Create(nil);
         NetHTTPClient.Asynchronous := False;
         NetHTTPClient.ConnectionTimeout := 60000;
         NetHTTPClient.ResponseTimeout := 60000;
         NetHTTPClient.HandleRedirects := True;
         NetHTTPClient.AllowCookies := True;
         NetHTTPClient.UserAgent := 'Embarcadero URI Client/1.0';

         try
            MyFile := TFileStream.Create(TPath.Combine(TPath.GetDownloadsPath,TPath.GetFileName(ImgUrl)),
                                   fmCreate);
         except
            MyFile := TFileStream.Create(TPath.Combine(TPath.GetDownloadsPath,
                    RightStr(ImgUrl,10)+'.jpg'), fmCreate);
         end;

         TThread.CreateAnonymousThread(
         procedure () begin
            try
               NetHTTPClient.Get(url, MyFile);
            finally
               NetHTTPClient.DisposeOf;
            end;

            TThread.Synchronize (TThread.CurrentThread,
            procedure () begin
               try
                  Self.Bitmap.LoadFromStream(MyFile)
               except
                  Self.Bitmap.LoadFromFile(
                  TPath.Combine(TPath.GetDownloadsPath,TPath.GetFileName(ImgUrl)));

               end;

               Self.EndUpdate;
               MyFile.DisposeOf;
            end);
         end).Start;

      end else begin

         TThread.CreateAnonymousThread(
         procedure ()
         begin
            try
                Self.Bitmap.LoadFromFile(TPath.Combine(TPath.GetDownloadsPath,TPath.GetFileName(ImgUrl)));

            except
                //Self.ImagemByName('logo');
            end;
            Self.EndUpdate;
         end).Start;

      end;
   end;

end;

end.



