class DateTimeHelper {
  final DateTime _datetime;
  DateTimeHelper(this._datetime);

  int get lastDay => DateTime(_datetime.year, _datetime.month + 1, 0).day;
  int get month => _datetime.month;
  int get day => _datetime.day;

  String get formatted =>
      _datetime.toString().split(' ').first.replaceAll('-', '/');

  List<DateTime> get days => [
        for (int i = 1; i <= lastDay; i++)
          DateTime(_datetime.year, _datetime.month, i)
      ];
}
