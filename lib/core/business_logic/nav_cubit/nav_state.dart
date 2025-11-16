part of 'nav_cubit.dart';

@immutable
sealed class NavState {}

final class NavInitial extends NavState {

}
final class NavCalendar extends NavState {}
final class NavAdd extends NavState {}
final class NavNotification extends NavState {}
final class NavProfile extends NavState {}
