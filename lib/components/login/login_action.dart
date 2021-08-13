import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'login_state.dart';

class LoginAction extends ChangeNotifier {
  LoginState _state;

  LoginAction({LoginState state = const LoginState()}) : this._state = state;

  LoginState get state => _state;
  bool get hasUser => _state.user != null;

  void updateEmail(String email) {
    _state = _state.newState(email: email);
    notifyListeners();
  }

  void updatePassword(String password) {
    _state = _state.newState(password: password);
    notifyListeners();
  }

  void updateConnetingState(bool connecting) {
    _state = _state.newState(connecting: connecting);
    notifyListeners();
  }

  Future<void> login() async {
    updateConnetingState(true);
    try {
      // await Future.delayed(Duration(seconds: 3));
      // メール/パスワードでログイン
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _state.email,
        password: _state.password,
      );
    } catch (e) {
      print("ログインNG：${e.toString()}");
      updateConnetingState(false);
    }
  }
}
