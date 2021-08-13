import 'package:flutter/widgets.dart';

import 'home_state.dart';

class HomeAction extends ChangeNotifier {
  HomeState _state;

  HomeAction({HomeState state = const HomeState()}) : this._state = state;

  HomeState get state => _state;

  void updateIndex(int newIndex) {
    _state = _state.newState(currentIndex: newIndex);
    notifyListeners();
  }
}
