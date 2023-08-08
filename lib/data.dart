class Event {
  String title = "";
  String description = "";
  DateTime? startTime = DateTime.now();
  Duration? eventLength = const Duration(days: 1, hours: 0, minutes: 0);
  DateTime? endTime = DateTime.now();
  String location = "";
  String image = "";
  String eventID = "";
  int likes = 0;
  List<dynamic> tags = [];
  int maxPeople = 0;
  int currentPeople = 0;
  String genderLimit = "all";
  bool needGroupChat = true;
  bool chatWithHost = false;
  String hostID = "";
  String groupChatID = "";

  Event({
    this.title = "",
    this.description = "",
    startTime,
    eventLength,
    endTime,
    this.location = "",
    this.image = "",
    this.eventID = "",
    this.likes = 0,
    tags,
    this.maxPeople = 0,
    this.genderLimit = "all",
    this.needGroupChat = true,
    this.chatWithHost = false,
    this.hostID = "",
    this.groupChatID = "",
    this.currentPeople = 0,
  }) {
    if (startTime != null) this.startTime = startTime;
    if (eventLength != null) this.eventLength = eventLength;
    if (endTime != null) this.endTime = endTime;
    if (tags != null) {
      this.tags = tags;
    } else {
      this.tags = [];
    }
  }

  factory Event.fromJson(json) {
    return Event(
      title: json?['title'],
      description: json?['description'],
      startTime: DateTime.parse(json?['startDate']),
      eventLength: Duration(
        days: json?['eventLength']?['days'],
        hours: json?['eventLength']?['hours'],
        minutes: json?['eventLength']?['minutes'],
      ),
      endTime: DateTime.parse(json?['endDate']),
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
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> el = {
      'days': eventLength!.inDays,
      'hours': eventLength!.inHours - eventLength!.inDays * 24,
      'minutes': eventLength!.inMinutes - eventLength!.inHours * 60,
    };
    return {
      'title': title,
      'description': description,
      'startDate': startTime.toString(),
      'eventLength': el,
      'endDate': endTime.toString(),
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

  AppUser(
      {this.email = "",
      this.name = "",
      this.gender = "",
      createdEvents,
      joinedEvents,
      likedEvents,
      chatIDs}) {
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
    };
  }
}

AppUser currentUser = AppUser();

String eventDateRange(DateTime startDate, DateTime endDate, bool showWeekday,
    bool showYear) {
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
