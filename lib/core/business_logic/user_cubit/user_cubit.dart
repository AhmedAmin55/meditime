import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import '../../models/user_model.dart';
import '../../repo/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo userRepo;

  UserCubit(this.userRepo) : super(UserInitial());

  // جلب بيانات المستخدم
  Future<void> fetchUser({required String uid}) async {
    emit(UserLoading());
    try {
      final user = await userRepo.getUserData(uid);
      if (user != null) {
        emit(UserLoaded(user: user));
      } else {
        emit(UserFailure(errorMessage: "User not found"));
      }
    } catch (e) {
      emit(UserFailure(errorMessage: "Something went wrong"));
    }
  }

  Future<void> updateName(String uid, String newName) async {
    await userRepo.updateName(uid, newName);
    await fetchUser(uid: uid); // refresh
  }

  Future<void> updatePhoto(String uid, XFile pickedImage) async {
    final file = File(pickedImage.path);

    await userRepo.updatePhoto(uid, file);

    await fetchUser(uid: uid);
  }

  void resetUser(){
    emit(UserInitial());
  }
}
