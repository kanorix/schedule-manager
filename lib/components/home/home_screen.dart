import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required User user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.ac_unit), 
        onPressed: () async {
            await FirebaseAuth.instance.signOut();
            print('sign out');
          },
        ),
      ),
      body: Center(child: Placeholder())
    );
  }
}