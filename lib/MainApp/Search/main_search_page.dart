import 'package:flutter/material.dart';
import 'package:ventes/Functions/events_data.dart';
import 'package:ventes/Functions/users_data.dart';
import 'package:ventes/data.dart';
import 'package:ventes/MainApp/event_card.dart';
import 'package:ventes/MainApp/event_dialog.dart';
import 'package:ventes/MainApp/Search/filter_dialog.dart';
import 'package:ventes/Components/loading_components.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<List<Event>> allEvents = EventsData.getAllEvents();
  String sortMethod = "time↑";
  Map filter = {
    "minLikes": 0,
    "tags": "",
    "eventName": "",
  };

  onApplyFilter(Map filter) {
    debugPrint(filter.toString());
    setState(() {
      this.filter = filter;
    });
  }

  onTap(Event event) async {
    await showDialog(
      context: context,
      builder: (context) {
        return EventDialog(
          event: event,
        );
      },
    );
    setEvents();
  }

  setEvents() {
    setState(() {
      allEvents = EventsData.getAllEvents();
    });
  }

  addLike(Event event) {
    EventsData.updateEvent(event.eventID, {"likes": event.likes + 1});
    currentUser.likedEvents.add(event.eventID);
    UsersData.updateUser(
        currentUser.email, {"likedEvents": currentUser.likedEvents});
    setState(() {
      event.likes++;
    });
  }

  removeLike(Event event) {
    EventsData.updateEvent(event.eventID, {"likes": event.likes - 1});
    currentUser.likedEvents.remove(event.eventID);
    UsersData.updateUser(
        currentUser.email, {"likedEvents": currentUser.likedEvents});
    setState(() {
      event.likes--;
    });
  }

  joinEvent(Event event) {
    currentUser.joinedEvents.add(event.eventID);
    UsersData.updateUser(
        currentUser.email, {"joinedEvents": currentUser.joinedEvents});
    EventsData.updateEvent(
        event.eventID, {"currentPeople": event.currentPeople + 1});
    setState(() {
      event.currentPeople++;
    });
  }

  leaveEvent(Event event) {
    currentUser.joinedEvents.remove(event.eventID);
    UsersData.updateUser(
        currentUser.email, {"joinedEvents": currentUser.joinedEvents});
    EventsData.updateEvent(
        event.eventID, {"currentPeople": event.currentPeople - 1});
    setState(() {
      event.currentPeople--;
    });
  }

  Future<void> onNavigateFilter(BuildContext context) async {
    final filter = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FilterDialog()));
    if (!mounted) return;
    onApplyFilter(filter);
  }

  bool matchRequirements(Event event) {
    if (event.genderLimit != "all" && event.genderLimit != currentUser.gender) {
      return false;
    }
    return true;
  }

  // TODO
  bool matchFilter(Event event) {
    bool match = true;
    if (filter["minLikes"] > event.likes) {
      match = false;
    }
    if (filter["eventName"] != "" &&
        !event.title
            .toLowerCase()
            .contains(filter["eventName"].toString().toLowerCase())) {
      match = false;
    }
    bool tagsMatch = false;
    if (filter["tags"] == "" || filter["tags"].isEmpty) {
      tagsMatch = true;
    } else {
      for (String filterTag in filter["tags"]) {
        for (String eventTag in event.tags) {
          if (filterTag.toLowerCase() == eventTag.toLowerCase()) {
            tagsMatch = true;
            break;
          }
        }
        if (tagsMatch) break;
      }
    }

    return (match && tagsMatch);
  }

  // TODO
  bool matchSearch(Event event) {
    return true;
  }

  sortEvents(List<Event> events) {
    if (sortMethod == "time↑") {
      events.sort((a, b) => a.startDate!.isBefore(b.startDate!) ? -1 : 1);
    } else if (sortMethod == "time↓") {
      events.sort((a, b) => a.startDate!.isBefore(b.startDate!) ? 1 : -1);
    } else if (sortMethod == "likes") {
      events.sort((a, b) => a.likes > b.likes ? -1 : 1);
    }
  }

  List<Event> preprocessEvents(List<Event> events) {
    List<Event> validEvents = [];
    for (Event event in events) {
      // debugPrint("event: ${event.title}");
      bool valid = false;
      if (matchRequirements(event) &&
          matchFilter(event) &&
          matchSearch(event)) {
        valid = true;
      }
      if (valid) validEvents.add(event);
    }
    sortEvents(validEvents);
    return validEvents;
  }

  @override
  void initState() {
    super.initState();
    setEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // title and refresh button
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setEvents();
              },
            ),
          ],
        ),

        // Filter button and search bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  onNavigateFilter(context);
                },
                child: const Text("Filter"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Sort by:"),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: sortMethod,
                  items:
                      <String>["time↑", "time↓", "likes"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      sortMethod = newValue!;
                    });
                  },
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search',
                  ),
                  onSubmitted: (value) {},
                ),
              ),
            ),
          ],
        ),

        // List of events
        Expanded(
          child: FutureBuilder(
              future: allEvents,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Loading();
                }
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Loading();
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("Error"));
                }
                List<Event> events = snapshot.data as List<Event>;
                List<Event> validEvents = preprocessEvents(events);

                if (validEvents.isEmpty) {
                  return const Center(child: Text("No events found"));
                }

                return Scrollbar(
                    thickness: 10,
                    radius: const Radius.circular(5.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: validEvents.length,
                      itemBuilder: (context, index) {
                        return EventCard(
                          event: validEvents[index],
                          onTap: onTap,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    ));
              }),
        )
      ],
    );
  }
}
