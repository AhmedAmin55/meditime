import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/core/constants/app_colors.dart';
import 'package:meditime/core/constants/app_texts.dart';
import 'package:meditime/core/constants/app_textstyle.dart';
import 'package:meditime/core/utils/app_validators.dart';
import 'package:meditime/core/widgets/primary_appbar.dart';

import '../../../../core/constants/app_images.dart';
import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';

import '../widgets/screen_info.dart';
import '../widgets/add_page_return_icon.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/progress_bar.dart';

class AddNameMedicine extends StatefulWidget {
  AddNameMedicine({super.key});

  @override
  State<AddNameMedicine> createState() => _AddNameMedicineState();
}

class _AddNameMedicineState extends State<AddNameMedicine> {
  // ============ Controllers ============
  final TextEditingController medicineNameController = TextEditingController();
  final TextEditingController specialInstructionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // لو في داتا محفوظة من قبل، نملي بيها الـ fields
    final cubit = context.read<AddMedicineCubit>();
    medicineNameController.text = cubit.medicineName ?? '';
    specialInstructionsController.text = cubit.specialInstructions ?? '';
  }

  @override
  void dispose() {
    medicineNameController.dispose();
    specialInstructionsController.dispose();
    super.dispose();
  }

  void _saveNameData() {
    // نحفظ الداتا في الـ Cubit
    final cubit = context.read<AddMedicineCubit>();
    cubit.medicineName = medicineNameController.text.trim();
    cubit.specialInstructions = specialInstructionsController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // نحفظ الداتا كل ما الـ widget يتبني
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _saveNameData();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  PrimaryAppbar(
                    title: AppTexts.addMedicationForYourselfOrFriends,
                    titleStyle: AppTextsStyle.poppinsMedium20(
                      context,
                    ).copyWith(fontSize: 15),
                    subtitle: AppTexts.hopeToGetBetterSoon,
                    subtitleStyle: AppTextsStyle.poppinsBold15(
                      context,
                    ).copyWith(fontSize: 10, color: AppColors.timeColor),
                    imagePath: AppImages.logo,
                  ),
                  const SizedBox(height: 8),
                  ProgressBar(isPage: 0),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                height: height,
                width: width,
                margin: EdgeInsets.only(top: 10, right: 12, left: 12),
                decoration: BoxDecoration(
                  color: AppColors.addBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    AddPageReturnIcon(),
                    SizedBox(height: 20),
                    ScreenInfo(
                      imagePath: AppImages.medicineNameScreenIcon,
                      title: AppTexts.medicineName,
                      subtitle: AppTexts.whatMedicineWouldYouLikeToAdd,
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Form(
                        key: context.read<AddMedicineCubit>().nameFormKey,
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 0,
                          ),
                          children: [
                            Text(
                              AppTexts.assignToWho,
                              style: AppTextsStyle.poppinsRegular25(context)
                                  .copyWith(
                                  fontSize: 15,
                                  color: AppColors.black.withOpacity(0.6)),
                            ),
                            const SizedBox(height: 8),
                            CustomInputField(
                              validator: (value) =>
                                  value!.trim().validateRequired(
                                    AppTexts.selectFamilyMember,
                                  ),
                              isDropdown: true,
                              items: [
                                "Ahmed",
                                "Sara",
                                "Mohamed",
                                "mariam",
                                "jomana",
                              ],
                              onChanged: (value) {
                                context.read<AddMedicineCubit>().assignToWho = value;
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(
                              AppTexts.medicineName2,
                              style: AppTextsStyle.poppinsRegular25(context)
                                  .copyWith(
                                  fontSize: 15,
                                  color: AppColors.black.withOpacity(0.6)),
                            ),
                            const SizedBox(height: 8),
                            CustomInputField(
                              controller: medicineNameController,
                              validator: (value) => value!
                                  .trim()
                                  .validateRequired(AppTexts.enterMedicineName),
                              hint: "e.g. Vitamin, Panadol",
                              onSaved: (value) {
                                context.read<AddMedicineCubit>().medicineName = value?.trim();
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(
                              AppTexts.specialInstructions,
                              style: AppTextsStyle.poppinsRegular25(context)
                                  .copyWith(
                                  fontSize: 15,
                                  color: AppColors.black.withOpacity(0.6)),
                            ),
                            const SizedBox(height: 8),
                            CustomInputField(
                              controller: specialInstructionsController,
                              hint:
                              "e.g. Take with food, Take on empty \nstomach",
                              maxLines: 2,
                              onSaved: (value) {
                                context.read<AddMedicineCubit>().specialInstructions = value?.trim();
                              },
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