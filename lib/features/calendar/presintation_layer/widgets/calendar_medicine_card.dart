import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../../../core/models/medicine_model.dart';
class CalendarMedicineCard extends StatelessWidget {
  const CalendarMedicineCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return TimelineTile(
      alignment: TimelineAlign.manual,
      isFirst: index == 0 ? true : false,
      isLast: index == 9 ? true : false,
      lineXY: 0.18,
      indicatorStyle: IndicatorStyle(
        color: AppColors.timeLineColor,
        width: 6,
        indicatorXY: 0.3,
      ),
      beforeLineStyle: LineStyle(
        color: AppColors.timeLineColor,
        thickness: 0.5,
      ),
      afterLineStyle: LineStyle(color: AppColors.timeLineColor, thickness: 0.5),
      startChild: Padding(
        padding: const EdgeInsets.only(right: 5, bottom: 32),
        child: Text(
         DateFormat("hh:mm a").format(medicineList[index].reminderTimes),
          style: AppTextsStyle.spaceGroteskMedium22(
            context,
          ).copyWith(fontSize: 11),
        ),
      ),
      endChild: Container(
        height: height * 0.08,
        margin: EdgeInsets.only(bottom: 15, left: 15, right: 5),
        padding: EdgeInsets.only(bottom: 10, left: 10, right: 0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: AppColors.medicineBorderColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.medicineBorderColor,
              spreadRadius: 1.5,
              blurRadius: 0.5,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Image.asset(_medicineTypeIcon(), width: width * 0.10),
          title: Text(
            medicineList[index].medicineName,
            style: AppTextsStyle.spaceGroteskMedium22(
              context,
            ).copyWith(fontSize: 13),
          ),
          subtitle: Text(
            medicineList[index].medicineType,
            style: AppTextsStyle.spaceGroteskRegular13(
              context,
            ).copyWith(fontSize: 11),
          ),
          trailing: Container(
            height: height * 0.010,
            width: width * 0.055,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: _getStatusColor(),
            ),
          ),
        ),
      ),
    );
  }

  _medicineTypeIcon() {
    switch (medicineList[index].medicineType) {
      case "pills":
        return AppImages.pillsIcon;
      case "injection":
        return AppImages.injectionIcon;
      case "liquid":
        return AppImages.liquidIcon;
      case "cream":
        return AppImages.creamIcon;
    }
  }

  Color _getStatusColor() {
    switch (medicineList[index].status.toLowerCase()) {
      case "missed":
        return AppColors.missedMedicineColor;
      case "taken":
        return AppColors.takenMedicineColor;
      case "waiting":
        return AppColors.waitingMedicineColor;
      default:
        return Colors.grey;
    }
  }
}
