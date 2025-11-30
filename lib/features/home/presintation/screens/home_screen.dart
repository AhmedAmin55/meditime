import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/core/constants/app_colors.dart';
import '../../../../core/business_logic/medicine_cubit/medicinde_cubit.dart';
import '../../../../core/models/medicine_model.dart';
import '../../business_logic/search_cubit/search_cubit.dart';
import '../widgets/active_search_bar.dart';
import '../widgets/home_medicine_card.dart';
import '../widgets/inactive_search_bar.dart';
import '../widgets/home_screen_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // مهم جدًا: تحميل الداتا أول ما تدخل الشاشة
    context.read<MedicineCubit>().fetchMedicines();

    return GestureDetector(
      onTap: () {
        if (context.read<SearchCubit>().state == true) {
          context.read<SearchCubit>().search();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: BlocBuilder<SearchCubit, bool>(
              builder: (context, isSearching) {
                return Column(
                  children: [
                    const HomeScreenHeader(),
                    const SizedBox(height: 12),
                    isSearching ? const ActiveSearchBar() : const InactiveSearchBar(),
                    const SizedBox(height: 10),
                    Expanded(
                      child: BlocBuilder<MedicineCubit, MedicineState>(
                        builder: (context, state) {
                          if (state is MedicineLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (state is MedicineLoaded) {
                            if (state.medicines.isEmpty) {
                              return const Center(child: Text("لا توجد أدوية حاليًا"));
                            }
                            return ListView.builder(
                              itemCount: state.medicines.length,
                              itemBuilder: (context, index) {
                                return HomeMedicineCard(medicine: state.medicines[index]);
                              },
                            );
                          }
                          if (state is MedicineError) {
                            return Center(child: Text(state.message));
                          }
                          return const Center(child: Text("جاري تحميل الأدوية..."));
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}