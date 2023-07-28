import 'package:ventes/data.dart';
import 'package:ventes/Functions/events_data.dart';
import 'dart:math';

String getRandomString(int length) {
  const allChars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  // ignore: non_constant_identifier_names
  Random RNG = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => allChars.codeUnitAt(RNG.nextInt(allChars.length))));
}

abstract class RandomEvent {
  static void addEvent() {
    String id = getRandomString(20);
    Event event = Event(
      eventID: id,
      title: "title$id",
      description: "description$id",
      image: "image$id",
      location: "location$id",
      likes: 0,
    );
    EventsData.addEvent(id, event.toJson());
  }

  static void clearEvents() {
    EventsData.clearEvents();
  }
}
