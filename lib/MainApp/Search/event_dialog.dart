import 'package:flutter/material.dart';
import 'package:ventes/Components/components.dart';
import 'package:ventes/MainApp/Search/components.dart';
import 'package:ventes/Styles/text_style.dart';
import 'package:ventes/data.dart';

class EventDialog extends StatefulWidget {
  final Event event;
  final Function addLike;
  final Function removeLike;
  final Function joinEvent;
  final Function leaveEvent;
  const EventDialog(
      {super.key,
      required this.event,
      required this.addLike,
      required this.removeLike,
      required this.joinEvent,
      required this.leaveEvent});

  @override
  State<EventDialog> createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child:
              Text(widget.event.title, style: MyTextStyle.display1(context))),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // time
            Row(
              children: [
                const Icon(Icons.event_available_outlined),
                const SizedBox(width: 5),
                Text(
                  "Time :",
                  style: MyTextStyle.bodyCustomFontsize(context, 14),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              eventDateRange(
                  widget.event.startDate!, widget.event.endDate!, true, true),
              style: MyTextStyle.titleSmall(context),
              maxLines: 2,
            ),
            const SizedBox(height: 15),

            // location
            Row(
              children: [
                const Icon(Icons.place_outlined),
                const SizedBox(width: 5),
                Text(
                  "Location : ",
                  style: MyTextStyle.bodyCustomFontsize(context, 14),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.event.location,
              style: MyTextStyle.titleSmall(context),
              maxLines: 3,
            ),
            const SizedBox(height: 15),

            // joined people and likes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                JoinedPeople(event: widget.event),
                const SizedBox(width: 10),
                Expanded(
                    child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color:
                          currentUser.likedEvents.contains(widget.event.eventID)
                              ? Colors.red
                              : Colors.black,
                    ),
                    const SizedBox(width: 5),
                    MyOverFlowText(
                      text: widget.event.likes.toString(),
                      style: MyTextStyle.titleSmall(context),
                      maxLines: 1,
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 15),
            // host
            Row(
              children: [
                const Icon(Icons.email_outlined),
                const SizedBox(width: 5),
                MyOverFlowText(
                  text: "Host email : ",
                  style: MyTextStyle.bodyCustomFontsize(context, 14),
                  maxLines: 1,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.event.hostID,
              style: MyTextStyle.titleSmall(context),
            ),
            const SizedBox(height: 15),
            // tags
            if (widget.event.tags.isNotEmpty)
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.label),
                      const SizedBox(width: 5),
                      MyOverFlowText(
                        text: "Tags :",
                        style: MyTextStyle.bodyCustomFontsize(context, 14),
                        maxLines: 1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 5,
                    children: widget.event.tags
                        .map((e) => Chip(
                              label: Text(e,
                                  style: MyTextStyle.bodySmall(context)),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 15),
                ],
              ),

            // description
            if (widget.event.description != "")
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.description_outlined),
                      const SizedBox(width: 5),
                      MyOverFlowText(
                        text: "Details for this event :",
                        style: MyTextStyle.bodyCustomFontsize(context, 14),
                        maxLines: 1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.event.description,
                    style: MyTextStyle.titleSmall(context),
                    maxLines: 5,
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("GOT IT"),
        ),
        TextButton(
            onPressed: () {
              if (currentUser.likedEvents.contains(widget.event.eventID)) {
                widget.removeLike(widget.event);
                Navigator.pop(context);
              } else {
                widget.addLike(widget.event);
                Navigator.pop(context);
              }
            },
            child: Text(
              currentUser.likedEvents.contains(widget.event.eventID)
                  ? "DISLIKE"
                  : "LIKE",
              style: TextStyle(
                  color: currentUser.likedEvents.contains(widget.event.eventID)
                      ? Colors.black
                      : Colors.red),
            )),
        if (currentUser.joinedEvents.contains(widget.event.eventID))
          TextButton(
            onPressed: () {
              widget.leaveEvent(widget.event);
              Navigator.pop(context);
            },
            child: const Text(
              "LEAVE",
              style: TextStyle(color: Colors.black),
            ),
          )
        else if (widget.event.currentPeople < widget.event.maxPeople ||
            widget.event.maxPeople == 0)
          TextButton(
            onPressed: () {
              widget.joinEvent(widget.event);
              Navigator.pop(context);
            },
            child: const Text(
              "JOIN",
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
