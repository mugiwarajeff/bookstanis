import 'package:bookstanis/app/shared/logs/models/log_message.dart';

abstract class MessageLogger {
  Future<void> logLocalMessage(LogMessage message);

  Future<List<LogMessage>> getAllLocalMessages();

  Future<bool> logServerMessage(LogMessage logMessage);
}
