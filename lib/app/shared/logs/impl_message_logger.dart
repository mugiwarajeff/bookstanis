import 'dart:io';

import 'package:bookstanis/app/shared/logs/interface/message_logger.dart';
import 'package:bookstanis/app/shared/logs/models/log_message.dart';
import 'package:path_provider/path_provider.dart';

class ImplMessageLogger implements MessageLogger {
  String logFileName = "local_logs.txt";

  @override
  Future<void> logLocalMessage(LogMessage message) async {
    Directory applicationSupportDir = await getApplicationSupportDirectory();

    String filePath = "${applicationSupportDir.path}/$logFileName";

    File logFile = File(filePath);

    bool fileExists = await logFile.exists();
    if (!fileExists) {
      await logFile.create(recursive: true);
    }

    await logFile.writeAsString(
        "${message.toString()}${Platform.lineTerminator}",
        mode: FileMode.append);
  }

  @override
  Future<List<LogMessage>> getAllLocalMessages() async {
    Directory applicationSupportDir = await getApplicationSupportDirectory();

    String filePath = "${applicationSupportDir.path}/$logFileName";

    File logFile = File(filePath);

    List<String> lines = await logFile.readAsLines();

    List<LogMessage> messages =
        lines.map((line) => LogMessage.fromString(line)).toList();

    return messages;
  }

  @override
  Future<bool> logServerMessage(LogMessage logMessage) {
    // TODO: implement logServerMessage
    throw UnimplementedError();
  }
}
