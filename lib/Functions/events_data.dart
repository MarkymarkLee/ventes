import 'package:flutter/material.dart';
import 'package:ventes/Functions/users_data.dart';
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
          debugPrint("error in parsing event");
        }
      }
    });
    return eventsList;
  }

  static void clearEvents(String hostID) async {
    await events.get().then((snapshot) async {
      for (var doc in snapshot.docs) {
        if (doc.get('hostID') == hostID) {
          for (var joinedEmail in doc.get('joinedID')) {
            await UsersData.removeEventsFromUser(
                joinedEmail, "joinedEvents", doc.get('eventID'));
          }
          for (var likedEmail in doc.get('likedID')) {
            await UsersData.removeEventsFromUser(
                likedEmail, "likedEvents", doc.get('eventID'));
          }

          await UsersData.removeEventsFromUser(
              doc.get('hostID'), "createdEvents", doc.get('eventID'));
          await doc.reference.delete();
        }
      }
    });
  }

  static Future<void> removeEvent(String eventID) async {
    await events.doc(eventID).get().then((snapshot) async {
      for (var joinedEmail in snapshot.get('joinedID')) {
        await UsersData.removeEventsFromUser(
            joinedEmail, "joinedEvents", snapshot.get('eventID'));
      }
      for (var likedEmail in snapshot.get('likedID')) {
        await UsersData.removeEventsFromUser(
            likedEmail, "likedEvents", snapshot.get('eventID'));
      }

      await UsersData.removeEventsFromUser(
              snapshot.get('hostID'), "createdEvents", snapshot.get('eventID'))
          .then((value) async {
        await snapshot.reference.delete();
      });
    });
  }

  static void removeUsers(String email, String eventID, String type) async {
    await events.doc(eventID).get().then((snapshot) async {
      List<dynamic> users = snapshot.get(type);
      users.remove(email);
      await events.doc(eventID).update({type: users});
    });
  }

  static void addUsers(String email, String eventID, String type) async {
    await events.doc(eventID).get().then((snapshot) async {
      List<dynamic> users = snapshot.get(type);
      users.add(email);
      await events.doc(eventID).update({type: users});
    });
  }
}
