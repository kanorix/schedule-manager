import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_controller/model/event.dart';

class EventRepository {
  late final CollectionReference<Event> ref;
  get userId => FirebaseAuth.instance.currentUser!.uid;
  late final Query<Event> defaultQuery;

  EventRepository() {
    final collectionRef = FirebaseFirestore.instance.collection('events');
    this.ref = collectionRef.withConverter<Event>(
      fromFirestore: (snapshots, _) => Event.fromMap(
        snapshots.data()!,
        docId: snapshots.id,
      ),
      toFirestore: (event, _) => event.toMap(userId: userId),
    );
    defaultQuery = ref.where('userId', isEqualTo: this.userId);
  }

  Future<List<Event>> findAll() async {
    final snapshot = await defaultQuery.get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  Future<List<Event>> findByMonth(int month) async {
    final snapshot = await defaultQuery.where('month', isEqualTo: month).get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  update(Event event) async {
    print(event.docId);
    if (event.docId == null) {
      final dref = await ref.add(event);
      event.docId = dref.id;
    } else {
      await ref.doc(event.docId).set(event);
    }
  }
}
