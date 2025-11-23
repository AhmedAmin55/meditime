import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../core/constants/app_texts.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/repo/user_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepo userRepo;

  RegisterCubit({required this.userRepo}) : super(RegisterInitial());

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    emit(RegisterLoading());
    try {
      // 1️⃣ تسجيل المستخدم في Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      // 2️⃣ إنشاء نموذج المستخدم بدون age
      final newUser = UserModel(
        uid: uid,
        name: name,
        age: 0, // سيُضاف لاحقًا داخل التطبيق
        email: email,
        phoneNumber: phoneNumber,
      );

      // 3️⃣ إضافة البيانات إلى Firestore عبر الـ Repo
      await userRepo.registerUser(newUser);

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        emit(RegisterFailure(errorMessage: AppTexts.emailAlreadyExist));
      } else if (e.code == "weak-password") {
        emit(RegisterFailure(errorMessage: AppTexts.weakPassword));
      } else if (e.code == "network-request-failed") {
        emit(RegisterFailure(errorMessage: AppTexts.problemWithInternetConnection));
      } else {
        emit(RegisterFailure(errorMessage: e.message ?? AppTexts.someThingWentWrong));
      }
    } catch (e) {
      emit(RegisterFailure(errorMessage: AppTexts.someThingWentWrong));
    }
  }
}
