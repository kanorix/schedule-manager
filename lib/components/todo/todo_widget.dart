import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoWidget extends StatelessWidget {
  // const HomeScreen({Key? key, required User user}) : super(key: key);
  const TodoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _TodoWidget();
  }
}

class _TodoWidget extends StatelessWidget {
  _TodoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TodoItem(
            title: 'アーキ課題',
          ),
          TodoItem(
            title: 'アーキ課題',
            subTitles: [
              '- [ ] 図面A',
              '- [x] 図面B',
              '- [x] 図面C',
              '- [x] 図面D',
            ],
          ),
          TodoItem(
            title: 'アーキ課題',
          ),
          TodoItem(
            title: 'ソフトウェア課題',
          ),
        ],
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  final String title;
  final List<String> subTitles;
  TodoItem({this.title = '', this.subTitles = const []});

  final regexp = RegExp(r'- \[x\]');

  int get finishedSubSize => subTitles.where((e) => regexp.hasMatch(e)).length;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        color: Theme.of(context).backgroundColor,
      ),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                LinearProgressIndicator(
                    value: subTitles.length == 0
                        ? 0.0
                        : finishedSubSize.toDouble() / subTitles.length),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(20),
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(Icons.check_box_outline_blank_rounded),
                          ),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .fontSize,
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Icon(Icons.edit),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Icon(Icons.expand_more_rounded),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          for (var item in subTitles)
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: 50, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Icon(
                          RegExp(r'- \[x\]').hasMatch(item)
                              ? Icons.check_box_rounded
                              : Icons.check_box_outline_blank_rounded,
                          size: Theme.of(context).textTheme.headline6!.fontSize,
                        ),
                      ),
                      Text(
                        item
                            .replaceFirst('- [ ]', '')
                            .replaceFirst('- [x]', ''),
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline6!.fontSize,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
