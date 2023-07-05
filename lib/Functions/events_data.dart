import 'package:ventes/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class EventsData {
  static CollectionReference events =
      FirebaseFirestore.instance.collection('events');

  static Future<void> addEvent(String id, Map<String, dynamic> data) {
    return events.doc(id).set(data);
  }

  static Future<void> updateEvent(String id, Map<String, dynamic> data) {
    return events.doc(id).update(data);
  }

  static Future<List<Event>> getAllEvents() async {
    List<Event> eventsList = [];
    await events.get().then((snapshot) {
      for (var doc in snapshot.docs) {
        try {
          var event = Event.fromJson(doc.data());
          eventsList.add(event);
        } catch (e) {
          print(e);
        }
      }
    });
    return eventsList;
  }

  static void clearEvents() async {
    await events.get().then((snapshot) async {
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    });
  }
}
