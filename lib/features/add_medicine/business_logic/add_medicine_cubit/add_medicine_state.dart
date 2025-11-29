part of 'add_medicine_cubit.dart';

@immutable
sealed class AddMedicineState {}

final class AddMedicineInitial extends AddMedicineState {}
final class AddMedicineDosage extends AddMedicineState {}
final class AddMedicineFrequency extends AddMedicineState {
 final List reminderTimes;

  AddMedicineFrequency({required this.reminderTimes});
}
final class AddMedicineReview extends AddMedicineState {}
