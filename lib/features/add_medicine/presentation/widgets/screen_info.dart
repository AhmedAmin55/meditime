// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:meditime/core/constants/app_textstyle.dart';
import '../../../../core/constants/app_colors.dart';

class ScreenInfo extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const ScreenInfo({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        children: [
          Image.asset(imagePath, width: width * 0.25),
          const SizedBox(height: 12),
          Text(title, style: AppTextsStyle.montserratSemiBold22(context)),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: AppTextsStyle.montserratSemiBold22(
              context,
            ).copyWith(color: AppColors.timeColor, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
