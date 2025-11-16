import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meditime/core/constants/app_texts.dart';
import 'package:meta/meta.dart';

import '../../data/services/auth_user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<void> login(
  //   BuildContext context,
  //   String email,
  //   String password,
  // ) async {
  //   emit(LoginLoading());
  //   try {
  //     await AuthUser().loginWithEmail(
  //       context,
  //       email: email,
  //       password: password,
  //     );
  //     emit(LoginSuccess());
  //   } catch (e) {
  //     emit(LoginFailure(errorMessage: "Something went wrong"));
  //   }
  // }
Future<void> loginWithEmail({required String email, required String password, })async{
emit(LoginLoading());
  try{
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  emit(LoginSuccess());
  }on FirebaseAuthException catch (e) {
    if ( e.code == "invalid-credential") {
     emit(LoginFailure(errorMessage: AppTexts.emailOrPasswordIncorrect));
    }else if(e.code == "network-request-failed" ){
      emit(LoginFailure(errorMessage: AppTexts.problemWithInternetConnection));
    }
  }catch(e){
    emit(LoginFailure(errorMessage: AppTexts.someThingWentWrong));
  }
}
}
