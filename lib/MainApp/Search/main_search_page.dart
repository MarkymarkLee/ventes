import 'package:flutter/material.dart';
import 'package:ventes/Functions/events_data.dart';
import 'package:ventes/data.dart';
import 'package:ventes/MainApp/Search/components.dart';
import 'package:ventes/MainApp/Search/event_dialog.dart';
import 'package:ventes/Components/loading_components.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<List<Event>> allEvents = EventsData.getAllEvents();
  String sortMethod = "time↑";

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

  // TODO
  bool matchRequirements(Event event) {
    return true;
  }

  // TODO
  bool matchFilter(Event event) {
    return true;
  }

  // TODO
  bool matchSearch(Event event) {
    return true;
  }

  // TODO
  sortEvents(List<Event> events) {
    events.sort((a, b) => a.date.compareTo(b.date));
  }

  List<Event> preprocessEvents(List<Event> events) {
    List<Event> validEvents = [];
    for (Event event in events) {
      if (!matchRequirements(event)) {
        continue;
      }
      if (!matchFilter(event)) {
        continue;
      }
      if (!matchSearch(event)) {
        continue;
      }
      validEvents.add(event);
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
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Filter"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Sort by:"),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
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
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
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
                preprocessEvents(events);

                if (events.isEmpty) {
                  return const Center(child: Text("No events found"));
                }

                return Scrollbar(
                  thickness: 10,
                  radius: const Radius.circular(5.0),
                    child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return EventCard(
                      event: events[index],
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
