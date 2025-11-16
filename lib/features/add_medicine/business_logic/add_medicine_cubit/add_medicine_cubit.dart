import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_medicine_state.dart';

class AddMedicineCubit extends Cubit<AddMedicineState> {
  AddMedicineCubit() : super(AddMedicineInitial());
  int isPage = 0;
  final nameFormKey = GlobalKey<FormState>() ;
  void addMedicineChanger({required int newIndex}) {
    if (newIndex>=0) {
      isPage = newIndex;
    }
    switch (isPage) {
      case 1:
        emit(AddMedicineDosage());
        break;
      case 2:
        emit(AddMedicineFrequency());
        break;
      case 3:
        emit(AddMedicineReview());
        break;
      default:
        emit(AddMedicineInitial());
    }
  }
}
