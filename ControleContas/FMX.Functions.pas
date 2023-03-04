unit FMX.Functions;

interface

uses
  {$IF DEFINED(android)}
   Androidapi.Helpers,
   FMX.Helpers.Android,
  {$ENDIF}
   FMX.Ani,
   FMX.Controls,
   FMX.Types,
   FMX.StdCtrls,
   FMX.Objects,
   FMX.Layouts,
   System.UITypes;

procedure StatusBarColor(Color: TAlphaColor);

implementation


procedure StatusBarColor(Color: TAlphaColor);
begin
   {$IF DEFINED(android) }
   CallInUIThreadAndWaitFinishing(
   procedure begin
     TAndroidHelper.Activity.getWindow.setStatusBarColor(Color);
   end);
   {$ENDIF}
end;



end.
