import 'package:flutter/material.dart';
import 'package:ventes/Styles/text_style.dart';
import 'package:ventes/data.dart';
import 'package:ventes/Components/components.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final Function addLike;
  final Function removeLike;
  final Function joinEvent;
  final Function leaveEvent;
  final dynamic onTap;
  const EventCard(
      {super.key,
      required this.event,
      required this.addLike,
      required this.removeLike,
      required this.joinEvent,
      required this.leaveEvent,
      required this.onTap});

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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "images/logo.png",
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  Container(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 5),
                        Text(widget.event.title,
                            style: MyTextStyle.display1(context)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.event_available_outlined,
                            ),
                            const SizedBox(width: 5),
                            MyOverFlowText(
                              text: eventDateRange(widget.event.startDate!, widget.event.endDate!, false, false),
                              style: MyTextStyle.titleSmall(context),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        if (widget.event.location.isNotEmpty)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.place_outlined,
                              ),
                              const SizedBox(width: 5),
                              MyOverFlowText(
                                text: widget.event.location,
                                style: MyTextStyle.titleSmall(context),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            JoinedPeople(event: widget.event),
                            const SizedBox(width: 10),
                            LikesButton(
                                event: widget.event,
                                addLike: widget.addLike,
                                removeLike: widget.removeLike),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      currentUser.likedEvents.contains(widget.event.eventID)
                          ? MyTextButton(
                              buttonText: "DISLIKE",
                              onTap: () {
                                widget.removeLike(widget.event);
                              },
                            )
                          : MyTextButton(
                              buttonText: "LIKE",
                              onTap: () {
                                widget.addLike(widget.event);
                              },
                              textColor: Colors.red,
                            ),
                      const SizedBox(height: 5),
                      currentUser.joinedEvents.contains(widget.event.eventID)
                          ? MyTextButton(
                              buttonText: "LEAVE",
                              onTap: () {
                                widget.leaveEvent(widget.event);
                              },
                            )
                          : MyTextButton(
                              buttonText: "JOIN",
                              onTap: () {
                                widget.joinEvent(widget.event);
                              },
                              textColor: Colors.red,
                            ),
                    ],
                  )
                ],
              ))),
    );
  }
}

class LikesButton extends StatefulWidget {
  final Event event;
  final Function addLike;
  final Function removeLike;
  const LikesButton(
      {super.key,
      required this.event,
      required this.addLike,
      required this.removeLike});

  @override
  State<LikesButton> createState() => _LikesButtonState();
}

class _LikesButtonState extends State<LikesButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () {
              if (currentUser.likedEvents.contains(widget.event.eventID)) {
                widget.removeLike(widget.event);
              } else {
                widget.addLike(widget.event);
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
        ? Expanded(
            child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.people_outlined,
              ),
              const SizedBox(width: 5),
              MyOverFlowText(
                text: widget.event.currentPeople.toString(),
                style: MyTextStyle.titleSmall(context),
                maxLines: 1,
              ),
            ],
          ))
        : Expanded(
            child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.people_outlined,
              ),
              const SizedBox(width: 5),
              MyOverFlowText(
                text: "${widget.event.currentPeople}/${widget.event.maxPeople}",
                style: MyTextStyle.titleSmall(context),
                maxLines: 1,
              ),
            ],
          ));
  }
}
