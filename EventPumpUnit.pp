unit EventPumpUnit;

{$mode objfpc}{$H+}

interface

uses
  Generics.Collections;

type
  TEventCallback = procedure;
  
  TPriorityEvent = record
    Callback: TEventCallback;
    Priority: Integer;
  end;
  
  TEventList = specialize TList<TPriorityEvent>;

  { TEventPump }
  
  TEventPump = class
  private
    FEvents: TEventList;
    procedure SortEventsByPriority;
  public
    constructor Create;
    destructor Destroy; override;
    
    procedure AddEvent(callback: TEventCallback; priority: Integer = 0);
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

procedure TEventPump.AddEvent(callback: TEventCallback; priority: Integer = 0);
var
  newEvent: TPriorityEvent;
begin
  newEvent.Callback := callback;
  newEvent.Priority := priority;
  FEvents.Add(newEvent);
end;

procedure TEventPump.SortEventsByPriority;
var
  i, j: Integer;
  temp: TPriorityEvent;
begin
  for i := 0 to FEvents.Count - 2 do
  begin
    for j := i + 1 to FEvents.Count - 1 do
    begin
      if FEvents[i].Priority < FEvents[j].Priority then
      begin
        temp := FEvents[i];
        FEvents[i] := FEvents[j];
        FEvents[j] := temp;
      end;
    end;
  end;
end;

procedure TEventPump.DoEvents;
var
  evt: TPriorityEvent;
begin
  SortEventsByPriority;
  
  for evt in FEvents do
  begin
    if Assigned(evt.Callback) then
      evt.Callback;
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