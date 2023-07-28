import 'package:flutter/material.dart';
import 'globals.dart';

// This is the first page for the add event process
// should add a title, description, date, time and location
class TitlePage extends StatefulWidget {
  final String titleError;
  TitlePage({super.key, this.titleError = ""});

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  bool? choosetime = false;
  DateTime date = createdEvent.startTime!;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Text("Add Event"),

            // Title textfield
            TextField(
              controller: TextEditingController(text: createdEvent.title),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "title",
              ),
              maxLength: 50,
              onChanged: (value) {
                createdEvent.title = value;
              },
            ),
            if (widget.titleError != "") Text(widget.titleError),

            // Description textfield
            TextField(
              controller: TextEditingController(text: createdEvent.description),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Description",
              ),
              maxLines: 50,
              minLines: 1,
              maxLength: 300,
              onChanged: (value) {
                createdEvent.description = value;
              },
            ),

            // Location textfield
            TextField(
              controller: TextEditingController(text: createdEvent.location),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Location",
              ),
              maxLength: 50,
              onChanged: (value) {
                createdEvent.location = value;
              },
            ),

            // Date/time fields
            Text("When is the event?"),

            Row(
              children: [
                Expanded(child: Container()),
                Text("Date: ${date.year}/${date.month}/${date.day}"),
                IconButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (newDate != null) {
                        setState(() {
                          date = newDate;
                        });
                        createdEvent.startTime = newDate;
                      }
                    },
                    icon: Icon(Icons.calendar_month_sharp)),
                Expanded(child: Container()),
              ],
            ),

            // Event length
            Text("How long is the event?"),
            DurationChooser(),
          ],
        ),
      ),
    );
  }
}

class DurationChooser extends StatefulWidget {
  const DurationChooser({super.key});

  @override
  State<DurationChooser> createState() => _DurationChooserState();
}

class _DurationChooserState extends State<DurationChooser> {
  var daysWidget = [
    for (var i = 0; i <= 10; i++) DropdownMenuItem(value: i, child: Text("$i"))
  ];
  var hoursWidget = [
    for (var i = 0; i <= 23; i++) DropdownMenuItem(value: i, child: Text("$i"))
  ];
  var minuteWidget = [
    for (var i = 0; i <= 59; i++) DropdownMenuItem(value: i, child: Text("$i"))
  ];

  @override
  Widget build(BuildContext context) {
    int days = 0;
    int hours = 0;
    int minutes = 0;
    try {
      days = createdEvent.eventLength!.inDays;
      hours = createdEvent.eventLength!.inHours - days * 24;
      minutes = createdEvent.eventLength!.inMinutes -
          createdEvent.eventLength!.inHours * 60;
    } catch (e) {
      return Text(e.toString());
    }
    return Center(
      child: Row(
        children: [
          Expanded(child: Container()),
          // days
          DropdownButton(
              value: days,
              items: daysWidget,
              onChanged: (value) {
                setState(() {
                  createdEvent.eventLength =
                      Duration(days: value!, hours: hours, minutes: minutes);
                });
              }),
          Text("Days"),
          Expanded(child: Container()),

          // hours
          DropdownButton(
              value: hours,
              items: hoursWidget,
              onChanged: (value) {
                setState(() {
                  createdEvent.eventLength =
                      Duration(days: days, hours: value!, minutes: minutes);
                });
              }),
          Text("Hours"),
          Expanded(child: Container()),

          // minutes
          DropdownButton(
              value: minutes,
              items: minuteWidget,
              onChanged: (value) {
                setState(() {
                  createdEvent.eventLength =
                      Duration(days: days, hours: hours, minutes: value!);
                });
              }),
          Text("Minutes"),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
