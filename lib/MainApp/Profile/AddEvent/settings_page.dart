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
  bool limitPeople = false;
  bool limitGender = false;
  bool groupChat = false;
  bool hostChat = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Advanced Settings
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
              Row(
                children: [
                  const Expanded(
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: "A limit on "),
                      TextSpan(
                          text: "the number of people ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.pink)),
                      TextSpan(text: "?"),
                    ])),
                  ),
                  Switch(
                      value: limitPeople,
                      activeColor: const Color.fromARGB(255, 47, 10, 255),
                      onChanged: (bool value) {
                        setState(() {
                          limitPeople = value;
                          if (value) {
                            createdEvent.maxPeople = 50;
                          } else {
                            createdEvent.maxPeople = 0;
                          }
                        });
                      }),
                ],
              ),
              if (createdEvent.maxPeople != 0)
                SizedBox(
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
              Row(
                children: [
                  const Expanded(
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: "A limit on "),
                      TextSpan(
                          text: "which gender ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.pink)),
                      TextSpan(text: "?"),
                    ])),
                  ),
                  Switch(
                      value: limitGender,
                      activeColor: const Color.fromARGB(255, 47, 10, 255),
                      onChanged: (bool value) {
                        setState(() {
                          limitGender = value;
                          if (value) {
                            createdEvent.genderLimit = "male";
                          } else {
                            createdEvent.genderLimit = "all";
                          }
                        });
                      }),
                ],
              ),
              if (createdEvent.genderLimit != "all")
                SizedBox(
                  child: Column(
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
                ),
              const SizedBox(height: 10),
              const Divider(thickness: 2),
              const SizedBox(height: 10),
              // need group chat?
              Row(
                children: [
                  const Expanded(
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: "Want to have a "),
                      TextSpan(
                          text: "group chat ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.pink)),
                      TextSpan(text: "?"),
                    ])),
                  ),
                  Switch(
                      value: groupChat,
                      activeColor: const Color.fromARGB(255, 47, 10, 255),
                      onChanged: (bool value) {
                        setState(() {
                          groupChat = value;
                          createdEvent.needGroupChat = value;
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 2),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Expanded(
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: "Can people"),
                      TextSpan(
                          text: "message the host ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.pink)),
                      TextSpan(text: "before they join?"),
                    ])),
                  ),
                  Switch(
                      value: hostChat,
                      activeColor: const Color.fromARGB(255, 47, 10, 255),
                      onChanged: (bool value) {
                        setState(() {
                          hostChat = value;
                          createdEvent.chatWithHost = value;
                        });
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
