import 'package:logger/logger.dart';

class Log {
  static final Log instance = Log._internal();
  factory Log() => instance;
  Log._internal();

  static var logger = Logger(
    // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: false, // Print an emoji for each log message
      dateTimeFormat: DateTimeFormat.none,
    ), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  static void d(String message) {
    logger.d(message);
  }

  static void e(String message) {
    logger.e(message);
  }
}
