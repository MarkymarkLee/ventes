import 'package:flutter/material.dart';
import 'package:ventes/MainApp/Search/components.dart';
import 'package:ventes/data.dart';
import 'package:ventes/Functions/users_data.dart';
import 'package:ventes/Functions/events_data.dart';

class EventDialog extends StatefulWidget {
  final Event event;
  const EventDialog({super.key, required this.event});

  @override
  State<EventDialog> createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  void joinEvent() {
    currentUser.joinedEvents.add(widget.event.eventID);
    UsersData.updateUser(
        currentUser.email, {"joinedEvents": currentUser.joinedEvents});
    EventsData.updateEvent(widget.event.eventID,
        {"currentPeople": widget.event.currentPeople + 1});
    setState(() {});
  }

  void leaveEvent() {
    currentUser.joinedEvents.remove(widget.event.eventID);
    UsersData.updateUser(
        currentUser.email, {"joinedEvents": currentUser.joinedEvents});
    EventsData.updateEvent(widget.event.eventID,
        {"currentPeople": widget.event.currentPeople - 1});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.event.title),
            Text(dateText(widget.event.startTime!)),
            Text(widget.event.description),
            Text("Location: ${widget.event.location}"),
            LikesButton(event: widget.event),
            Wrap(
              children: [
                for (var tag in widget.event.tags)
                  Chip(
                    label: Text(tag),
                  )
              ],
            ),
            if (!currentUser.joinedEvents.contains(widget.event.eventID))
              TextButton(
                onPressed: () {
                  joinEvent();
                },
                child: Text("Join Event"),
              )
            else
              TextButton(
                onPressed: () {
                  leaveEvent();
                },
                child: Text("Leave Event"),
              )
          ],
        ),
      ),
    );
  }
}
