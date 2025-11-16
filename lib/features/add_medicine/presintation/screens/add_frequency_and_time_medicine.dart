import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/features/add_medicine/presintation/widgets/screen_info.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../../../core/widgets/primary_appbar.dart';
import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import '../widgets/add_page_return_icon.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/customize_days_widget.dart';
import '../widgets/durationinputField.dart';
import '../widgets/progress_bar.dart';
import '../widgets/reminder_times_widget.dart';

class AddFrequencyAndTimeMedicineState extends StatelessWidget {
  final TextEditingController _durationController = TextEditingController();
  String _selectedUnit = "days";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                    ProgressBar(isPage: 2),
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
                        imagePath: AppImages.medicineFrequencyScreenIcon,
                        title: AppTexts.frequencyAndTime,
                        subtitle: AppTexts.howOftenDoYouTakeThis,
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            children: [
                              // ===== Duration Input Field =====
                              DurationInputField(
                                numberController: _durationController,
                                selectedUnit: _selectedUnit,
                                onUnitChanged: (value) {
                                  _selectedUnit = value ?? "days";
                                },
                              ),
                              const CustomizeDaysWidget(),
                              const SizedBox(height: 20),
                              // ===== Reminder Times =====
                              const ReminderTimesWidget(),
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
      ),
    );
  }
}

// Expanded(
//   child: Stack(
//     children: [
//       const AddPageBackground(),
//       SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             children: [
//               const SizedBox(height: 90),
//               ScreenInfo(
//                 imagePath: AppImages.medicineFrequencyScreenIcon,
//                 title: AppTexts.frequencyAndTime,
//                 subtitle: AppTexts.howOftenDoYouTakeThis,
//               ),
//               const SizedBox(height: 32),
//               // ===== Duration Input Field =====
//               DurationInputField(
//                 numberController: _durationController,
//                 selectedUnit: _selectedUnit,
//                 onUnitChanged: (value) {
//                   setState(() {
//                     _selectedUnit = value ?? "days";
//                   });
//                 },
//               ),
//
//               const SizedBox(height: 20),
//
//               // ===== Customize Days =====
//               const CustomizeDaysWidget(),
//
//               const SizedBox(height: 20),
//
//               // ===== Reminder Times =====
//               const ReminderTimesWidget(),
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
