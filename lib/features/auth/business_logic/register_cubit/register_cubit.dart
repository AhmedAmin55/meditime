import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../core/constants/app_texts.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        emit(RegisterFailure(errorMessage: AppTexts.emailAlreadyExist));
      } else if (e.code == "weak-password") {
        emit(RegisterFailure(errorMessage: AppTexts.weakPassword));
      } else if (e.code == "network-request-failed") {
        emit(
          RegisterFailure(errorMessage: AppTexts.problemWithInternetConnection),
        );
      }
    } catch (e) {
      emit(RegisterFailure(errorMessage: AppTexts.someThingWentWrong));
    }
  }
}
