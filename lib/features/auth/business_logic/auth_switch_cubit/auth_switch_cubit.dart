// Package imports:
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_switch_state.dart';

class AuthSwitchCubit extends Cubit<AuthSwitchState> {
  AuthSwitchCubit() : super(AuthSwitchInitial());

  void showLogin() => emit(AuthSwitchInitial());

  void showSignUp() => emit(AuthSignUpState());
}
