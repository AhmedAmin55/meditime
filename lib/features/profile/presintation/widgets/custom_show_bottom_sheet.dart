import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';

class CustomShowBottomSheet extends StatefulWidget {
  const CustomShowBottomSheet({
    super.key,
    required this.onTapForCamera,
    required this.onTapForGallery,
  });

  final GestureTapCallback onTapForCamera;
  final GestureTapCallback onTapForGallery;

  @override
  State<CustomShowBottomSheet> createState() => _CustomShowBottomSheetState();
}

class _CustomShowBottomSheetState extends State<CustomShowBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: widget.onTapForGallery,
            child: Container(
              height: height * 0.10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
                color: AppColors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo_camera_back_outlined, size: 30),
                  Text(
                    AppTexts.gallery,

                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: widget.onTapForCamera,
            child: Container(
              height: height * 0.10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
                color: AppColors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo_outlined, size: 30),
                  Text(
                    AppTexts.camera,

                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
