import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_controller/components/home/home_screen.dart';
import 'package:time_controller/components/login/login_screen.dart';
import 'package:time_controller/components/root/root_screen.dart';

class AppRouter {

  final FluroRouter _router;

  final _rootHandler = Handler(handlerFunc: (_, Map<String, dynamic> params) {
    return RootScreen();
  });

  final _loginHandler = Handler(handlerFunc: (_, Map<String, dynamic> params) {
    return LoginScreen();
  });

  final _homeHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    print(params['tab'][0]);
    final user = context?.settings?.arguments as User?;
    if (user != null) {
      return HomeScreen(user: user);
    }
    return Scaffold(body: LoginScreen());
  });

  final _notFoundHandler = Handler(handlerFunc: (_, Map<String, dynamic> params) {
    return Scaffold(body: LoginScreen());
  });

  AppRouter(this._router) {
    _router.notFoundHandler = _notFoundHandler;
    _router.define('/', handler: _rootHandler);
    _router.define('/login', handler: _loginHandler);
    _router.define('/home/:tab', handler: _homeHandler);
  }

  FluroRouter get router => _router;
}