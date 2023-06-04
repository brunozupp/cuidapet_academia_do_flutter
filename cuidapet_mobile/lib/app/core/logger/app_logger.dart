import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:logger/logger.dart';

class AppLogger implements IAppLogger {

  final logger = Logger();

  List<String> messages = [];

  @override
  void debug(message, [error, StackTrace? stackTrace]) {
    logger.d(message, error, stackTrace);
  }

  @override
  void error(message, [error, StackTrace? stackTrace]) {
    logger.e(message, error, stackTrace);
  }

  @override
  void info(message, [error, StackTrace? stackTrace]) {
    logger.i(message, error, stackTrace);
  }

  @override
  void warning(message, [error, StackTrace? stackTrace]) {
    logger.w(message, error, stackTrace);
  }
  
  @override
  void append(message) {
    messages.add(message);
  }

  @override
  void closeAppend() {
    info(messages.join("\n"));
    messages = [];
  }
}