import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> updateProfilePhoto(String uid, String url) async {
    await _firestore.collection("users").doc(uid).update({
      'profile_photo': url,
    });
  }

  // 🔹 تحديث الاسم فقط
  Future<void> updateName(String uid, String newName) async {
    await _firestore.collection("users").doc(uid).update({
      'name': newName,
    });
  }
}
