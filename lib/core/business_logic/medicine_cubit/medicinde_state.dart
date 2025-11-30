part of 'medicinde_cubit.dart';

@immutable

abstract class MedicineState {}

class MedicineInitial extends MedicineState {}

class MedicineLoading extends MedicineState {}

class MedicineLoaded extends MedicineState {
  final List<MedicineModel> medicines;

  MedicineLoaded({required this.medicines});
}

class MedicineError extends MedicineState {
  final String message;

  MedicineError(this.message);
}
