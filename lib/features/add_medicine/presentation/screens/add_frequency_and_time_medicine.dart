import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../../../core/widgets/primary_appbar.dart';
import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import '../widgets/add_page_return_icon.dart';
import '../widgets/customize_days_widget.dart';
import '../widgets/durationinputField.dart';
import '../widgets/progress_bar.dart';
import '../widgets/reminder_times_widget.dart';
import '../widgets/screen_info.dart';

class AddFrequencyAndTimeMedicineState extends StatelessWidget {
  const AddFrequencyAndTimeMedicineState({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddMedicineCubit>();

    // أول ما تدخل الصفحة نضمن إن فيه سطر وقت واحد على الأقل
    if (cubit.uiRows.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        cubit.addEmptyReminder();
      });
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Header
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
                    ProgressBar(isPage: 2),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // الجسم
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.addBackground,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const AddPageReturnIcon(),
                        const SizedBox(height: 20),
                        ScreenInfo(
                          imagePath: AppImages.medicineFrequencyScreenIcon,
                          title: AppTexts.frequencyAndTime,
                          subtitle: AppTexts.howOftenDoYouTakeThis,
                        ),
                        const SizedBox(height: 20),

                        // Duration + Unit
                        DurationInputField(),

                        const SizedBox(height: 20),

                        // Notify Me
                        const CustomizeDaysWidget(),

                        const SizedBox(height: 30),

                        // Reminder Times
                        const ReminderTimesWidget(),

                        const SizedBox(height: 120),
                      ],
                    ),
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
