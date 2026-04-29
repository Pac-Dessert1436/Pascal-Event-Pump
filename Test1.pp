program Test1;

{$mode objfpc}{$H+}

uses
  EventPumpUnit, SysUtils;

procedure MyCallback;
begin
  WriteLn('- Default priority callback executed!');
end;

procedure AnotherCallback;
begin
  WriteLn('- Medium priority callback executed!');
end;

procedure HighPriorityCallback;
begin
  WriteLn('- High priority callback executed!');
end;

procedure CriticalCallback;
begin
  WriteLn('- Critical priority callback executed!');
end;

var
  eventPump: TEventPump;
  count: Integer;
begin
  eventPump := TEventPump.Create;
  
  try
    WriteLn('Adding events with different priorities:');
    WriteLn('  - Default priority (0)');
    eventPump.AddEvent(@MyCallback);
    
    WriteLn('  - High priority (10)');
    eventPump.AddEvent(@HighPriorityCallback, 10);
    
    WriteLn('  - Medium priority (5)');
    eventPump.AddEvent(@AnotherCallback, 5);
    
    WriteLn('  - Critical priority (100)');
    eventPump.AddEvent(@CriticalCallback, 100);
    
    count := eventPump.CountEvents;
    WriteLn('');
    WriteLn('Total event count: ' + IntToStr(count));
    WriteLn('Executing all events (sorted by priority):');
    eventPump.DoEvents;
  finally
    eventPump.Free;
  end;
end.