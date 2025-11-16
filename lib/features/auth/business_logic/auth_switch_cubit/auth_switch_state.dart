part of 'auth_switch_cubit.dart';

@immutable
sealed class AuthSwitchState {}


final class AuthSwitchInitial extends AuthSwitchState {} // "login button"
final class AuthSignUpState extends AuthSwitchState {} // "sign up button"


