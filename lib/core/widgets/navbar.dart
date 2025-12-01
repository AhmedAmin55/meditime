// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:meditime/core/constants/app_colors.dart';
import 'package:meditime/core/constants/app_images.dart';
import 'package:meditime/core/services/user_medicine_service.dart';
import 'package:meditime/features/add_medicine/business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import 'package:meditime/features/add_medicine/presentation/screens/add_medicine_flow_screen.dart';
import 'package:meditime/features/calendar/presintation_layer/screens/calendar_screen.dart';
import 'package:meditime/features/home/presintation/screens/home_screen.dart';
import 'package:meditime/features/notification/presintation/screens/notifications_screen.dart';
import 'package:meditime/features/profile/presintation/screens/profile_screen.dart';
import '../business_logic/nav_cubit/nav_cubit.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavCubit, NavState>(
        builder: (context, navState) {
          if (navState is NavCalendar) {
            return const CalendarScreen();
          } else if (navState is NavNotification) {
            return NotificationsScreen();
          } else if (navState is NavProfile) {
            return ProfileScreen();
          } else if (navState is NavAdd) {
            return const AddMedicineFlowScreen();
          } else {
            return const HomeScreen();
          }
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
    final navCubit = context.watch<NavCubit>();
    bool isSelected = navCubit.currentIndex == index;
    return GestureDetector(
      onTap: () => navCubit.changeScreen(index: index),
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
    return BlocBuilder<AddMedicineCubit, AddMedicineState>(
      builder: (context, state) {
        final addCubit = context.read<AddMedicineCubit>();
        final navCubit = context.read<NavCubit>();
        final bool isInAddFlow = navCubit.currentIndex == 2;

        final bool canProceed = state is AddMedicineInProgress
            ? addCubit.canGoNext
            : true;
        final int currentPage = state is AddMedicineInProgress
            ? state.currentPage
            : 0;
        final bool isLastPage = currentPage == 3;

        return GestureDetector(
          onTap: () async {
            if (!isInAddFlow) {
              addCubit.reset();
              navCubit.changeScreen(index: 2);
              return;
            }

            if (!canProceed && !isLastPage) {
              return;
            }

            if (isLastPage) {
              try {
                final rawTimes = addCubit.uiRows.map((row) {
                  return {
                    'hour': row.hour.trim(),
                    'minute': row.minute.trim().padLeft(2, '0'),
                    'period': row.period,
                  };
                }).toList();

                await UserMedicineService().addUserMedicine(
                  medicineName: addCubit.medicineName.text.trim(),
                  specialInstructions: addCubit.specialInstructions.text,
                  assignToWho: addCubit.assignTo.text,
                  medicineType: addCubit.selectedType,
                  dosage: addCubit.dosage.text.trim(),
                  durationInDays: addCubit.duration,
                  customDay: addCubit.notifyMe,
                  customTimes: rawTimes,
                );

                addCubit.reset();
                navCubit.changeScreen(index: 0);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Medicine added successfully!"),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Error: $e"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              return;
            }

            addCubit.goNext();
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
            child: Center(
              child: isInAddFlow
                  ? (canProceed
                        ? (isLastPage
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 28,
                                )
                              : const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 24,
                                ))
                        : Image.asset(
                            AppImages.addWaitingIcon,
                            width: 25,
                            color: Colors.white,
                          ))
                  : Image.asset(
                      AppImages.addScreenIcon,
                      width: 17,
                      color: Colors.white,
                    ),
            ),
          ),
        );
      },
    );
  }
}
