import 'package:ventes/data.dart';
import 'package:ventes/Functions/events_data.dart';
import 'dart:math';

abstract class randomEvent {
  static String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static void addEvent() {
    String id = getRandomString(20);
    Event event = Event(
      eventID: id,
      title: "title$id",
      description: "description$id",
      date: "date$id",
      image: "image$id",
      time: "time$id",
      location: "location$id",
      likes: 0,
    );
    EventsData.addEvent(id, event.toJson());
  }

  static void clearEvents() {
    EventsData.clearEvents();
  }
}
