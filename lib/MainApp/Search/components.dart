import 'package:flutter/material.dart';
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
            Text(widget.event.date),
            Text(widget.event.time),
            Text(widget.event.location),
            Text(widget.event.likes.toString()),
          ],
        ),
      ),
    );
  }
}
