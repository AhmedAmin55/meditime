import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
    // 1- حدد مكان الصورة داخل Storage
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("users")
        .child(uid)
        .child("profile.jpg");

    // 2- ارفع الصورة
    await storageRef.putFile(file);

    // 3- هات رابط الصورة
    final downloadUrl = await storageRef.getDownloadURL();

    // 4- خزنه داخل Firestore
    await _firestore.collection("users").doc(uid).update({
      'profile_photo': downloadUrl,
    });
  }
  // 🔹 تحديث الاسم فقط
  Future<void> updateName(String uid, String newName) async {
    await _firestore.collection("users").doc(uid).update({
      'name': newName,
    });
  }
  Future<void> updateAge(String uid, int newAge) async {
    await _firestore.collection("users").doc(uid).update({
      'age': newAge,
    });
}}
