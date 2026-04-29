# Pascal Event Pump

A lightweight and efficient object-oriented event pump implementation for Free Pascal, designed to manage and execute queued event callbacks with minimal overhead.

## New Feature: Priority-Based Event Scheduling (and 1 Breaking Change)

Added priority-based event scheduling system that allows events to be executed in order of importance. Events with higher priority values are executed first, making it ideal for applications where certain callbacks need to be processed before others.

**Key Changes:**
- Added `priority` parameter to `AddEvent` method (default: 0)
- Implemented automatic event sorting before execution
- Events are now executed from highest to lowest priority
- _Object-oriented API for easier integration (breaking change, see migration guide below)_

### Major Refactoring: Migration to Object-Oriented Architecture

The current version introduces a complete refactoring from a procedural API to an object-oriented class-based design. This change renames the original Pascal unit to `EventPumpUnit.pp`, and improves code organization, encapsulation, and memory management.

### API Changes

**Before (Procedural API):**
```pascal
var
  events: TEventList;
begin
  AddEvent(events, @MyCallback);
  DoEvents(events);
  events.Free;
end;
```

**After (Object-Oriented API):**
```pascal
var
  eventPump: TEventPump;
begin
  eventPump := TEventPump.Create;
  try
    eventPump.AddEvent(@MyCallback);
    eventPump.DoEvents;
  finally
    eventPump.Free;
  end;
end;
```

### Migration Guide

1. **Unit Name Change**: The unit has been renamed from `EventPump` to `EventPumpUnit` to avoid naming conflicts with the `TEventPump` class.

2. **Variable Declaration**: Replace `TEventList` variables with `TEventPump` instances.

3. **Method Calls**: All functions now operate on the `TEventPump` instance instead of passing event lists as parameters.

4. **Memory Management**: Use `Create` and `Free` with `try...finally` blocks for proper resource management.

5. **Removed Types**: `TEventList` is now a private implementation detail and is no longer exposed in the public interface.

### Benefits of the New Architecture

- **Better Encapsulation**: Event list is managed internally, reducing complexity
- **Automatic Memory Management**: Constructor and destructor handle resource allocation
- **Cleaner API**: Methods operate on the instance, no need to pass event lists
- **Property Support**: Added `EventCount` property for convenient access to event count
- **Type Safety**: Stronger type checking through class-based design
- **Easier Extension**: Class-based design makes it easier to add new features through inheritance
- **Priority Scheduling**: Built-in priority system ensures critical events are executed first
- **Flexible Event Management**: Support for both simple and priority-based event queuing

### Compatibility

This is a **breaking change**. Existing code using the procedural API will need to be updated to use the new object-oriented API. The functionality remains the same, but the interface has changed significantly.

## Requirements

- Free Pascal Compiler 3.0.0 or higher
- Generics.Collections (included in standard library)

## Features

- Object-oriented design with encapsulated event management
- Simple event queue management through class interface
- Generic callback system using procedure types
- **Priority-based event scheduling** - Events are executed in order of priority (higher priority first)
- Batch event execution with automatic cleanup
- Event counting and undo capabilities
- Zero-dependency implementation (uses only standard library)
- Automatic memory management with constructor/destructor
- Thread-safe design for basic use cases

## Installation & Usage

### Installing From Source
1. Clone or download the repository:
```bash
git clone https://github.com/Pac-Dessert1436/Pascal-Event-Pump.git
```
2. To use this event pump in your Pascal project:
   - Copy `EventPumpUnit.pp` to your project directory.
   - Add `EventPumpUnit` to your `uses` clause.
3. To run the test program (optional):
```bash
# Navigate to the project directory
cd Pascal-Event-Pump
# Compile the test program
fpc Test1.pp
# Run the test program
./Test1
```

### Basic Example

```pascal
program MyProgram;

uses
  EventPumpUnit, SysUtils;

procedure MyCallback;
begin
  WriteLn('Callback executed!');
end;

procedure HighPriorityCallback;
begin
  WriteLn('High priority callback executed!');
end;

var
  eventPump: TEventPump;
begin
  eventPump := TEventPump.Create;
  
  try
    // Add events with different priorities
    eventPump.AddEvent(@MyCallback, 1);              // Low priority
    eventPump.AddEvent(@HighPriorityCallback, 10);   // High priority
    eventPump.DoEvents;                              // Executes high priority first
  finally
    eventPump.Free;                                  // Free the event pump instance
  end;
end.
```

### Priority Scheduling

The event pump now supports priority-based event scheduling. Events with higher priority values are executed first. If no priority is specified, events default to priority 0.

**Priority Levels:**
- **0 or negative**: Low priority (executed last)
- **1-10**: Normal priority
- **11-50**: High priority
- **51+**: Critical priority (executed first)

**Example:**
```pascal
eventPump.AddEvent(@LowPriorityTask, 1);
eventPump.AddEvent(@CriticalTask, 100);
eventPump.AddEvent(@NormalTask, 5);
eventPump.AddEvent(@HighPriorityTask, 20);
// Execution order: CriticalTask, HighPriorityTask, NormalTask, LowPriorityTask
```

### API Reference

#### `TEventPump`
The main class for managing event queues.

#### `constructor Create`
Creates a new instance of the event pump and initializes the internal event list.

#### `destructor Destroy`
Destroys the event pump instance and frees all allocated memory.

#### `procedure AddEvent(callback: TEventCallback; priority: Integer = 0)`
Adds a callback procedure to the event queue with an optional priority level.

- **Parameters:**
  - `callback`: The procedure to execute
  - `priority`: Priority level (higher values execute first, default is 0)

#### `procedure DoEvents`
Executes all queued callbacks in priority order (highest priority first) and clears the event list.

#### `function CountEvents: Integer`
Returns the number of pending events in the queue.

- **Returns:** Number of queued callbacks

#### `procedure UndoEvents`
Clears all queued events without executing them.

#### `property EventCount: Integer`
Read-only property that returns the number of pending events (same as CountEvents).

## Building

Compile with Free Pascal Compiler (FPC):

```bash
fpc Test1.pp
```

Or build the event pump unit (now renamed to `EventPumpUnit.pp`):

```bash
fpc EventPumpUnit.pp
```

## License

This project is licensed under the BSD 3-Clause License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Acknowledgments

Built with Free Pascal and the standard library generics collection.