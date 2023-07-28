import 'package:flutter/material.dart';
import 'package:ventes/Functions/events_data.dart';
import 'package:ventes/Functions/users_data.dart';
import 'package:ventes/data.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final dynamic onTap;
  const EventCard({super.key, required this.event, required this.onTap});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.event);
      },
      child: Card(
        // color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
        child: Column(
          children: [
            Text(widget.event.title),
            Text(dateText(widget.event.startTime!)),
            if (widget.event.location.isNotEmpty)
              Text("Location: ${widget.event.location}"),
            LikesButton(event: widget.event),
            JoinedPeople(event: widget.event),
          ],
        ),
      ),
    );
  }
}

class LikesButton extends StatefulWidget {
  final Event event;
  const LikesButton({super.key, required this.event});

  @override
  State<LikesButton> createState() => _LikesButtonState();
}

class _LikesButtonState extends State<LikesButton> {
  void addLike() {
    EventsData.updateEvent(
        widget.event.eventID, {"likes": widget.event.likes + 1});
    currentUser.likedEvents.add(widget.event.eventID);
    UsersData.updateUser(
        currentUser.email, {"likedEvents": currentUser.likedEvents});
    setState(() {
      widget.event.likes++;
    });
  }

  void removelike() {
    EventsData.updateEvent(
        widget.event.eventID, {"likes": widget.event.likes - 1});
    currentUser.likedEvents.remove(widget.event.eventID);
    UsersData.updateUser(
        currentUser.email, {"likedEvents": currentUser.likedEvents});
    setState(() {
      widget.event.likes--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () {
              if (currentUser.likedEvents.contains(widget.event.eventID)) {
                removelike();
              } else {
                addLike();
              }
            },
            icon: Icon(
              Icons.favorite,
              color: currentUser.likedEvents.contains(widget.event.eventID)
                  ? Colors.red
                  : Colors.black,
            )),
        Text(widget.event.likes.toString()),
      ],
    );
  }
}

class JoinedPeople extends StatefulWidget {
  final Event event;
  const JoinedPeople({super.key, required this.event});

  @override
  State<JoinedPeople> createState() => _JoinedPeopleState();
}

class _JoinedPeopleState extends State<JoinedPeople> {
  @override
  Widget build(BuildContext context) {
    return widget.event.maxPeople == 0
        ? Text("${widget.event.currentPeople}")
        : Text("${widget.event.currentPeople}/${widget.event.maxPeople}");
  }
}
