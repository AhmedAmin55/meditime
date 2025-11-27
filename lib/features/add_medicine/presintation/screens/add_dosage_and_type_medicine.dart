import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/features/add_medicine/presintation/widgets/screen_info.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../../../core/widgets/primary_appbar.dart';
import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import '../widgets/add_page_background.dart';
import '../widgets/add_page_return_icon.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/medicine_type_selector.dart';
import '../widgets/progress_bar.dart';

class AddDosageAndTypeMedicine extends StatefulWidget {
  AddDosageAndTypeMedicine({super.key});

  @override
  State<AddDosageAndTypeMedicine> createState() => _AddDosageAndTypeMedicineState();
}

class _AddDosageAndTypeMedicineState extends State<AddDosageAndTypeMedicine> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dosageController = TextEditingController();
  String? selectedMedicineType;

  @override
  void initState() {
    super.initState();
    // لو في داتا محفوظة من قبل، نملي بيها الـ fields
    final cubit = context.read<AddMedicineCubit>();
    dosageController.text = cubit.dosage ?? '';
    selectedMedicineType = cubit.medicineType;
  }

  @override
  void dispose() {
    dosageController.dispose();
    super.dispose();
  }

  void _saveDosageData() {
    // نحفظ الداتا في الـ Cubit
    context.read<AddMedicineCubit>().dosage = dosageController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // نحفظ الداتا كل ما الـ widget يتبني
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _saveDosageData();
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
                  ProgressBar(isPage: 1),
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
                    const AddPageReturnIcon(),
                    SizedBox(height: 20),
                    ScreenInfo(
                      imagePath: AppImages.medicineDosageScreenIcon,
                      title: AppTexts.dosageAndType,
                      subtitle: AppTexts.howMuchAndWhatType,
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          children: [
                            Text(
                              AppTexts.dosage,
                              style: AppTextsStyle.poppinsRegular25(context)
                                  .copyWith(
                                  fontSize: 15,
                                  color: AppColors.black.withOpacity(0.6)),
                            ),
                            const SizedBox(height: 8),
                            CustomInputField(
                              controller: dosageController,
                              hint: "e.g. 1 tablet, 1 spoon, 5 ml",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter dosage';
                                }
                                return null;
                              },
                            ),
                            MedicineTypeSelector(
                              selectedType: selectedMedicineType,
                              onTypeSelected: (type) {
                                setState(() {
                                  selectedMedicineType = type;
                                });
                                context.read<AddMedicineCubit>().medicineType = type;
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