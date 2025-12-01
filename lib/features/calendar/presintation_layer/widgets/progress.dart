// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../core/constants/app_colors.dart';

class ProgressSection extends StatelessWidget {
  const ProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "0 of 5 medicines taken today",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: 1 / 5,
            minHeight: 5,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: AppColors.progressIndicatorBackgroundColor,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.splashScreenColor,
            ),
          ),
        ],
      ),
    );
  }
}
