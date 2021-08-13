import 'package:flutter/material.dart';

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
