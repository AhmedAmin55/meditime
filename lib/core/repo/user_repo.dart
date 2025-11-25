import 'dart:io';

import '../models/user_model.dart';
import '../services/user_service.dart';

class UserRepo {
  final UserService service;

  UserRepo(this.service);

  Future<void> registerUser(UserModel user) => service.createUser(user);

  Future<UserModel?> getUserData(String uid) => service.getUser(uid);

  Future<void> updatePhoto(String uid, File url) =>
      service.updateProfilePhoto(uid, url);
  Future<void> updateName(String uid, String newName) =>
      service.updateName(uid, newName);
  Future<void> updateAge(String uid, int newAge) =>
      service.updateAge(uid, newAge);
}
