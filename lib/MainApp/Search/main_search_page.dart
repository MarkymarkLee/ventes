import 'package:flutter/material.dart';
import 'package:ventes/Functions/events_data.dart';
import 'package:ventes/data.dart';
import 'package:ventes/MainApp/Search/components.dart';
import 'package:ventes/MainApp/Search/event_dialog.dart';
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

  onTap(Event event) {
    showDialog(
      context: context,
      builder: (context) {
        return EventDialog(event: event);
      },
    );
  }

  setEvents() {
    setState(() {
      allEvents = EventsData.getAllEvents();
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
    // if (filter["tag"] != "" &&
    //     !event.tags.contains(filter["tag"].toString().toLowerCase())) {
    //   match = false;
    // }
    if (filter["eventName"] != "" &&
        !event.title
            .toLowerCase()
            .contains(filter["eventName"].toString().toLowerCase())) {
      match = false;
    }
    return match;
  }

  // TODO
  bool matchSearch(Event event) {
    return true;
  }

  sortEvents(List<Event> events) {
    if (sortMethod == "time↑") {
      events.sort((a, b) => a.startTime!.isBefore(b.startTime!) ? -1 : 1);
    } else if (sortMethod == "time↓") {
      events.sort((a, b) => a.startTime!.isBefore(b.startTime!) ? 1 : -1);
    } else if (sortMethod == "likes") {
      events.sort((a, b) => a.likes > b.likes ? -1 : 1);
    }
  }

  List<Event> preprocessEvents(List<Event> events) {
    List<Event> validEvents = [];
    for (Event event in events) {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        // title and refresh button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Search", style: TextStyle(fontSize: 20)),
            ),
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
