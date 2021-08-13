import 'package:flutter/widgets.dart';
import 'package:time_controller/model/event.dart';

@immutable
class ListState {
  final int month;
  final List<Event> events;

  const ListState({
    required this.month,
    this.events = const [],
  });

  ListState newState({
    int? month,
    List<Event>? events,
  }) {
    return ListState(
      month: month ?? this.month,
      events: events ?? this.events,
    );
  }
}
