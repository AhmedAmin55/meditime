part of 'add_medicine_cubit.dart';

@immutable
abstract class AddMedicineState {}

class AddMedicineInitial extends AddMedicineState {}

class AddMedicineInProgress extends AddMedicineState {
 final int currentPage;
 final List<ReminderModel> uiRows;

 AddMedicineInProgress({required this.currentPage, required this.uiRows});
}