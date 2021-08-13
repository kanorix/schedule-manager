import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:icalendar_parser/icalendar_parser.dart';

class IcalenderHelper {
  Future<List<ICalenderEvent>> fetchEvents(
    Uri uri, {
    bool debug = false,
  }) async {
    if (debug) {
      String mockData = await rootBundle.loadString('mock_data/calender.ics');
      return _parse(mockData)!;
    }
    try {
      final headers = {'Accept': 'text/calender'};
      final response = await http.get(uri, headers: headers);

      if (response.statusCode != 200) {
        throw ("status code is not 200");
      }

      return _parse(response.body) ?? List.empty();
    } catch (e) {
      print(e);
      return Future.error('url access is failed.');
    }
  }

  List<ICalenderEvent>? _parse(String icsData) {
    final iCalendar = ICalendar.fromLines(icsData.split('\n').toList());
    if (iCalendar.data == null) {
      return null;
    }

    return iCalendar.data!.map((e) => ICalenderEvent.fromMap(e)).toList();
  }
}

class ICalenderEvent {
  final DateTime dtstart;
  final DateTime dtend;
  final String summary;
  final String location;

  ICalenderEvent({
    required this.dtstart,
    required this.dtend,
    String? summary,
    String? location,
  })  : this.summary = summary ?? '',
        this.location = location ?? '';

  ICalenderEvent.fromMap(Map<String, dynamic> event)
      : this.dtstart = (event['dtstart'] as DateTime),
        this.dtend = (event['dtend'] as DateTime),
        this.summary = (event['summary'] as String?) ?? '',
        this.location = (event['location'] as String?) ?? '';
}

class RegularEvent {
  final String summary;
  final List<List<DateTime>> dates = [];

  RegularEvent(this.summary);

  void forEach(void Function(DateTime start, DateTime end) eachFunc) {
    for (var i = 0; i < dates.length; i++) {
      final start = dates[i][0];
      final end = dates[i][1];
      eachFunc(start, end);
    }
  }
}
