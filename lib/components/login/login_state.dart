import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

@immutable
class LoginState {
  final String email;
  final String password;
  final User? user;
  final bool connecting;

  const LoginState({
    this.email = '',
    this.password = '',
    this.user,
    this.connecting = false,
  });

  LoginState newState({
    String? email,
    String? password,
    User? user,
    bool? connecting,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        user: user ?? this.user,
        connecting: connecting ?? this.connecting);
  }
}
