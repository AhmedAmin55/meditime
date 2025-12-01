part of 'auth_switch_cubit.dart';

@immutable
sealed class AuthSwitchState {}


final class AuthSwitchInitial extends AuthSwitchState {} 
final class AuthSignUpState extends AuthSwitchState {} 


