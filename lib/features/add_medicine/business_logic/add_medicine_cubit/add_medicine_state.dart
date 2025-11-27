part of 'add_medicine_cubit.dart';

@immutable
abstract class AddMedicineState {}

class AddMedicineInitial extends AddMedicineState {}

// === Navigation States ===
class AddMedicineDosage extends AddMedicineState {}
class AddMedicineFrequency extends AddMedicineState {}
class AddMedicineReview extends AddMedicineState {}

// === Database/Action States ===
class AddMedicineLoading extends AddMedicineState {}

class AddMedicineSuccess extends AddMedicineState {}

class AddMedicineFailure extends AddMedicineState {
  final String error;
  AddMedicineFailure(this.error);
}