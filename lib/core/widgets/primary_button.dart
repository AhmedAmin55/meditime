// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../constants/app_textstyle.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.color,
    required this.width,
    required this.title,
    required this.height,
    this.onTap,
  });

  final Color color;
  final double width;
  final double height;
  final String title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextsStyle.merriweatherRegular20(context),
          ),
        ),
      ),
    );
  }
}
