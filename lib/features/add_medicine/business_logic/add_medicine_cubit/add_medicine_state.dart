part of 'add_medicine_cubit.dart';

@immutable
sealed class AddMedicineState {}

final class AddMedicineInitial extends AddMedicineState {}
final class AddMedicineDosage extends AddMedicineState {}
final class AddMedicineFrequency extends AddMedicineState {}
final class AddMedicineReview extends AddMedicineState {}
