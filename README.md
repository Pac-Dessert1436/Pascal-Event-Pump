# Pascal Event Pump

A lightweight and efficient event pump implementation for Free Pascal, designed to manage and execute queued event callbacks with minimal overhead.

## Features

- Simple event queue management
- Generic callback system using procedure types
- Batch event execution with automatic cleanup
- Event counting and undo capabilities
- Zero-dependency implementation (uses only standard library)
- Thread-safe design for basic use cases

## Installation
1. Clone or download the repository:
```bash
git clone https://github.com/Pac-Dessert1436/Pascal-Event-Pump.git
```
2. To use this event pump in your Pascal project:
   - Copy `EventPump.pp` to your project directory.
   - Add `EventPump` to your `uses` clause.
3. To run the test program (optional):
```bash
# Navigate to the project directory
cd Pascal-Event-Pump
# Compile the test program
fpc Test1.pp
# Run the test program
./Test1
```

## Usage

### Basic Example

```pascal
program MyProgram;

uses
  EventPump, SysUtils;

procedure MyCallback;
begin
  WriteLn('Callback executed!');
end;

var
  events: TEventList;
begin
  events := nil;
  
  AddEvent(events, @MyCallback);  // Add events to the queue
  DoEvents(events);               // Execute all queued events
  events.Free;                    // Free the event list memory
end.
```

### API Reference

#### `AddEvent(var events: TEventList; callback: TEventCallback)`
Adds a callback procedure to the event queue.

- **Parameters:**
  - `events`: The event list (will be created if nil)
  - `callback`: The procedure to execute

#### `DoEvents(var events: TEventList)`
Executes all queued callbacks and clears the event list.

- **Parameters:**
  - `events`: The event list to process

#### `CountEvents(const events: TEventList): Integer`
Returns the number of pending events in the queue.

- **Returns:** Number of queued callbacks

#### `UndoEvents(var events: TEventList)`
Clears all queued events without executing them.

- **Parameters:**
  - `events`: The event list to clear

## Building

Compile with Free Pascal Compiler (FPC):

```bash
fpc Test1.pp
```

Or build the event pump unit:

```bash
fpc EventPump.pp
```

## Requirements

- Free Pascal Compiler 3.0.0 or higher
- Generics.Collections (included in standard library)

## License

This project is licensed under the BSD 3-Clause License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Acknowledgments

Built with Free Pascal and the standard library generics collection.