import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_controller/components/home/home_screen.dart';
import 'package:time_controller/components/login/login_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        print('this is root screen');

        if ((snapshot.hasData) && (!snapshot.data!.isAnonymous)) {
          return HomeScreen(user: snapshot.data!);
        }

        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          return HomeScreen(user: currentUser);
        }

        return LoginScreen();
      },
    );
  }
}
