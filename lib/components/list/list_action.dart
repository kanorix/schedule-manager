import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:time_controller/model/event.dart';
import 'package:time_controller/repository/event_repository.dart';

import '../../helper/datetime_helper.dart';
import 'list_state.dart';

class ListAction extends ChangeNotifier {
  late ListState _state;
  late final EventRepository repository;

  ListAction({ListState? state}) {
    final helper = DateTimeHelper(DateTime.now());
    final days = helper.days;
    final events = days.map((e) => Event(month: e.month, day: e.day)).toList();
    this._state = state ??
        ListState(
          month: DateTime.now().month,
          events: events,
        );
    this.repository = EventRepository();
    fetchEvents();
  }

  ListState get state => _state;

  List<Event> marge(List<Event> events, List<Event> addedEvents) {
    return events.map((e) {
      int index = addedEvents.indexWhere((ev) => e.day == ev.day);
      if (index >= 0) {
        return addedEvents[index];
      }
      return e;
    }).toList();
  }

  fetchEvents() async {
    print(FirebaseAuth.instance.currentUser!.uid);
    final events = await repository.findByMonth(_state.month);
    print(events);
    _state = _state.newState(events: marge(_state.events, events));
    notifyListeners();
  }

  void updateTerm(Event event, int termId) {
    if (event.termId == termId) {
      print('same!');
      event.termId = -1;
      termId = -1;
    } else {
      print('not same!');
      event.termId = termId;
    }
    final events = _state.events.map((e) {
      if (e.month == event.month && e.day == event.day) e.termId = termId;
      return e;
    }).toList();

    repository.update(event);

    _state = _state.newState(events: events);
    notifyListeners();
  }
}
