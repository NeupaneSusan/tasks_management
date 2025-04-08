class DateFormatter {
  static final DateFormatter _instance = DateFormatter._internal();

  factory DateFormatter() {
    return _instance;
  }

  DateFormatter._internal();

  static const _monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  String get formattedCurrentDate {
    final now = DateTime.now();
    final paddedDay = now.day.toString().padLeft(2, '0');
    return '${_monthNames[now.month - 1]} $paddedDay, ${now.year}';
  }

  String fullDate(DateTime date) {
    String day = date.day < 10 ? "0${date.day}" : date.day.toString();
    String month = date.month < 10 ? "0${date.month}" : date.month.toString();
    String yrs = date.year.toString();
    return "$yrs-$month-$day";
  }

  List<int> getTimeOfDay(String time) {
    List<String> parts = time.split(' ');
    List<String> timeParts = parts[0].split(':');
    if (parts[1] == 'PM') {
      return [int.parse(timeParts[0]) + 12, int.parse(timeParts[1])];
    }
    return [int.parse(timeParts[0]), int.parse(timeParts[1])];
  }
}
