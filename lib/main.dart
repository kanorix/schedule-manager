import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:time_controller/config/application_config.dart';
import 'package:time_controller/routes/app_router.dart';

import 'config/theme_config.dart';

Future<void> main() async {
  // Firebase初期化
  await Firebase.initializeApp();
  config();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // debugのバーナーを出すかどうか
      debugShowCheckedModeBanner: false,
      // テーマの設定
      theme: ThemeConfig.light(),
      darkTheme: ThemeConfig.dark(),
      themeMode: ThemeMode.system,
      onGenerateRoute: GetIt.I<AppRouter>().router.generator,
    );
  }
}
