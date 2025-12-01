// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:meditime/core/constants/app_texts.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/repo/user_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepo userRepo;

  LoginCubit({required this.userRepo}) : super(LoginInitial());

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      UserModel? user = await userRepo.getUserData(uid);
      if (user == null) {
        emit(LoginFailure(errorMessage: "User data not found in Firestore"));
        return;
      }
      emit(LoginSuccess(user: user));
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        emit(LoginFailure(errorMessage: AppTexts.emailOrPasswordIncorrect));
      } else if (e.code == "network-request-failed") {
        emit(
          LoginFailure(errorMessage: AppTexts.problemWithInternetConnection),
        );
      } else {
        emit(
          LoginFailure(errorMessage: e.message ?? AppTexts.someThingWentWrong),
        );
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: AppTexts.someThingWentWrong));
    }
  }
}
