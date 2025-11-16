import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class AddPageBackground extends StatelessWidget {
  const AddPageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      height: MediaQuery.of(context).size.height - 160,
    );
  }
}
