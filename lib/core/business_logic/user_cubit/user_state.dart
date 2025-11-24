part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final UserModel user;
  UserLoaded({required this.user});
}

final class UserFailure extends UserState {
  final String errorMessage;
  UserFailure({required this.errorMessage});
}

final class UserImagePicked extends UserState {
  final String image;
  UserImagePicked({required this.image});
}
