// features/add_medicine/presentation/screens/add_review_and_save_medicine.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/core/constants/app_colors.dart';
import 'package:meditime/core/constants/app_images.dart';
import 'package:meditime/core/constants/app_texts.dart';
import 'package:meditime/core/constants/app_textstyle.dart';
import '../../../../core/widgets/primary_appbar.dart';
import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import '../widgets/add_page_return_icon.dart';
import '../widgets/progress_bar.dart';
import '../widgets/screen_info.dart';
import '../widgets/summary.dart';

class AddReviewAndSaveMedicine extends StatelessWidget {
  const AddReviewAndSaveMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AddMedicineCubit>();

    return Scaffold(
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
                  ProgressBar(isPage: 3),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // الجسم
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
                decoration: const BoxDecoration(
                  color: AppColors.addBackground,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                ),
                child: Column(
                  children: [
                    const AddPageReturnIcon(),
                    const SizedBox(height: 20),

                    ScreenInfo(
                      imagePath: AppImages.medicineReviewScreenIcon,
                      title: AppTexts.reviewAndSave,
                      subtitle: AppTexts.everythingLooksGood,
                    ),
                    const SizedBox(height: 30),

                    // Summary (هنا بيجيب البيانات من الـ Cubit)
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Summary(
                          medicineName: cubit.medicineName.text.trim().isEmpty ? "Not set" : cubit.medicineName.text,
                          assignTo: cubit.assignTo.text.isEmpty ? "Me" : cubit.assignTo.text,
                          specialInstructions: cubit.specialInstructions.text.isEmpty ? "None" : cubit.specialInstructions.text,
                          dosage: cubit.dosage.text.trim().isEmpty ? "Not set" : cubit.dosage.text,
                          medicineType: cubit.selectedType,
                          reminderTimes: cubit.notifyMe,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meditime/core/constants/app_textstyle.dart';
// import 'package:meditime/core/widgets/primary_appbar.dart';
//
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/app_images.dart';
// import '../../../../core/constants/app_texts.dart';
// import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';
// import '../widgets/add_page_background.dart';
// import '../widgets/add_page_return_icon.dart';
// import '../widgets/progress_bar.dart';
// import '../widgets/screen_info.dart';
// import '../widgets/summary.dart';
//
// class AddReviewAndSaveMedicine extends StatelessWidget {
//   const AddReviewAndSaveMedicine({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 children: [
//                   PrimaryAppbar(
//                     title: AppTexts.addMedicationForYourselfOrFriends,
//                     titleStyle: AppTextsStyle.poppinsMedium20(
//                       context,
//                     ).copyWith(fontSize: 15),
//                     subtitle: AppTexts.hopeToGetBetterSoon,
//                     subtitleStyle: AppTextsStyle.poppinsBold15(
//                       context,
//                     ).copyWith(fontSize: 10, color: AppColors.timeColor),
//                     imagePath: AppImages.logo,
//                   ),
//                   const SizedBox(height: 8),
//                   ProgressBar(isPage: 3),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 8),
//             Expanded(
//               child: Container(
//                 height: height,
//                 width: width,
//                 margin: EdgeInsets.only(top: 10, right: 12, left: 12),
//                 decoration: BoxDecoration(
//                   color: AppColors.addBackground,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     topRight: Radius.circular(12),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     const AddPageReturnIcon(),
//                     SizedBox(height: 20),
//                     ScreenInfo(
//                       imagePath: AppImages.medicineReviewScreenIcon,
//                       title: AppTexts.reviewAndSave,
//                       subtitle: AppTexts.everythingLooksGood,
//                     ),
//                     SizedBox(height: 20),
//                     Expanded(
//                       child: Container(
//                         child: ListView(
//                           children: [
//                             Summary(
//                               medicineName: "Vitamine",
//                               assignTo: "Sister",
//                               specialInstructions:
//                                   "Before food and after sleep",
//                               dosage: "1 ml",
//                               medicineType: "Liquid",
//                               reminderTimes: "Everyday",
//                             ),
//                             SizedBox(height: 20),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Expanded(
// //   child: Stack(
// //     children: [
// //       const AddPageBackground(),
// //       SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 24),
// //           child: Column(
// //             children: [
// //               const SizedBox(height: 90),
// //               ScreenInfo(
// //                 imagePath:AppImages.medicineReviewScreenIcon,
// //                 title: AppTexts.reviewAndSave,
// //                 subtitle: AppTexts.everythingLooksGood,
// //               ),
// //
// //               const SizedBox(height: 80),
// //
// //               Center(
// //                 child: const Summary(
// //                   medicineName: "Vitamine",
// //                   assignTo: "Sister",
// //                   specialInstructions: "Before food and after sleep",
// //                   dosage: "1 ml",
// //                   medicineType: "Liquid",
// //                   reminderTimes: "Everyday",
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 40),
// //             ],
// //           ),
// //         ),
// //       ),
// //     ],
// //   ),
// // ),
