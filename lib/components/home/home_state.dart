import 'package:flutter/widgets.dart';

@immutable
class HomeState {
  final int currentIndex;

  const HomeState({
    this.currentIndex = 0,
  });

  HomeState newState({
    int? currentIndex,
  }) {
    return HomeState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
