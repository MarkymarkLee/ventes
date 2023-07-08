import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

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

  static Future<String> getSchoolEmail(String email) async {
    try {
      // Get reference to Firestore collection
      var doc = await users.doc(email).get();
      return doc.get("schoolEmail");
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getUserName(String email) async {
    try {
      // Get reference to Firestore collection
      var doc = await users.doc(email).get();
      return doc.get("nickname");
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> updateProfile(
      String email, String nickname, String gender) async {
    String nicknameError = "";
    if (nickname.isEmpty) {
      nicknameError = "Nickname cannot be empty!!";
      return nicknameError;
    }

    Map<String, String>? profile = {
      "nickname": nickname,
      "gender": gender,
    };
    debugPrint(profile.toString());
    await UsersData.updateUser(email, profile);
    return nicknameError;
  }
}
