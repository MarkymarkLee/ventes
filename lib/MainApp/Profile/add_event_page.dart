import 'package:flutter/material.dart';
import 'package:ventes/Components/components.dart';
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
  void back() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: (Column(
        children: [
          Expanded(child: Container()),
          const Text("Add Event"),
          MyButton(onTap: back, buttonText: "Go back"),
          Expanded(child: Container()),
        ],
      )),
    )));
  }
}
