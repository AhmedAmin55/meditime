// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../core/constants/app_colors.dart';

class CustomAuthWith extends StatelessWidget {
  const CustomAuthWith({super.key, required this.icon, required this.onTap});

  final String icon;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height * 0.06,
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(23),
              boxShadow: [
                BoxShadow(
                  color: AppColors.waitingMedicineColor.withOpacity(0.5),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Center(child: Image.asset(icon, width: width * 0.06)),
          ),
        ),
      ),
    );
  }
}
