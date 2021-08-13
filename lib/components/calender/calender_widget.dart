import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:time_controller/components/calender/icalender_helper.dart';
import 'package:time_controller/routes/app_router.dart';

class CalenderWidget extends StatelessWidget {
  // const HomeScreen({Key? key, required User user}) : super(key: key);
  const CalenderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CalenderWidget();
  }
}

class _CalenderWidget extends StatelessWidget {
  // const HomeScreen({Key? key, required User user}) : super(key: key);
  _CalenderWidget({Key? key}) : super(key: key);

  static const _size = 40.0;

  double _dateToDouble(DateTime date) => date.hour + (date.minute / 60);
  double _position(double pos) => (16.0 + _size * 2) * pos;

  putEvent(ICalenderEvent event) {
    final _start = _dateToDouble(event.dtstart);
    final _end = _dateToDouble(event.dtend);
    final color = Colors.greenAccent;
    return Positioned(
      left: 100.0,
      right: 40.0,
      top: _size + 8 + _position(_start),
      child: Builder(
        builder: (BuildContext context) {
          return InkWell(
            onTap: () {
              GetIt.I<AppRouter>()
                  .push(context, '/home/calender/detail', args: event);
              print('tap');
            },
            child: Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.95),
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              margin: EdgeInsets.all(1),
              height: ((16.0 + _size * 2) * (_end - _start)) - 2,
              child: Container(
                margin: EdgeInsets.all(5),
                child: Text(event.summary),
              ),
            ),
          );
        },
      ),
    );
  }

  final c = ScrollController();
  bool isToday(DateTime targetDate) {
    final today = DateTime.now();
    if (targetDate.year == today.year && targetDate.month == today.month) {
      print(today);
      print('${targetDate.year}/${targetDate.month}/${targetDate.day}');
    }
    return targetDate.year == today.year &&
        targetDate.month == today.month &&
        targetDate.day == today.day;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      //　横幅は最大 300px までしか自由に伸長できない制限をかける
      constraints: BoxConstraints(maxWidth: 600),
      child: Card(
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                child: Text(
                  '2021/05/24',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Divider(),
              Flexible(child: Placeholder()),
            ],
          ),
        ),
      ),
    );
  }
}
