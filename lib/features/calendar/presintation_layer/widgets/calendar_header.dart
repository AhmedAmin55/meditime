// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dropdown_search/dropdown_search.dart';

// Project imports:
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  final List<String> days = const [
    "Ahmed Mohamed",
    "Hazem",
    "Wed",
    "Thu",
    "Fri",
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16),
      child: Row(
        children: [
          Text(
            AppTexts.hereIs,
            style: AppTextsStyle.poppinsRegular25(
              context,
            ).copyWith(fontSize: 16, color: AppColors.black),
          ),
          SizedBox(
            height: height * 0.027,
            width: width * 0.33,
            child: DropdownSearch<String>(
              items: (ah, sdf) {
                return days;
              },
              popupProps: PopupProps.menu(
                constraints: BoxConstraints(
                  maxHeight: height * 0.2,
                  minWidth: width * 0.5,
                ),
                scrollbarProps: ScrollbarProps(
                  padding: EdgeInsets.only(top: 15, bottom: 15, right: 3),
                  thumbColor: AppColors.splashScreenColor,
                  radius: Radius.circular(20),
                ),
                menuProps: MenuProps(
                  align: MenuAlign.bottomStart,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              suffixProps: DropdownSuffixProps(
                dropdownButtonProps: DropdownButtonProps(
                  iconOpened: Icon(Icons.keyboard_arrow_up_rounded),
                  iconClosed: Icon(Icons.keyboard_arrow_down_rounded),
                  padding: EdgeInsets.all(0),
                  style: IconButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                ),
              ),
              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 5, left: 6),
                  hintText: AppTexts.member,
                  hintStyle: AppTextsStyle.spaceGroteskMedium22(
                    context,
                  ).copyWith(fontSize: 15),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ),
          Text(
            AppTexts.schedule,
            style: AppTextsStyle.poppinsRegular25(
              context,
            ).copyWith(fontSize: 16, color: AppColors.black),
          ),
          Spacer(),
          Container(
            height: height * 0.065,
            width: width * 0.15,
            decoration: BoxDecoration(
              color: AppColors.takenMedicineColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
