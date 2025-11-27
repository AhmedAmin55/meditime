import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/core/constants/app_images.dart';
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
import '../constants/app_colors.dart';

class Navbar extends StatelessWidget {
  @override
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

          bool canProceed = _validateCurrentPage(context, addCubit);

          if (canProceed) {
            int nextIndex = addCubit.isPage + 1;
            print('Moving to page: $nextIndex');

            if (nextIndex <= 3) {

              addCubit.addMedicineChanger(newIndex: nextIndex);
            } else {

              addCubit.isPage = 0;
              navCubit.changeScreen(index: 0);
            }
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

  // ============ Validation Helper ============
  bool _validateCurrentPage(BuildContext context, AddMedicineCubit cubit) {
    switch (cubit.isPage) {
      case 0: // Page 0: Medicine Name
        if (cubit.nameFormKey.currentState?.validate() ?? false) {
          cubit.nameFormKey.currentState?.save();
          return true;
        }
        return false;

      case 1: // Page 1: Dosage & Type
        if (cubit.dosage == null || cubit.dosage!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please enter dosage'),
              backgroundColor: Colors.red,
            ),
          );
          return false;
        }
        if (cubit.medicineType == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please select medicine type'),
              backgroundColor: Colors.red,
            ),
          );
          return false;
        }
        return true;

      case 2: // Page 2: Frequency & Time
        if (cubit.durationNumber == null || cubit.durationNumber!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please enter duration'),
              backgroundColor: Colors.red,
            ),
          );
          return false;
        }
        if (cubit.reminderTimes == null || cubit.reminderTimes!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please add at least one reminder time'),
              backgroundColor: Colors.red,
            ),
          );
          return false;
        }
        return true;

      case 3: // Page 3: Review - Ready to save
        return true;

      default:
        return false;
    }
  }
}