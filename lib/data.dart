class Event {
  String title;
  String description;
  String date;
  String time;
  String location;
  String image;
  String eventID;
  int likes = 0;
  List<String> tags = [];

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.image,
    required this.eventID,
    this.likes = 0,
  });

  factory Event.fromJson(json) {
    return Event(
      title: json?['title'],
      description: json?['description'],
      date: json?['date'],
      time: json?['time'],
      location: json?['location'],
      image: json?['image'],
      eventID: json?['eventID'],
      likes: json?['likes'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'date': date,
        'time': time,
        'location': location,
        'image': image,
        'eventID': eventID,
        'likes': likes,
      };
}

class UserData {
  String uid;
  String name;
  String gender;
  List<String> createdEvents = [];
  List<String> joinedEvents = [];
  List<String> likedEvents = [];

  UserData({required this.uid, required this.name, required this.gender});
}
