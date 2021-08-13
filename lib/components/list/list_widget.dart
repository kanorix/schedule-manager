import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:time_controller/model/event.dart';

import 'list_action.dart';

class ListWidget extends StatelessWidget {
  // const HomeScreen({Key? key, required User user}) : super(key: key);
  const ListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListAction>(
      create: (_) => ListAction(),
      child: _ListWidget(),
    );
  }
}

class _ListWidget extends StatelessWidget {
  _ListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ListAction>().state;
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: state.events.length,
        itemBuilder: (BuildContext context, int index) {
          return _Item(
            event: state.events[index],
          );
        },
      ),
    );
  }
}

class Term {
  final int id;
  final String title;
  final Color color;
  Term(this.id, this.title, this.color);
}

final workTerms = [
  Term(0, '早番', Colors.red),
  Term(1, '遅番', Colors.blue),
  Term(2, '休み', Colors.green),
];

class _Item extends StatelessWidget {
  final Event event;
  _Item({required this.event});

  get formattedDate =>
      '${event.month}'.padLeft(2, '0') + '/' + '${event.day}'.padLeft(2, '0');

  button(Term term, ListAction action) {
    return OutlinedButton(
      onPressed: () {
        action.updateTerm(event, term.id);
        print(term.id);
      },
      child: Text(term.title),
      style: (event.termId == term.id)
          ? OutlinedButton.styleFrom(
              primary: Colors.white,
              backgroundColor: term.color,
              side: const BorderSide(color: Colors.black),
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final action = context.read<ListAction>();
    return ListTile(
      subtitle: Row(
        children: [
          Text(formattedDate),
          VerticalDivider(),
          button(workTerms[0], action),
          Container(width: 2),
          button(workTerms[1], action),
          Container(width: 2),
          button(workTerms[2], action),
        ],
      ),
    );
  }
}
