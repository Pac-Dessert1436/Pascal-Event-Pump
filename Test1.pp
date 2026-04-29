program Test1;

{$mode objfpc}{$H+}

uses
  EventPumpUnit, SysUtils;

procedure MyCallback;
begin
  WriteLn('- Callback executed!');
end;

procedure AnotherCallback;
begin
  WriteLn('- Here''s another action!');
end;

var
  eventPump: TEventPump;
  count: Integer;
begin
  eventPump := TEventPump.Create;
  
  try
    eventPump.AddEvent(@MyCallback);
    eventPump.AddEvent(@AnotherCallback);
    
    count := eventPump.CountEvents;
    WriteLn('Event count: ' + IntToStr(count));
    WriteLn('Executing all events:');
    eventPump.DoEvents;
  finally
    eventPump.Free;
  end;
end.