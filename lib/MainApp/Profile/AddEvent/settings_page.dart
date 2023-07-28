import 'package:flutter/material.dart';
import 'globals.dart';

// This is the second page for the add event process
// should add limits to who can join or the requirements for this event
class SettingsPage extends StatefulWidget {
  final String maxPeopleError;
  SettingsPage({super.key, this.maxPeopleError = ""});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String maxPeopleError = "";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Settings"),

          // Number of people to join
          Text("Is there a limit to the number of people who can join?"),
          Row(
            children: [
              Expanded(child: Container()),
              Text("Yes"),
              Radio(
                value: false,
                groupValue: createdEvent.maxPeople == 0,
                onChanged: (value) {
                  setState(() {
                    createdEvent.maxPeople = 50;
                  });
                },
              ),
              Expanded(child: Container()),
              Text("No"),
              Radio(
                value: true,
                groupValue: createdEvent.maxPeople == 0,
                onChanged: (value) {
                  setState(() {
                    createdEvent.maxPeople = 0;
                  });
                },
              ),
              Expanded(child: Container()),
            ],
          ),
          if (createdEvent.maxPeople != 0)
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(child: Container()),
                  Text("Maximum number of people: "),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextField(
                      controller: TextEditingController(
                          text: createdEvent.maxPeople.toString()),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        createdEvent.maxPeople = int.parse(value);
                      },
                    ),
                  ),
                  Text("people"),
                  Expanded(child: Container()),
                ],
              ),
            ),
          if (widget.maxPeopleError != "")
            Text(
              widget.maxPeopleError,
              style: TextStyle(color: Colors.red),
            ),

          // gender limit
          Text("Is there a limit to the gender of people who can join?"),
          Row(
            children: [
              Expanded(child: Container()),
              Text("Yes"),
              Radio(
                value: false,
                groupValue: createdEvent.genderLimit == "all",
                onChanged: (value) {
                  setState(() {
                    createdEvent.genderLimit = "male";
                  });
                },
              ),
              Expanded(child: Container()),
              Text("No"),
              Radio(
                value: true,
                groupValue: createdEvent.genderLimit == "all",
                onChanged: (value) {
                  setState(() {
                    createdEvent.genderLimit = "all";
                  });
                },
              ),
              Expanded(child: Container()),
            ],
          ),
          if (createdEvent.genderLimit != "all")
            Row(
              children: [
                Expanded(child: Container()),
                Text("male"),
                Radio(
                  value: true,
                  groupValue: createdEvent.genderLimit == "male",
                  onChanged: (value) {
                    setState(() {
                      createdEvent.genderLimit = "male";
                    });
                  },
                ),
                Expanded(child: Container()),
                Text("female"),
                Radio(
                  value: true,
                  groupValue: createdEvent.genderLimit == "female",
                  onChanged: (value) {
                    setState(() {
                      createdEvent.genderLimit = "female";
                    });
                  },
                ),
                Expanded(child: Container()),
                Text("others"),
                Radio(
                  value: true,
                  groupValue: createdEvent.genderLimit == "others",
                  onChanged: (value) {
                    setState(() {
                      createdEvent.genderLimit = "others";
                    });
                  },
                ),
                Expanded(child: Container()),
              ],
            ),

          // need group chat?
          Text("Should the event have a group chat?"),
          Row(
            children: [
              Expanded(child: Container()),
              Text("Yes"),
              Radio(
                value: true,
                groupValue: createdEvent.needGroupChat,
                onChanged: (value) {
                  setState(() {
                    createdEvent.needGroupChat = true;
                  });
                },
              ),
              Expanded(child: Container()),
              Text("No"),
              Radio(
                value: false,
                groupValue: createdEvent.needGroupChat,
                onChanged: (value) {
                  setState(() {
                    createdEvent.needGroupChat = false;
                  });
                },
              ),
              Expanded(child: Container()),
            ],
          ),

          Text("Can users directly message the host before they join?"),
          Row(
            children: [
              Expanded(child: Container()),
              Text("Yes"),
              Radio(
                value: true,
                groupValue: createdEvent.chatWithHost,
                onChanged: (value) {
                  setState(() {
                    createdEvent.chatWithHost = true;
                  });
                },
              ),
              Expanded(child: Container()),
              Text("No"),
              Radio(
                value: false,
                groupValue: createdEvent.chatWithHost,
                onChanged: (value) {
                  setState(() {
                    createdEvent.chatWithHost = false;
                  });
                },
              ),
              Expanded(child: Container()),
            ],
          ),
        ],
      ),
    );
  }
}
