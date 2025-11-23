import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/user_model.dart';
import '../../repo/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo userRepo;
  UserCubit(this.userRepo) : super(UserInitial());

  // جلب بيانات المستخدم من Firestore
  Future<void> fetchUser(String uid) async {
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

  // تحديث الاسم
  Future<void> updateName(String uid, String newName) async {
    await userRepo.updateName(uid, newName);
    await fetchUser(uid); // refresh بعد التحديث
  }

  // تحديث الصورة
  Future<void> updatePhoto(String uid, String url) async {
    await userRepo.updatePhoto(uid, url);
    await fetchUser(uid); // refresh بعد التحديث
  }
}
