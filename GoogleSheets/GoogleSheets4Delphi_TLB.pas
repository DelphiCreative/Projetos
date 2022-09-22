unit GoogleSheets4Delphi_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 98336 $
// File generated on 11/08/2022 18:44:07 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\MeusProjetos\GitHub\Projetos\GoogleSheets\Win32\Debug\GoogleSheets4Delphi.dll (1)
// LIBID: {1E0874B8-963D-4202-8E7B-EC8F760D48E0}
// LCID: 0
// Helpfile: 
// HelpString: Integra��o Delphi com API Google Sheets
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
//   (2) v2.4 mscorlib, (C:\Windows\Microsoft.NET\Framework\v4.0.30319\mscorlib.tlb)
// SYS_KIND: SYS_WIN32
// Errors:
//   Error creating palette bitmap of (TGoogleSheets) : No Server registered for this CoClass
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, mscorlib_TLB, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  GoogleSheets4DelphiMajorVersion = 1;
  GoogleSheets4DelphiMinorVersion = 0;

  LIBID_GoogleSheets4Delphi: TGUID = '{1E0874B8-963D-4202-8E7B-EC8F760D48E0}';

  IID__GoogleSheets: TGUID = '{A72B6817-B8D8-3F0F-915E-9448F8D9A393}';
  CLASS_GoogleSheets: TGUID = '{C2EBEA9E-5B74-3212-A6A2-6DC1C1425CF1}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _GoogleSheets = interface;
  _GoogleSheetsDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  GoogleSheets = _GoogleSheets;


// *********************************************************************//
// Interface: _GoogleSheets
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {A72B6817-B8D8-3F0F-915E-9448F8D9A393}
// *********************************************************************//
  _GoogleSheets = interface(IDispatch)
    ['{A72B6817-B8D8-3F0F-915E-9448F8D9A393}']
    function Get_ToString: WideString; safecall;
    function Equals(obj: OleVariant): WordBool; safecall;
    function GetHashCode: Integer; safecall;
    function GetType: _Type; safecall;
    function Get_SpreadSheetId: WideString; safecall;
    procedure Set_SpreadSheetId(const pRetVal: WideString); safecall;
    function Get_Sheet: WideString; safecall;
    procedure Set_Sheet(const pRetVal: WideString); safecall;
    function Get_IndexStart: WideString; safecall;
    procedure Set_IndexStart(const pRetVal: WideString); safecall;
    function Get_IndexEnd: WideString; safecall;
    procedure Set_IndexEnd(const pRetVal: WideString); safecall;
    function Get_Columns: WideString; safecall;
    procedure Set_Columns(const pRetVal: WideString); safecall;
    procedure ListClear; safecall;
    procedure AddColumn(const value: WideString); safecall;
    function GoogleService(const clientSecret: WideString): WideString; safecall;
    function Get: WideString; safecall;
    function Clear: WideString; safecall;
    function Update: WideString; safecall;
    function Append: WideString; safecall;
    property ToString: WideString read Get_ToString;
    property SpreadSheetId: WideString read Get_SpreadSheetId write Set_SpreadSheetId;
    property Sheet: WideString read Get_Sheet write Set_Sheet;
    property IndexStart: WideString read Get_IndexStart write Set_IndexStart;
    property IndexEnd: WideString read Get_IndexEnd write Set_IndexEnd;
    property Columns: WideString read Get_Columns write Set_Columns;
  end;

// *********************************************************************//
// DispIntf:  _GoogleSheetsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {A72B6817-B8D8-3F0F-915E-9448F8D9A393}
// *********************************************************************//
  _GoogleSheetsDisp = dispinterface
    ['{A72B6817-B8D8-3F0F-915E-9448F8D9A393}']
    property ToString: WideString readonly dispid 0;
    function Equals(obj: OleVariant): WordBool; dispid 1610743809;
    function GetHashCode: Integer; dispid 1610743810;
    function GetType: _Type; dispid 1610743811;
    property SpreadSheetId: WideString dispid 1610743812;
    property Sheet: WideString dispid 1610743814;
    property IndexStart: WideString dispid 1610743816;
    property IndexEnd: WideString dispid 1610743818;
    property Columns: WideString dispid 1610743820;
    procedure ListClear; dispid 1610743822;
    procedure AddColumn(const value: WideString); dispid 1610743823;
    function GoogleService(const clientSecret: WideString): WideString; dispid 1610743824;
    function Get: WideString; dispid 1610743825;
    function Clear: WideString; dispid 1610743826;
    function Update: WideString; dispid 1610743827;
    function Append: WideString; dispid 1610743828;
  end;

// *********************************************************************//
// The Class CoGoogleSheets provides a Create and CreateRemote method to          
// create instances of the default interface _GoogleSheets exposed by              
// the CoClass GoogleSheets. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGoogleSheets = class
    class function Create: _GoogleSheets;
    class function CreateRemote(const MachineName: string): _GoogleSheets;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TGoogleSheets
