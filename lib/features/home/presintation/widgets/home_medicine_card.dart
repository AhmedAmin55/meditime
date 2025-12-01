// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../../../core/models/medicine_model.dart';

class HomeMedicineCard extends StatelessWidget {
  final MedicineModel medicine;

  const HomeMedicineCard({super.key, required this.medicine});

  String _getReminderTime() {
    if (medicine.reminderTimes.isEmpty) return "لا يوجد وقت";
    final first = medicine.reminderTimes.first;
    return "${first.hour.padLeft(2, '0')}:${first.minute.padLeft(2, '0')} ${first.period}";
  }

  Color _getStatusColor() {
    switch (medicine.currentStatus.toLowerCase()) {
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
    switch (medicine.currentStatus.toLowerCase()) {
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

    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 15, left: 16, right: 23),
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
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
                  const SizedBox(width: 4),
                  Text(
                    _getReminderTime(),
                    style: AppTextsStyle.poppinsMedium20(
                      context,
                    ).copyWith(fontSize: 13, color: AppColors.timeColor),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              Text(
                medicine.medicineName,
                style: AppTextsStyle.spaceGroteskMedium22(context),
              ),
              const SizedBox(height: 4),

              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: AppColors.numberOfCapsuleColor,
                        ),
                        children: [
                          TextSpan(
                            text: medicine.dosage,
                            style: AppTextsStyle.spaceGroteskRegular13(
                              context,
                            ).copyWith(fontSize: 15),
                          ),
                          if (medicine.medicineType.isNotEmpty)
                            TextSpan(
                              text: " (${medicine.medicineType})",
                              style: AppTextsStyle.spaceGroteskRegular13(
                                context,
                              ).copyWith(fontSize: 12),
                            ),
                        ],
                      ),
                    ),
                    if (medicine.specialInstructions.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        medicine.specialInstructions,
                        style: AppTextsStyle.spaceGroteskRegular13(context)
                            .copyWith(
                              fontSize: 12,
                              color: AppColors.numberOfCapsuleColor,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),

          Row(
            children: [
              Icon(
                _getStatusIcon(),
                color: _getStatusColor(),
                size: width * 0.05,
              ),
              const SizedBox(width: 4),
              Text(
                medicine.currentStatus.capitalize(),
                style: AppTextsStyle.poppinsRegular25(
                  context,
                ).copyWith(fontSize: 15, color: _getStatusColor()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
