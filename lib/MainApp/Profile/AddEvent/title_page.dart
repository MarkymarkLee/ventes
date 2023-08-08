import 'package:flutter/material.dart';
import 'package:ventes/Components/components.dart';
import 'package:ventes/Styles/text_style.dart';
import 'package:ventes/data.dart';
import 'globals.dart';

// This is the first page for the add event process
// should add a title, description, date, time and location
class TitlePage extends StatefulWidget {
  final String titleError;
  const TitlePage({super.key, this.titleError = ""});

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  bool? choosetime = false;
  DateTime startDate = createdEvent.startTime!;
  DateTime endDate = createdEvent.endTime!;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Title textfield
            MyTextField(
              controller: TextEditingController(text: createdEvent.title),
              fieldName: "Title",
              hintText: "title",
              errorText: widget.titleError,
              maxLength: 50,
              onChanged: (value) {
                createdEvent.title = value;
              },
            ),

            // Description textfield
            MyTextField(
              controller: TextEditingController(text: createdEvent.description),
              fieldName: "Description",
              hintText: "description",
              // maxLines: 50,
              // minLines: 1,
              maxLength: 300,
              onChanged: (value) {
                createdEvent.description = value;
              },
            ),

            // Location textfield
            MyTextField(
              controller: TextEditingController(text: createdEvent.location),
              fieldName: "Location",
              hintText: "location",
              maxLength: 50,
              onChanged: (value) {
                createdEvent.location = value;
              },
            ),

            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  child: Text(
                    "When is the event?",
                    style: MyTextStyle.titleMedium(context),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      DateTimeRange? newDateRange = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (newDateRange != null) {
                        DateTime? newStartDate = newDateRange.start;
                        DateTime? newEndDate = newDateRange.end;
                        setState(() {
                          startDate = newStartDate;
                          endDate = newEndDate;
                        });
                        createdEvent.startTime = newStartDate;
                        createdEvent.endTime = newEndDate;
                      }
                    },
                    icon: const Icon(Icons.calendar_month_sharp)),
                Expanded(child: Container()),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: TextEditingController(
                    text: eventDateRange(startDate, endDate, true, true)),
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                  fillColor: Colors.amber[50],
                  filled: true,
                ),
                style: MyTextStyle.bodyMedium(context),
              ),
            ),
            const SizedBox(height: 15),

            // Event length
            Text("How long is the event?", style: MyTextStyle.titleMedium(context)),
            const SizedBox(height: 10),
            const DurationChooser(),
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
