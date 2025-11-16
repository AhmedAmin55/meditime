import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../../../core/models/medicine_model.dart';
class HomeMedicineCard extends StatelessWidget {
  final int index;


  const HomeMedicineCard({
    super.key, required this.index,

  });

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

  IconData _getStatusIcon() {
    switch (medicineList[index].status.toLowerCase()) {
      case "missed":
        return Icons.error_outline;
      case "taken":
        return Icons.check_circle_outline;
      case "waiting":
        return Icons.access_time_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 15, left: 16, right: 23),
      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImages.clockIcon,
                    width: width * 0.05,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: width * 0.01),
                  Text(
                    DateFormat('hh:mm a').format(medicineList[index].reminderTimes),
                    style: AppTextsStyle.poppinsMedium20(
                      context,
                    ).copyWith(fontSize: 13, color: AppColors.timeColor),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(medicineList[index].medicineName, style: AppTextsStyle.spaceGroteskMedium22(context)),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "1 capsule",
                            style: AppTextsStyle.spaceGroteskRegular13(context)
                                .copyWith(
                              fontSize: 15,
                              color: AppColors.numberOfCapsuleColor,
                            ),
                          ),
                          TextSpan(
                            text: " (pill)",
                            style: AppTextsStyle.spaceGroteskRegular13(context)
                                .copyWith(
                              fontSize: 12,
                              color: AppColors.numberOfCapsuleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      medicineList[index].specialInstructions,
                      style: AppTextsStyle.spaceGroteskRegular13(
                        context,
                      ).copyWith(fontSize: 12, color: AppColors.numberOfCapsuleColor),
                    ),
                  ],
                ),
              )
            ],
          ),
          Spacer(),
          Row(
            children: [
              Icon(
                _getStatusIcon(),
                color: _getStatusColor(),
                size: width * 0.05,
              ),
              const SizedBox(width: 4),
              Text(
                  medicineList[index].status,
                style:AppTextsStyle.poppinsRegular25(context).copyWith(fontSize: 15,color:_getStatusColor() )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
