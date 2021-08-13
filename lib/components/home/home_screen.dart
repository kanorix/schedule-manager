import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_controller/components/calender/calender_widget.dart';
import 'package:time_controller/components/list/list_widget.dart';

import 'home_action.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({Key? key, required User user}) : super(key: key);
  const HomeScreen({Key? key, required User? user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeAction>(
      create: (_) => HomeAction(),
      child: _HomeWidget(),
    );
  }
}

enum HomeTab {
  // Calender,
  List,
  Account,
}

class HomeNavigationPair {
  final Widget Function(BuildContext) builder;
  final BottomNavigationBarItem item;
  HomeNavigationPair({required this.item, required this.builder});
}

class _HomeWidget extends StatelessWidget {
  _HomeWidget({Key? key}) : super(key: key);

  final Map<HomeTab, HomeNavigationPair> pair = {
    HomeTab.List: HomeNavigationPair(
        item: BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_today),
          label: 'calender',
        ),
        builder: (_) => ListWidget()),
    // HomeTab.Calender: HomeNavigationPair(
    //     item: BottomNavigationBarItem(
    //       icon: const Icon(Icons.today),
    //       label: 'today',
    //     ),
    //     builder: (_) => CalenderWidget()),
    HomeTab.Account: HomeNavigationPair(
        item: BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
          label: 'account',
        ),
        builder: (_) => Placeholder()),
  };

  @override
  Widget build(BuildContext context) {
    final action = context.read<HomeAction>();
    final currentIndex =
        context.select<HomeAction, int>((value) => value.state.currentIndex);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              print('sign out');
            },
          ),
        ],
      ),
      body: Builder(
        builder: pair[HomeTab.values.elementAt(currentIndex)]!.builder,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: HomeTab.values.map((e) => pair[e]!.item).toList(),
        currentIndex: currentIndex,
        onTap: (index) => action.updateIndex(index),
      ),
    );
  }
}
