// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../core/constants/app_colors.dart';

class ActiveSearchBar extends StatelessWidget {
  const ActiveSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        cursorColor: AppColors.splashScreenColor.withOpacity(0.8),
        cursorHeight: 15,
        decoration: InputDecoration(
          border: _borderDecoration(),
          focusedBorder: _borderDecoration(),
          enabledBorder: _borderDecoration(),
          hintText: "Search Here",
          hintStyle: TextStyle(
            color: AppColors.splashScreenColor.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  InputBorder _borderDecoration() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: AppColors.splashScreenColor),
    );
  }
}
