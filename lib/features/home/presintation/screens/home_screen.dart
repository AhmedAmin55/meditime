import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/core/constants/app_colors.dart';
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        //FocusManager.instance.primaryFocus?.unfocus();
        if (context.read<SearchCubit>().state == true)
          context.read<SearchCubit>().search();
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: BlocBuilder<SearchCubit, bool>(
              builder: (context, state) {
                return Column(
                  children: [
                    HomeScreenHeader(),
                    const SizedBox(height: 12),
                    state == false ? InactiveSearchBar() : ActiveSearchBar(),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: medicineList.length,
                        itemBuilder: (context, index) {
                          return HomeMedicineCard(index: index);
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
