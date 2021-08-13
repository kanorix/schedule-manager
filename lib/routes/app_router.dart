import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_controller/components/home/home_screen.dart';
import 'package:time_controller/components/login/login_screen.dart';
import 'package:time_controller/components/root/root_screen.dart';

class SimpleHandler extends Handler {
  SimpleHandler(
    Widget? Function() handlerFunc,
  ) : super(handlerFunc: (_, __) => handlerFunc());
}

class HandlerWithArgs<T> extends Handler {
  HandlerWithArgs(
    Widget? Function(T, Map<String, dynamic>) builder, {
    Widget? Function()? orElse,
  }) : super(
          handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
            final args = context?.settings?.arguments as T?;
            if (args != null) {
              return builder(args, params);
            }
            return orElse == null ? Placeholder() : orElse();
          },
        );
}

class AppRouter {
  final FluroRouter _router;

  final _rootHandler = SimpleHandler(() => RootScreen());
  final _loginHandler = SimpleHandler(() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    // 現在のユーザーがいるならホームに飛ばす
    return currentUser == null ? LoginScreen() : HomeScreen(user: currentUser);
  });

  final _homeHandler = HandlerWithArgs<User>(
    (user, _) => HomeScreen(user: user),
  );

  final _notFoundHandler = SimpleHandler(() => LoginScreen());

  AppRouter(this._router) {
    _router.notFoundHandler = _notFoundHandler;
    _router.define('/', handler: _rootHandler);
    _router.define('/login', handler: _loginHandler);
    _router.define('/home/:tab', handler: _homeHandler);
  }

  FluroRouter get router => _router;

  push(BuildContext context, String path, {Object? args}) {
    print('push >> [$path]');
    router.navigateTo(
      context,
      path,
      routeSettings: RouteSettings(arguments: args),
    );
  }
}
