// Dart imports:
import 'dart:io';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Project imports:
import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _firestore.collection("users").doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore.collection("users").doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromMap(doc.data()!);
  }

  Future<void> updateProfilePhoto(String uid, File file) async {
    try {
      print("Uploading file: ${file.path}");
      final ref = FirebaseStorage.instance
          .ref()
          .child("profile_images")
          .child("${uid}_${DateTime.now().millisecondsSinceEpoch}.jpg");

      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;

      final downloadUrl = await snapshot.ref.getDownloadURL();
      print("Download URL = $downloadUrl");

      await _firestore.collection("users").doc(uid).update({
        'profile_photo': downloadUrl,
      });

      print("Profile photo updated successfully!");
    } catch (e) {
      print("🔥 ERROR in updateProfilePhoto: $e");
      rethrow;
    }
  }

  Future<void> updateName(String uid, String newName) async {
    await _firestore.collection("users").doc(uid).update({'name': newName});
  }

  Future<void> updateAge(String uid, int newAge) async {
    await _firestore.collection("users").doc(uid).update({'age': newAge});
  }
}