// Help String      : 
// Default Interface: _GoogleSheets
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TGoogleSheets = class(TOleServer)
  private
    FIntf: _GoogleSheets;
    function GetDefaultInterface: _GoogleSheets;
  protected
    procedure InitServerData; override;
    function Get_ToString: WideString;
    function Get_SpreadSheetId: WideString;
    procedure Set_SpreadSheetId(const pRetVal: WideString);
    function Get_Sheet: WideString;
    procedure Set_Sheet(const pRetVal: WideString);
    function Get_IndexStart: WideString;
    procedure Set_IndexStart(const pRetVal: WideString);
    function Get_IndexEnd: WideString;
    procedure Set_IndexEnd(const pRetVal: WideString);
    function Get_Columns: WideString;
    procedure Set_Columns(const pRetVal: WideString);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _GoogleSheets);
    procedure Disconnect; override;
    function Equals(obj: OleVariant): WordBool;
    function GetHashCode: Integer;
    function GetType: _Type;
    procedure ListClear;
    procedure AddColumn(const value: WideString);
    function GoogleService(const clientSecret: WideString): WideString;
    function Get: WideString;
    function Clear: WideString;
    function Update: WideString;
    function Append: WideString;
    property DefaultInterface: _GoogleSheets read GetDefaultInterface;
    property ToString: WideString read Get_ToString;
    property SpreadSheetId: WideString read Get_SpreadSheetId write Set_SpreadSheetId;
    property Sheet: WideString read Get_Sheet write Set_Sheet;
    property IndexStart: WideString read Get_IndexStart write Set_IndexStart;
    property IndexEnd: WideString read Get_IndexEnd write Set_IndexEnd;
    property Columns: WideString read Get_Columns write Set_Columns;
  published
  end;

procedure Register;

resourcestring
  dtlServerPage = '(none)';

  dtlOcxPage = '(none)';

implementation

uses System.Win.ComObj;

class function CoGoogleSheets.Create: _GoogleSheets;
begin
  Result := CreateComObject(CLASS_GoogleSheets) as _GoogleSheets;
end;

class function CoGoogleSheets.CreateRemote(const MachineName: string): _GoogleSheets;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GoogleSheets) as _GoogleSheets;
end;

procedure TGoogleSheets.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{C2EBEA9E-5B74-3212-A6A2-6DC1C1425CF1}';
    IntfIID:   '{A72B6817-B8D8-3F0F-915E-9448F8D9A393}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TGoogleSheets.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _GoogleSheets;
  end;
end;

procedure TGoogleSheets.ConnectTo(svrIntf: _GoogleSheets);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TGoogleSheets.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TGoogleSheets.GetDefaultInterface: _GoogleSheets;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TGoogleSheets.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TGoogleSheets.Destroy;
begin
  inherited Destroy;
end;

function TGoogleSheets.Get_ToString: WideString;
begin
  Result := DefaultInterface.ToString;
end;

function TGoogleSheets.Get_SpreadSheetId: WideString;
begin
  Result := DefaultInterface.SpreadSheetId;
end;

procedure TGoogleSheets.Set_SpreadSheetId(const pRetVal: WideString);
begin
  DefaultInterface.SpreadSheetId := pRetVal;
end;

function TGoogleSheets.Get_Sheet: WideString;
begin
  Result := DefaultInterface.Sheet;
end;

procedure TGoogleSheets.Set_Sheet(const pRetVal: WideString);
begin
  DefaultInterface.Sheet := pRetVal;
end;

function TGoogleSheets.Get_IndexStart: WideString;
begin
  Result := DefaultInterface.IndexStart;
end;

procedure TGoogleSheets.Set_IndexStart(const pRetVal: WideString);
begin
  DefaultInterface.IndexStart := pRetVal;
end;

function TGoogleSheets.Get_IndexEnd: WideString;
begin
  Result := DefaultInterface.IndexEnd;
end;

procedure TGoogleSheets.Set_IndexEnd(const pRetVal: WideString);
begin
  DefaultInterface.IndexEnd := pRetVal;
end;

function TGoogleSheets.Get_Columns: WideString;
begin
  Result := DefaultInterface.Columns;
end;

procedure TGoogleSheets.Set_Columns(const pRetVal: WideString);
begin
  DefaultInterface.Columns := pRetVal;
end;

function TGoogleSheets.Equals(obj: OleVariant): WordBool;
begin
  Result := DefaultInterface.Equals(obj);
end;

function TGoogleSheets.GetHashCode: Integer;
begin
  Result := DefaultInterface.GetHashCode;
end;

function TGoogleSheets.GetType: _Type;
begin
  Result := DefaultInterface.GetType;
end;

procedure TGoogleSheets.ListClear;
begin
  DefaultInterface.ListClear;
end;

procedure TGoogleSheets.AddColumn(const value: WideString);
begin
  DefaultInterface.AddColumn(value);
end;

function TGoogleSheets.GoogleService(const clientSecret: WideString): WideString;
begin
  Result := DefaultInterface.GoogleService(clientSecret);
end;

function TGoogleSheets.Get: WideString;
begin
  Result := DefaultInterface.Get;
end;

function TGoogleSheets.Clear: WideString;
begin
  Result := DefaultInterface.Clear;
end;

function TGoogleSheets.Update: WideString;
begin
  Result := DefaultInterface.Update;
end;

function TGoogleSheets.Append: WideString;
begin
  Result := DefaultInterface.Append;
end;

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TGoogleSheets]);
end;

end.
