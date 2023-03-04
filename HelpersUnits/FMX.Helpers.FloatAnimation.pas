unit FMX.Helpers.FloatAnimation;

interface

uses
  FMX.Ani, FMX.Objects, FMX.Types, System.Classes;

type
  TFloatAnimationHelper = class helper for TFloatAnimation
     constructor Create(AOwner :TComponent;
                        ADuration :Single;
                        AStartValue :Single;
                        AStopValue :Single;
                        AStartFromCurrent :Boolean;
                        APropertyName :String;
                        ADelay: Single) overload;
  end;


implementation

{ TFloatAnimationHelper }

constructor TFloatAnimationHelper.Create(AOwner :TComponent;
                        ADuration :Single;
                        AStartValue :Single;
                        AStopValue :Single;
                        AStartFromCurrent :Boolean;
                        APropertyName :String;
                        ADelay: Single) ;
begin
   Inherited Create(AOwner);
   TFmxObject(AOwner).AddObject(Self);
   Delay := ADelay;
   Duration := ADuration;
   PropertyName := APropertyName;
   StartValue :=   AStartValue;
   StartFromCurrent := AStartFromCurrent;
   StopValue := AStopValue;
end;

end.
