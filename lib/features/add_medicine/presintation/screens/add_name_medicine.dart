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

class AddNameMedicine extends StatelessWidget {
  AddNameMedicine({super.key});
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                        key: (context).read<AddMedicineCubit>().nameFormKey,
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 0,
                          ),
                          children: [
                            Text(AppTexts.assignToWho,style: AppTextsStyle.poppinsRegular25(context).copyWith(fontSize: 15,
                                color: AppColors.black.withOpacity(0.6)),),
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
                            ),
                            const SizedBox(height: 20),
                            Text(AppTexts.medicineName2,style: AppTextsStyle.poppinsRegular25(context).copyWith(fontSize: 15,
                                color: AppColors.black.withOpacity(0.6)),),
                            const SizedBox(height: 8),
                            CustomInputField(
                              validator: (value) => value!
                                  .trim()
                                  .validateRequired(AppTexts.enterMedicineName),
                              hint: "e.g. Vitamin, Panadol",
                            ),
                            const SizedBox(height: 20),
                            Text(AppTexts.specialInstructions,style: AppTextsStyle.poppinsRegular25(context).copyWith(fontSize: 15,
                                color: AppColors.black.withOpacity(0.6)),),
                            const SizedBox(height: 8),
                            CustomInputField(
                              hint:
                                  "e.g. Take with food, Take on empty \nstomach",
                              maxLines: 2,
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
