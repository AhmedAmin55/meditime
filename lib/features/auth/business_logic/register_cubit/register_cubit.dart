// Package imports:
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

// Project imports:
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
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user!.uid;

      final newUser = UserModel(
        uid: uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
      );

      await userRepo.registerUser(newUser);
      emit(RegisterSuccess(uid: uid));
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        emit(RegisterFailure(errorMessage: AppTexts.emailAlreadyExist));
      } else if (e.code == "weak-password") {
        emit(RegisterFailure(errorMessage: AppTexts.weakPassword));
      } else if (e.code == "network-request-failed") {
        emit(
          RegisterFailure(errorMessage: AppTexts.problemWithInternetConnection),
        );
      } else {
        emit(
          RegisterFailure(
            errorMessage: e.message ?? AppTexts.someThingWentWrong,
          ),
        );
      }
    } catch (e) {
      emit(RegisterFailure(errorMessage: AppTexts.someThingWentWrong));
    }
  }
}
