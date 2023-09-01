import 'package:flutter/material.dart';
import 'package:ventes/Components/loading_components.dart';
import 'package:ventes/Functions/events_data.dart';
import 'package:ventes/MainApp/MyEvents/AddEvent/add_event_page.dart';
import 'package:ventes/MainApp/event_card.dart';
import 'package:ventes/MainApp/event_dialog.dart';
import 'package:ventes/data.dart';

class MyEventsPage extends StatefulWidget {
  const MyEventsPage({super.key});

  @override
  State<MyEventsPage> createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage>
    with TickerProviderStateMixin {
  Future<List<Event>> allEvents = EventsData.getAllEvents();

  TabController? myTabsController;
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Created events', icon: Icon(Icons.edit)),
    Tab(text: 'Joined events', icon: Icon(Icons.login)),
    Tab(text: 'Liked events', icon: Icon(Icons.thumb_up)),
  ];

  setEvents() {
    setState(() {
      allEvents = EventsData.getAllEvents();
    });
  }

  extractMyEvents(List<Event> events) {
    List<Event> myEvents = [];
    for (var event in events) {
      if (event.hostID == currentUser.email) {
        myEvents.add(event);
      }
    }
    return myEvents;
  }

  extractJoinedEvents(List<Event> events) {
    List<Event> joinedEvents = [];
    for (var event in events) {
      if (currentUser.joinedEvents.contains(event.eventID)) {
        joinedEvents.add(event);
      }
    }
    return joinedEvents;
  }

  extractLikedEvents(List<Event> events) {
    List<Event> likedEvents = [];
    for (var event in events) {
      if (currentUser.likedEvents.contains(event.eventID)) {
        likedEvents.add(event);
      }
    }
    return likedEvents;
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

  @override
  void initState() {
    super.initState();
    myTabsController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: allEvents,
      builder: (context, snapshot) {
        if ((!snapshot.hasData) ||
            (snapshot.connectionState != ConnectionState.done)) {
          return const Loading();
        }

        List<Event> events = snapshot.data as List<Event>;
        List<Event> myEvents = extractMyEvents(events);
        List<Event> joinedEvents = extractJoinedEvents(events);
        List<Event> likedEvents = extractLikedEvents(events);

        return SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              TabBar(controller: myTabsController, tabs: myTabs),
              const SizedBox(height: 10),
              SizedBox(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: TabBarView(controller: myTabsController, children: [
                    myEvents.isEmpty
                        ? const Text(
                            "Sorry, you haven't created any events yet!")
                        : Wrap(
                            children: [
                              for (Event myEvent in myEvents)
                                EventCard(event: myEvent, onTap: onTap)
                            ],
                          ),
                    joinedEvents.isEmpty
                        ? const Text(
                            "Sorry, you haven't joined any events yet!")
                        : Wrap(
                            children: [
                              for (Event joinedEvent in joinedEvents)
                                EventCard(event: joinedEvent, onTap: onTap)
                            ],
                          ),
                    likedEvents.isEmpty
                        ? const Text("Sorry, you don't like any events!")
                        : Wrap(children: [
                            for (var likedEvent in likedEvents)
                              EventCard(event: likedEvent, onTap: onTap)
                          ]),
                  ])),
              ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddEventPage()),
                    );
                    setEvents();
                  },
                  child: const Text("Add a New Event")),
              ElevatedButton(
                  onPressed: () {
                    EventsData.clearEvents(currentUser.email);
                  },
                  child: const Text("Delete all Created Events")),
            ],
          ),
        ));
      },
    );
  }
}
