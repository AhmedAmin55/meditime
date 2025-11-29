import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/core/constants/app_images.dart';
import 'package:meditime/core/constants/app_texts.dart';
import 'package:meditime/features/add_medicine/presintation/screens/add_dosage_and_type_medicine.dart';
import 'package:meditime/features/add_medicine/presintation/screens/add_frequency_and_time_medicine.dart';
import 'package:meditime/features/add_medicine/presintation/screens/add_name_medicine.dart';
import 'package:meditime/features/add_medicine/presintation/screens/add_review_and_save_medicine.dart';
import '../../features/add_medicine/business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import '../../features/calendar/presintation_layer/screens/calendar_screen.dart';
import '../../features/home/presintation/screens/home_screen.dart';
import '../../features/notification/presintation/screens/notifications_screen.dart';
import '../../features/profile/presintation/screens/profile_screen.dart';
import '../business_logic/nav_cubit/nav_cubit.dart';
import '../business_logic/user_cubit/user_cubit.dart';
import '../constants/app_colors.dart';

class Navbar extends StatelessWidget {
  @override
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavCubit, NavState>(
        builder: (navCtx, navState) {
          return BlocBuilder<AddMedicineCubit, AddMedicineState>(
            builder: (addCtx, addState) {
              if (navState is NavCalendar) {
                return CalendarScreen();
              } else if (navState is NavAdd) {
                if (addState is AddMedicineDosage) {
                  return AddDosageAndTypeMedicine();
                } else if (addState is AddMedicineFrequency) {
                  return AddFrequencyAndTimeMedicineState();
                } else if (addState is AddMedicineReview) {
                  return AddReviewAndSaveMedicine();
                } else {
                  return AddNameMedicine();
                }
              } else if (navState is NavNotification) {
                return NotificationsScreen();
              } else if (navState is NavProfile) {
                return ProfileScreen();
              } else {
                return HomeScreen();
              }
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 15,
              left: 15,
              bottom: 5,
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(context, AppImages.homeScreenIcon, 0),
                _buildNavItem(context, AppImages.calendarScreenIcon, 1),
                _buildAddButton(context),
                _buildNavItem(context, AppImages.notificationScreenIcon, 3),
                _buildNavItem(context, AppImages.profileScreenIcon, 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String icon, int index) {
    final navListener = context.watch<NavCubit>();
    bool isSelected = navListener.currentIndex == index;
    return GestureDetector(
      onTap: () {
        BlocProvider.of<NavCubit>(context).changeScreen(index: index);
        if (index == 4) {}
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blueAccent.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          icon,
          width: 25,
          color: isSelected ? AppColors.splashScreenColor : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final navCubit = context.read<NavCubit>();
        final addCubit = context.read<AddMedicineCubit>();
        if (navCubit.currentIndex != 2) {
          addCubit.addMedicineChanger(newIndex: 0);
          navCubit.changeScreen(index: 2);
        } else {
          int nextIndex = addCubit.isPage + 1;
          print(nextIndex);
          if (nextIndex <= 3) {
            addCubit.addMedicineChanger(newIndex: nextIndex);
            if(context.read<AddMedicineCubit>().namePageKey.currentState!.validate()){
              print("===========><========");
            }
          } else {
            firestore
                .collection("user_medicines")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set({
                  "medicine_name": context
                      .read<AddMedicineCubit>()
                      .medicineName
                      .text,
                  "special_instructions": context
                      .read<AddMedicineCubit>()
                      .specialInstructions
                      .text,
                  "assign_to_who": context
                      .read<AddMedicineCubit>()
                      .assignTo
                      .text,
                  "medicine_type": context
                      .read<AddMedicineCubit>()
                      .selectedType,
                  "dosage": context.read<AddMedicineCubit>().dosage.text,
                  "duration_in_days": context.read<AddMedicineCubit>().duration,
                  "custom_day": context.read<AddMedicineCubit>().notifyMe,
                  "custom_times": context
                      .read<AddMedicineCubit>()
                      .reminderTimes.map((e)=> e.toMap()).toList(),
                }, SetOptions(merge: true));
            print(context.read<AddMedicineCubit>().medicineName.text);
            print(context.read<AddMedicineCubit>().specialInstructions.text);
            print(context.read<AddMedicineCubit>().assignTo.text);
            print(context.read<AddMedicineCubit>().selectedType);
            print(context.read<AddMedicineCubit>().dosage.text);
            print(context.read<AddMedicineCubit>().reminderTimes);
            addCubit.isPage = 0;
            navCubit.changeScreen(index: 0);
            context.read<AddMedicineCubit>().reminderTimes.clear();
            context.read<AddMedicineCubit>().uiRows.clear();

          }
        }
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: BlocProvider.of<NavCubit>(context).currentIndex == 2
            ? Center(child: Image.asset(AppImages.addWaitingIcon, width: 28))
            : Center(child: Image.asset(AppImages.addScreenIcon, width: 17)),
      ),
    );
  }
}
