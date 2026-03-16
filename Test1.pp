program Test1;

{$mode objfpc}{$H+}

uses
  EventPump, SysUtils;

procedure MyCallback;
begin
  WriteLn('- Callback executed!');
end;

procedure AnotherCallback;
begin
  WriteLn('- Here''s another action!');
end;

var
  events: TEventList;
  count: Integer;
begin
  AddEvent(events, @MyCallback);
  AddEvent(events, @AnotherCallback);
  
  count := CountEvents(events);
  WriteLn('Event count: ' + IntToStr(count));
  WriteLn('Executing all events:');
  DoEvents(events);
  
  events.Free;
end.