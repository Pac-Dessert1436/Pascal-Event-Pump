unit EventPumpUnit;

{$mode objfpc}{$H+}

interface

uses
  Generics.Collections;

type
  TEventCallback = procedure;
  TEventList = specialize TList<TEventCallback>;

  { TEventPump }
  
  TEventPump = class
  private
    FEvents: TEventList;
  public
    constructor Create;
    destructor Destroy; override;
    
    procedure AddEvent(callback: TEventCallback);
    procedure DoEvents;
    function CountEvents: Integer;
    procedure UndoEvents;
    property EventCount: Integer read CountEvents;
  end;

implementation

uses
  SysUtils;

constructor TEventPump.Create;
begin
  inherited Create;
  FEvents := TEventList.Create;
end;

destructor TEventPump.Destroy;
begin
  FEvents.Free;
  inherited Destroy;
end;

procedure TEventPump.AddEvent(callback: TEventCallback);
begin
  FEvents.Add(callback);
end;

procedure TEventPump.DoEvents;
var
  evt: TEventCallback;
begin
  for evt in FEvents do
  begin
    if Assigned(evt) then evt;
  end;
  FEvents.Clear;
end;

function TEventPump.CountEvents: Integer;
begin
  Result := FEvents.Count;
end;

procedure TEventPump.UndoEvents;
begin
  FEvents.Clear;
end;
  
end.