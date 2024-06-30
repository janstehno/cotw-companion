import 'package:logger/logger.dart';

class HelperLogger {
  final String _identifier;

  final Logger _logger = Logger(
    filter: null,
    output: null,
    printer: PrettyPrinter(
      methodCount: 0,
      noBoxingByDefault: true,
      colors: true,
      printEmojis: false,
      printTime: false,
    ),
  );

  HelperLogger({
    required String identifier,
  }) : _identifier = identifier;

  HelperLogger.loadingApp() : _identifier = "[LOADING] [APP]";

  HelperLogger.loadingEnumerators() : _identifier = "[LOADING] [ENUMERATORS]";

  HelperLogger.loadingPlanner() : _identifier = "[LOADING] [PLANNER]";

  HelperLogger.loadingFilter() : _identifier = "[LOADING] [FILTER]";

  HelperLogger.loadingMultimounts() : _identifier = "[LOADING] [MULTIMOUNTS]";

  HelperLogger.loadingMap() : _identifier = "[LOADING] [MAP]";

  HelperLogger.loadingLoadouts() : _identifier = "[LOADING] [LOADOUTS]";

  HelperLogger.loadingLogs() : _identifier = "[LOADING] [LOGS]";

  HelperLogger.loadingHuntingPass() : _identifier = "[LOADING] [HUNTING PASS]";

  HelperLogger.editLogs() : _identifier = "[EDIT] [LOGS]";

  void t(String message) => _logger.d("[🛠️ Developer] $_identifier $message");

  void d(String message) => _logger.d("[🛠️ Developer] $_identifier $message");

  void i(String message) => _logger.i("[🛠️ Developer] $_identifier $message");

  void w(String message) => _logger.w("[🛠️ Developer] $_identifier $message");

  void e(String message) => _logger.e("[🛠️ Developer] $_identifier $message");
}
