import 'package:taskmgt/model/status.dart';

extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

extension StatusLabel on Status {
  String get short {
    switch (this) {
      case Status.pending:
        return 'Pend';
      case Status.running:
        return 'Run';
      case Status.testing:
        return 'Test';
      case Status.completed:
        return 'Comp';
    }
  }
}
