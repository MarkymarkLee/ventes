import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UsersData {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addUser(String email, Map<String, dynamic> data) {
    // Call the user's CollectionReference to add a new user
    return users.doc(email).set(data);
  }

  static Future<void> updateUser(
      String email, Map<String, dynamic> data) async {
    await users.doc(email).update(data);
  }

  static Future<bool> checkIfUserExists(String email) async {
    try {
      // Get reference to Firestore collection
      var doc = await users.doc(email).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> userVerified(String email) async {
    try {
      // Get reference to Firestore collection
      var doc = await users.doc(email).get();
      return doc.get("isVerified");
    } catch (e) {
      rethrow;
    }
  }
}
