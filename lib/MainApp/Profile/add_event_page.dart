import 'package:flutter/material.dart';
import 'package:ventes/data.dart';

Event createdEvent = Event(
  title: "",
  description: "",
  date: "date",
  time: "time",
  location: "location",
  image: "image",
  eventID: "eventID",
  likes: 0,
);

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Column(
        children: [
          Text("Add Event Page"),
        ],
      )),
    );
  }
}
