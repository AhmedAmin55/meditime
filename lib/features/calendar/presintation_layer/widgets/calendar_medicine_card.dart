// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

// Project imports:
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/models/medicine_model.dart';
import '../../business_logic_layer/days_cubit/days_cubit.dart';

class CalendarMedicineCard extends StatelessWidget {
  final List<MedicineModel> medicine;
final int index;
  const CalendarMedicineCard({super.key, required this.medicine, required this.index});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    String time = "";
    final today = context.read<DaysCubit>().selectedDate;

    final todayStatus = medicine[index].reminderTimesStatus.where((s) {
      final d = s.reminderTime.toDate();
      return d.year == today.year &&
          d.month == today.month &&
          d.day == today.day;
    }).toList();

    if (todayStatus.isNotEmpty) {
      todayStatus.sort((a, b) => a.reminderTime.compareTo(b.reminderTime));
      time = DateFormat(
        'hh:mm a',
      ).format(todayStatus.first.reminderTime.toDate());
    }

    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.18,
      isFirst: medicine[index] == 0? false:true ,
      indicatorStyle: const IndicatorStyle(
        width: 6,
        color: AppColors.timeLineColor,
      ),
      beforeLineStyle: const LineStyle(
        color: AppColors.timeLineColor,
        thickness: 0.5,
      ),
      afterLineStyle: const LineStyle(
        color: AppColors.timeLineColor,
        thickness: 0.5,
      ),
      startChild: Padding(
        padding: const EdgeInsets.only(right: 5, bottom: 32),
        child: Text(
          time,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ),
      endChild: Container(
        height: 70,
        margin: const EdgeInsets.only(bottom: 15, left: 15, right: 5),
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.medicineBorderColor),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(right: 10),
          leading: Image.asset(
            _getIcon(medicine[index].medicineType),
            width: width * 0.10,
          ),
          title: Text(
            medicine[index].medicineName,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            medicine[index].medicineType,
            style: const TextStyle(fontSize: 11),
          ),
          trailing: Container(
            width: width*0.08,
            height: height*0.012,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _getStatusColor(medicine[index].currentStatus),
            ),
          ),
        ),
      ),
    );
  }

  String _getIcon(String type) {
    switch (type.toLowerCase()) {
      case "pills":
        return AppImages.pillsIcon;
      case "injection":
        return AppImages.injectionIcon;
      case "liquid":
        return AppImages.liquidIcon;
      case "cream":
        return AppImages.creamIcon;
      default:
        return AppImages.pillsIcon;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "taken":
        return AppColors.takenMedicineColor;
      case "missed":
        return AppColors.missedMedicineColor;
      case "waiting":
        return AppColors.waitingMedicineColor;
      default:
        return Colors.grey;
    }
  }
}
