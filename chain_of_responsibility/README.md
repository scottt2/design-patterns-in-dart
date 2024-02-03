## Chain of Responsibility Pattern
In object-oriented design, the chain-of-responsibility pattern is a design pattern consisting of a source of command objects and a series of processing objects. Each processing object contains logic that defines the types of command objects that it can handle; the rest are passed to the next processing object in the chain. A mechanism also exists for adding new processing objects to the end of this chain. Thus, the chain of responsibility is an object oriented version of the if ... else if ... else if ....... else ... endif idiom, with the benefit that the condition–action blocks can be dynamically rearranged and reconfigured at runtime.

In a variation of the standard chain-of-responsibility model, some handlers may act as dispatchers, capable of sending commands out in a variety of directions, forming a tree of responsibility. In some cases, this can occur recursively, with processing objects calling higher-up processing objects with commands that attempt to solve some smaller part of the problem; in this case recursion continues until the command is processed, or the entire tree has been explored. An XML interpreter might work in this manner.

This pattern promotes the idea of loose coupling.

The chain-of-responsibility pattern is structurally nearly identical to the decorator pattern, the difference being that for the decorator, all classes handle the request, while for the chain of responsibility, exactly one of the classes in the chain handles the request.

[Wikipedia: Chain of Responsibility](https://en.wikipedia.org/wiki/Chain-of-responsibility_pattern)

### Example

[View on GitHub](https://github.com/scottt2/design-patterns-in-dart/tree/master/chain_of_responsibility)

```dart
enum LogLevel {
  None,
  Info,
  Debug,
  Warning,
  Error,
  FunctionalMessage,
  FunctionalError,
}

abstract class Logger {
  Set<LogLevel> levels;
  Logger? _next;

  Logger(this.levels);

  bool get universal => levels.containsAll(LogLevel.values);
  void set next(Logger nextLogger) => _next = nextLogger;

  void addLevel(LogLevel level) => levels.add(level);

  void log(LogLevel level, String msg) {
    if (levels.contains(level) || universal) {
      write_message(msg);
    } 
    _next?.log(level, msg);
  }

  void write_message(String msg);
}

class ConsoleLogger extends Logger {
  ConsoleLogger(Set<LogLevel> levels) : super(levels);
  void write_message(String msg) => print("[Console]: $msg");
}

class EmailLogger extends Logger {
  EmailLogger(Set<LogLevel> levels) : super(levels);
  void write_message(String msg) => print("[Email]: $msg");
}

class FileLogger extends Logger {
  FileLogger(Set<LogLevel> levels) : super(levels);
  void write_message(String msg) => print("[File]: $msg");
}

void main() {
  var logger = ConsoleLogger(Set.from(LogLevel.values));
  var eLog = EmailLogger(Set.from([LogLevel.FunctionalMessage, LogLevel.FunctionalError]));
  var fLog = FileLogger(Set.from([LogLevel.Warning, LogLevel.Error]));

  logger.next = eLog;
  eLog.next = fLog;

  logger.log(LogLevel.Debug, "Some amazingly helpful debug message");
  logger.log(LogLevel.Info, "Pretty important information");

  logger.log(LogLevel.Warning, "This is a warning!");
  logger.log(LogLevel.Error, "AHHHHHHHHH!");

  logger.log(LogLevel.FunctionalError, "This is not a show stopper");
  logger.log(LogLevel.FunctionalMessage, "This is basically just info");

  /*
    [Console]: Some amazingly helpful debug message
    [Console]: Pretty important information
    [Console]: This is a warning!
    [File]: This is a warning!
    [Console]: AHHHHHHHHH!
    [File]: AHHHHHHHHH!
    [Console]: This is not a show stopper
    [Email]: This is not a show stopper
    [Console]: This is basically just info
    [Email]: This is basically just info
  */
}
```
