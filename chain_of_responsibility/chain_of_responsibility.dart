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
  late Set<LogLevel> levels;
  late Logger _next;

  Logger(this.levels);

  bool get universal => levels.containsAll(LogLevel.values);
  void set next(Logger nextLogger) => _next = nextLogger;

  void addLevel(LogLevel level) => levels.add(level);

  void log(LogLevel level, String msg) {
    if (levels.contains(level) || universal) {
      write_message(msg);
    }
    _next.log(level, msg);
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
  var eLog = EmailLogger(
      Set.from([LogLevel.FunctionalMessage, LogLevel.FunctionalError]));
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
