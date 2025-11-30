import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/medicine_model.dart';
import '../../services/get_medicine_service.dart';

part 'medicinde_state.dart';


class MedicineCubit extends Cubit<MedicineState> {
  final GetMedicineService service;

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