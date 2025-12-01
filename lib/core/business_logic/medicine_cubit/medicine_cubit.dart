import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/medicine_model.dart';
import '../../services/get_medicine_service.dart';
import '../../services/user_medicine_service.dart';

part 'medicine_state.dart';


class MedicineCubit extends Cubit<MedicineState> {
  final UserMedicineService service;

  MedicineCubit(this.service) : super(MedicineInitial());
  var list ;
  Future<void> fetchMedicines() async {
    try {
      emit(MedicineLoading());
    list= await service.getAllMedicines();
      emit(MedicineLoaded(medicines: list));
    } catch (e) {
      emit(MedicineError(e.toString()));
    }
  }

}