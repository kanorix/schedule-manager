import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_controller/helper/datetime_helper.dart';
import 'package:time_controller/model/event.dart';
import 'package:time_controller/model/term.dart';
import 'package:time_controller/repository/event_repository.dart';

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

  @override
  Widget build(BuildContext context) {
    final helper = DateTimeHelper(DateTime.now());
    final repo = EventRepository();
    final w = repo.findByMonthAndDay(helper.month, helper.day);
    return ConstrainedBox(
      //　横幅は最大 300px までしか自由に伸長できない制限をかける
      constraints: BoxConstraints(maxWidth: 600),
      child: Card(
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: FutureBuilder(
          future: w,
          builder: (_, AsyncSnapshot<Event?> snap) {
            if (!snap.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      helper.formatted,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Divider(),
                  // Flexible(child: Placeholder()),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        workTerms[snap.data!.termId].title,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      color: workTerms[snap.data!.termId].color,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
