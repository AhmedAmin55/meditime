// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:meditime/features/add_medicine/business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import 'package:meditime/features/add_medicine/presentation/screens/add_dosage_and_type_medicine.dart';
import 'package:meditime/features/add_medicine/presentation/screens/add_frequency_and_time_medicine.dart';
import 'package:meditime/features/add_medicine/presentation/screens/add_name_medicine.dart';
import 'package:meditime/features/add_medicine/presentation/screens/add_review_and_save_medicine.dart';

class AddMedicineFlowScreen extends StatelessWidget {
  const AddMedicineFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMedicineCubit, AddMedicineState>(
      builder: (context, state) {
        if (state is AddMedicineInProgress) {
          switch (state.currentPage) {
            case 0:
              return AddNameMedicine();
            case 1:
              return AddDosageAndTypeMedicine();
            case 2:
              return AddFrequencyAndTimeMedicineState();
            case 3:
              return AddReviewAndSaveMedicine();
            default:
              return AddNameMedicine();
          }
        }

        return AddNameMedicine();
      },
    );
  }
}
