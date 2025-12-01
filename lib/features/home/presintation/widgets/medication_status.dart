// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyle.dart';

class MedicationStatus extends StatelessWidget {
  const MedicationStatus({
    super.key,
    required this.Icon,
    required this.count,
    required this.statusName,
  });

  final String Icon;
  final int count;
  final String statusName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(Icon, width: 20, height: 20),
        SizedBox(width: 7),
        Text(
          count.toString(),
          style: AppTextsStyle.poppinsBold15(
            context,
          ).copyWith(fontSize: 14, color: AppColors.white),
        ),
        SizedBox(width: 5),
        Text(
          statusName,
          style: AppTextsStyle.poppinsRegular25(
            context,
          ).copyWith(fontSize: 12, color: AppColors.white),
        ),
      ],
    );
  }
}
