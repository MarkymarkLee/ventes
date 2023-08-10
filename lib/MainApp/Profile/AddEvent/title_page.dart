import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';
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
  DateTime startDate = createdEvent.startDate!;
  DateTime endDate = createdEvent.endDate!;
  TimeOfDay startTime = createdEvent.startTime!;
  TimeOfDay endTime = createdEvent.endTime!;
  List<String> timeLabels = [
    "12 am",
    "3 am",
    "6 am",
    "9 am",
    "12 pm",
    "3 pm",
    "6 pm",
    "9 pm"
  ];
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
                      const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5),
                  child: Text(
                    "What date is the event?",
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
                        createdEvent.startDate = newStartDate;
                        createdEvent.endDate = newEndDate;
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
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5),
                  child: Text(
                    "What time is the event?",
                    style: MyTextStyle.titleMedium(context),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      await showTimeRangePicker(
                        context: context,
                        start: startTime,
                        end: endTime,
                        onStartChange: (start) {
                          setState(() {
                            startTime = start;
                          });
                          createdEvent.startTime = start;
                        },
                        onEndChange: (end) {
                          setState(() {
                            endTime = end;
                          });
                          createdEvent.endTime = end;
                        },
                        interval: const Duration(minutes: 30),
                        minDuration: const Duration(minutes: 30),
                        padding: 40,
                        strokeWidth: 8,
                        handlerRadius: 10,
                        strokeColor: Colors.amber.shade700,
                        handlerColor: Colors.amber.shade700,
                        selectedColor: Colors.orange[800],
                        backgroundColor: Colors.black.withOpacity(0.3),
                        ticks: 12,
                        ticksColor: Colors.white,
                        snap: true,
                        labels: timeLabels.asMap().entries.map((e) {
                          return ClockLabel.fromIndex(
                              idx: e.key, length: 8, text: e.value);
                        }).toList(),
                        labelOffset: 20,
                        timeTextStyle: TextStyle(
                            color: Colors.amber.shade700,
                            fontSize: 24,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                        activeTimeTextStyle: TextStyle(
                            color: Colors.orange[800],
                            fontSize: 26,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      );
                    },
                    icon: const Icon(Icons.schedule)),
                Expanded(child: Container()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: TextEditingController(
                    text: eventTimeRange(startTime, endTime)),
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
          ],
        ),
      ),
    );
  }
}
