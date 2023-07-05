class UserData {
  String uid;
  String name;
  String gender;
  List<String> createdEvents = [];
  List<String> joinedEvents = [];
  List<String> likedEvents = [];

  UserData({required this.uid, required this.name, required this.gender});
}
