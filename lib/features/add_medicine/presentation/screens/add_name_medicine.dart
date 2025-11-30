import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/core/constants/app_colors.dart';
import 'package:meditime/core/constants/app_images.dart';
import 'package:meditime/core/constants/app_texts.dart';
import 'package:meditime/core/constants/app_textstyle.dart';
import '../../../../core/widgets/primary_appbar.dart';
import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import '../widgets/screen_info.dart';
import '../widgets/add_page_return_icon.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/progress_bar.dart';

class AddNameMedicine extends StatelessWidget {
  const AddNameMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddMedicineCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  PrimaryAppbar(
                    title: AppTexts.addMedicationForYourselfOrFriends,
                    titleStyle: AppTextsStyle.poppinsMedium20(context).copyWith(fontSize: 15),
                    subtitle: AppTexts.hopeToGetBetterSoon,
                    subtitleStyle: AppTextsStyle.poppinsBold15(context).copyWith(fontSize: 10, color: AppColors.timeColor),
                    imagePath: AppImages.logo,
                  ),
                  const SizedBox(height: 8),
                  const ProgressBar(isPage: 0),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: const BoxDecoration(
                  color: AppColors.addBackground,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Column(
                  children: [
                    const AddPageReturnIcon(),
                    const SizedBox(height: 20),
                    const ScreenInfo(
                      imagePath: AppImages.medicineNameScreenIcon,
                      title: AppTexts.medicineName,
                      subtitle: AppTexts.whatMedicineWouldYouLikeToAdd,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Form(
                        key: cubit.namePageKey,
                        child: ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            const Text("Assign to who", style: TextStyle(fontSize: 15, color: Colors.black54)),
                            const SizedBox(height: 8),
                            CustomInputField(
                              controller: cubit.assignTo,
                              hint: "Me",
                              isDropdown: true,
                              items: ["Me", "Ahmed", "Sara", "Mohamed", "Mariam", "Jomana"],
                              onChange: (value) {
                                cubit.assignTo.text = value ?? "Me";
                              },
                            ),
                            const SizedBox(height: 20),

                            const Text("Medicine Name", style: TextStyle(fontSize: 15, color: Colors.black54)),
                            const SizedBox(height: 8),
                            CustomInputField(
                              controller: cubit.medicineName,
                              hint: "e.g. Vitamin, Panadol",
                              onChange: (_) {
                                cubit.emit(AddMedicineInProgress(
                                  currentPage: cubit.isPage,
                                  uiRows: List.from(cubit.uiRows),
                                ));
                              },
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) return "Please enter medicine name";
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            const Text("Special Instructions (Optional)", style: TextStyle(fontSize: 15, color: Colors.black54)),
                            const SizedBox(height: 8),
                            CustomInputField(
                              controller: cubit.specialInstructions,
                              hint: "e.g. Take with food, Take on empty stomach",
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}