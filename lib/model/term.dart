import 'package:flutter/material.dart';

class Term {
  final int id;
  final String title;
  final Color color;
  final Color background;
  Term(this.id, this.title, this.color, [this.background = Colors.white]);
}

final workTerms = [
  Term(0, '早番', Colors.white, Colors.black),
  Term(1, '遅番', Colors.black),
  Term(2, '休み', Colors.green),
];
