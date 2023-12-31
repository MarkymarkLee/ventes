import 'package:flutter/material.dart';
import 'package:ventes/Auth/auth_service.dart';
import 'package:ventes/Functions/random_string.dart';
import 'title_page.dart';
import 'settings_page.dart';
import 'tags_page.dart';
import 'package:ventes/globals.dart';
import 'package:ventes/data.dart';
import 'package:ventes/Functions/events_data.dart';
import 'package:ventes/Functions/users_data.dart';

class AddEventPage extends StatefulWidget {
  AddEventPage({super.key}) {
    createdEvent = Event();
  }

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  int curPage = 0;
  String titleError = "";
  String maxPeopleError = "";

  void back() {
    Navigator.pop(context);
  }

  bool checkPage() {
    if (curPage == 0) {
      if (createdEvent.title == "") {
        titleError = "Title cannot be empty";
        return false;
      }
    } else if (curPage == 1) {
      if (createdEvent.maxPeople < 0) {
        maxPeopleError = "Maximum number of people cannot be negative";
        return false;
      } else if (createdEvent.maxPeople > 10000000) {
        maxPeopleError =
            "Maximum number of people cannot be greater than 10,000,000";
        return false;
      }
      maxPeopleError = "";
    } else if (curPage == 2) {}
    return true;
  }

  void nextPage() {
    curPage++;
    setState(() {});
  }

  void prevPage() {
    curPage--;
    setState(() {});
  }

  static Future<void> addcreatedEvent() async {
    createdEvent.hostID = AuthService().getCurrentUserEmail();
    createdEvent.eventID = getRandomString(20);
    await EventsData.addEvent(createdEvent.eventID, createdEvent.toJson());
    currentUser.createdEvents.add(createdEvent.eventID);
    await UsersData.updateUser(
        currentUser.email, {"createdEvents": currentUser.createdEvents});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Event"),
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: Row(
            children: [
              if (curPage != 0)
                TextButton(
                    onPressed: () {
                      prevPage();
                    },
                    child: const Text("Prev")),
              Expanded(child: Container()),
              if (curPage != 2)
                TextButton(
                    onPressed: () {
                      if (checkPage()) nextPage();
                      setState(() {});
                    },
                    child: const Text("Next"))
              else
                TextButton(
                    onPressed: () async {
                      await addcreatedEvent();
                      if (!mounted) return;
                      Navigator.pop(context);
                    },
                    child: const Text("Finished"))
            ],
          ),
        ),
        body: curPage == 0
            ? TitlePage(
                titleError: titleError,
              )
            : curPage == 1
                ? SettingsPage(
                    maxPeopleError: maxPeopleError,
                  )
                : curPage == 2
                    ? TagsPage()
                    : Text("Error"));
  }
}
