import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_controller/components/calender/icalender_helper.dart';

class EventDetailScreen extends StatelessWidget {
  final ICalenderEvent _event;

  const EventDetailScreen({Key? key, required ICalenderEvent event})
      : this._event = event,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _EventDetailWidget(event: _event);
  }
}

class _EventDetailWidget extends StatelessWidget {
  final ICalenderEvent event;

  _EventDetailWidget({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.summary),
      ),
      body: Container(
        child: Column(children: [
          Text(event.summary),
          Text(event.location),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          print("pressed");
        },
      ),
    );
  }
}
