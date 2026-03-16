unit EventPump;

{$mode objfpc}{$H+}

interface

uses
  Generics.Collections;

type
  TEventCallback = procedure;
  TEventList = specialize TList<TEventCallback>;

procedure AddEvent(var events: TEventList; callback: TEventCallback);
procedure DoEvents(var events: TEventList);
function CountEvents(const events: TEventList): Integer;
procedure UndoEvents(var events: TEventList);

implementation

uses
  SysUtils;

procedure AddEvent(var events: TEventList; callback: TEventCallback);
begin
  if events = nil then
    events := TEventList.Create;
    
  events.Add(callback);
end;

procedure DoEvents(var events: TEventList);
var
  evt: TEventCallback;
begin
  for evt in events do
  begin
    if Assigned(evt) then evt;
  end;
  events.Clear;
end;

function CountEvents(const events: TEventList): Integer;
begin
  if events = nil then
    Result := 0
  else
    Result := events.Count;
end;

procedure UndoEvents(var events: TEventList);
begin
  if events <> nil then events.Clear;
end;
  
end.