class Event {
  int termId;
  int month;
  int day;
  String? docId;
  Event({required this.month, required this.day, this.termId = -1});
  Event.fromMap(Map<String, dynamic> map, {String? docId})
      : this.month = map['month'],
        this.day = map['day'],
        this.termId = map['termId'],
        this.docId = docId;
  Map<String, dynamic> toMap({String userId = ''}) {
    return {
      'termId': this.termId,
      'month': this.month,
      'day': this.day,
      'userId': userId,
    };
  }
}
