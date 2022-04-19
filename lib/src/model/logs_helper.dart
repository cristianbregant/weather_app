class LogsHelper {
  bool isEnabled = true;

  LogsHelper(bool _enabled) {
    isEnabled = _enabled;
  }

  log(dynamic object) {
    if (isEnabled) {
      print(object);
    }
  }
}
