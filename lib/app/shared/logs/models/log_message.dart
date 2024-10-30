import 'package:bookstanis/app/shared/logs/models/enums/log_message_category.dart';

class LogMessage {
  final String message;
  final DateTime timestamp;
  final LogMessageCategory category;
  final String source;
  final String userId;
  final int? codeError;

  LogMessage(
      {required this.category,
      required this.message,
      required this.source,
      required this.timestamp,
      required this.userId,
      this.codeError});

  @override
  String toString() {
    return "${timestamp.toIso8601String()} - ${category.toString()} - $message - $source - $userId} - ${codeError ?? "0"}";
  }

  factory LogMessage.fromString(String logLine) {
    List<String> splitedLine = logLine.split("-");

    return LogMessage(
        message: splitedLine[2].trim(),
        category: LogMessageCategory.values.byName(splitedLine[1].trim()),
        timestamp: DateTime.parse(splitedLine[0].trim()),
        source: splitedLine[3].trim(),
        userId: splitedLine[4].trim(),
        codeError: int.tryParse(splitedLine[5].trim()));
  }
}
