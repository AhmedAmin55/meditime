part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}
final class RegisterLoading extends RegisterState {}
final class RegisterSuccess extends RegisterState {
  final String uid; // أضف هذا
  RegisterSuccess({required this.uid});
}
final class RegisterFailure extends RegisterState {
  final String errorMessage;
  RegisterFailure({required this.errorMessage});
}
