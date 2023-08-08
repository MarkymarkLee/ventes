import 'package:flutter/material.dart';
import 'package:ventes/Styles/text_style.dart';
import 'globals.dart';

// This is the second page for the add event process
// should add limits to who can join or the requirements for this event
class SettingsPage extends StatefulWidget {
  final String maxPeopleError;
  const SettingsPage({super.key, this.maxPeopleError = ""});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(child: Container()),
                const Icon(
                  Icons.settings_outlined,
                  size: 30,
                ),
                const SizedBox(width: 5),
                Text("Advanced Settings",
                    style: MyTextStyle.bodyLarge(context)),
                Expanded(child: Container()),
              ]),
              const SizedBox(height: 10),
              // Number of people to join
              const Text(
                  "Is there a limit to the number of people who can join?"),
              Row(
                children: [
                  Expanded(child: Container()),
                  const Text("Yes"),
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
                  const Text("No"),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Maximum number of people: "),
                      const SizedBox(width: 10),
                      Flexible(
                        child: TextField(
                          controller: TextEditingController(
                              text: createdEvent.maxPeople.toString()),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value == "") {
                              createdEvent.maxPeople = 0;
                            } else {
                              createdEvent.maxPeople = int.parse(value);
                            }
                          },
                          decoration: InputDecoration(
                            errorText: widget.maxPeopleError == ""
                                ? null
                                : widget.maxPeopleError,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              gapPadding: 2,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              gapPadding: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 10),
              const Divider(thickness: 2),
              const SizedBox(height: 10),
              // gender limit
              const Text(
                  "Is there a limit to the gender of people who can join?"),
              Row(
                children: [
                  Expanded(child: Container()),
                  const Text("Yes"),
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
                  const Text("No"),
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
                Column(
                  children: [
                    const Row(
                      children: [
                        Text("Which gender can join?"),
                        Expanded(child: SizedBox(width: 10)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        const Text("male"),
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
                        const Text("female"),
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
                        const Text("others"),
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
                  ],
                ),

              const SizedBox(height: 10),
              const Divider(thickness: 2),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              const Divider(thickness: 2),
              const SizedBox(height: 10),
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
        ),
      ),
    );
  }
}
