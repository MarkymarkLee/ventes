import 'package:flutter/material.dart';

class Event {
  String title = "";
  String description = "";
  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();
  TimeOfDay? startTime = TimeOfDay.now();
  TimeOfDay? endTime = TimeOfDay.now();
  String location = "";
  String image = "";
  String eventID = "";
  int likes = 0;
  int maxPeople = 0;
  int currentPeople = 0;
  List<dynamic> likedID = [];
  List<dynamic> joinedID = [];
  List<dynamic> tags = [];
  String genderLimit = "all";
  bool needGroupChat = true;
  bool chatWithHost = false;
  String hostID = "";
  String groupChatID = "";

  Event({
    this.title = "",
    this.description = "",
    startDate,
    endDate,
    startTime,
    endTime,
    this.location = "",
    this.image = "",
    this.eventID = "",
    this.likes = 0,
    this.maxPeople = 0,
    tags,
    this.genderLimit = "all",
    this.needGroupChat = true,
    this.chatWithHost = false,
    this.hostID = "",
    this.groupChatID = "",
    this.currentPeople = 0,
    likedID,
    joinedID,
  }) {
    if (startDate != null) this.startDate = startDate;
    if (endDate != null) this.endDate = endDate;
    if (startTime != null) this.startTime = startTime;
    if (endTime != null) this.endTime = endTime;
    if (tags != null) {
      this.tags = tags;
    } else {
      this.tags = [];
    }
    if (likedID != null) {
      this.likedID = likedID;
    } else {
      this.likedID = [];
    }
    if (joinedID != null) {
      this.joinedID = joinedID;
    } else {
      this.joinedID = [];
    }
  }

  factory Event.fromJson(json) {
    return Event(
      title: json?['title'],
      description: json?['description'],
      startDate: DateTime.parse(json?['startDate']),
      endDate: DateTime.parse(json?['endDate']),
      startTime: TimeOfDay(
        hour: json?['startTime']?['hour'],
        minute: json?['startTime']?['minute'],
      ),
      endTime: TimeOfDay(
        hour: json?['endTime']?['hour'],
        minute: json?['endTime']?['minute'],
      ),
      location: json?['location'],
      image: json?['image'],
      eventID: json?['eventID'],
      likes: json?['likes'],
      tags: json?['tags'],
      maxPeople: json?['maxPeople'],
      genderLimit: json?['genderLimit'],
      needGroupChat: json?['needGroupChat'],
      chatWithHost: json?['chatWithHost'],
      hostID: json?['hostID'],
      groupChatID: json?['groupChatID'],
      currentPeople: json?['currentPeople'],
      likedID: json?['likedID'],
      joinedID: json?['joinedID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
      'startTime': {
        'hour': startTime!.hour,
        'minute': startTime!.minute,
      },
      'endTime': {
        'hour': endTime!.hour,
        'minute': endTime!.minute,
      },
      'location': location,
      'image': image,
      'eventID': eventID,
      'likes': likes,
      'tags': tags,
      'maxPeople': maxPeople,
      'genderLimit': genderLimit,
      'needGroupChat': needGroupChat,
      'chatWithHost': chatWithHost,
      'hostID': hostID,
      'groupChatID': groupChatID,
      'currentPeople': currentPeople,
      'likedID': likedID,
      'joinedID': joinedID,
    };
  }
}

class AppUser {
  String email = "";
  String name = "";
  String gender = "";
  List<dynamic> createdEvents = [];
  List<dynamic> joinedEvents = [];
  List<dynamic> likedEvents = [];
  List<dynamic> chatIDs = [];
  List<dynamic> tags = [];

  AppUser({
    this.email = "",
    this.name = "",
    this.gender = "",
    this.tags = const [],
    createdEvents,
    joinedEvents,
    likedEvents,
    chatIDs,
  }) {
    this.createdEvents = createdEvents ?? [];
    this.joinedEvents = joinedEvents ?? [];
    this.likedEvents = likedEvents ?? [];
    this.chatIDs = chatIDs ?? [];
  }

  factory AppUser.fromJson(json) {
    return AppUser(
      email: json?['email'],
      name: json?['nickname'],
      gender: json?['gender'],
      createdEvents: json?['createdEvents'],
      joinedEvents: json?['joinedEvents'],
      likedEvents: json?['likedEvents'],
      chatIDs: json?['chatIDs'],
      tags: json?['tags'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'nickname': name,
      'gender': gender,
      'createdEvents': createdEvents,
      'joinedEvents': joinedEvents,
      'likedEvents': likedEvents,
      'chatIDs': chatIDs,
      'tags': tags,
    };
  }
}

AppUser currentUser = AppUser();

String eventDateRange(
    DateTime startDate, DateTime endDate, bool showWeekday, bool showYear) {
  return "${dateText(startDate, showWeekday, showYear)} ~ ${dateText(endDate, showWeekday, showYear)}";
}

String dateText(DateTime date, bool showWeekday, bool showYear) {
  var weekday = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  if (showWeekday && showYear) {
    return "${date.year}/${date.month}/${date.day} (${weekday[date.weekday - 1]})";
  } else if (showWeekday) {
    return "${date.month}/${date.day} (${weekday[date.weekday - 1]})";
  } else if (showYear) {
    return "${date.year}/${date.month}/${date.day}";
  } else {
    return "${date.month}/${date.day}";
  }
}

String eventTimeRange(TimeOfDay startDate, TimeOfDay endDate,
    {bool is24HourFormat = true}) {
  return "${timeText(startDate, is24HourFormat)} ~ ${timeText(endDate, is24HourFormat)}";
}

String timeText(TimeOfDay time, bool is24HourFormat) {
  if (is24HourFormat) {
    return "${time.hour}:${time.minute < 10 ? "0" : ""}${time.minute}";
  } else {
    if (time.hour > 12) {
      return "${time.hour - 12}:${time.minute} PM";
    } else {
      return "${time.hour}:${time.minute} AM";
    }
  }
}
