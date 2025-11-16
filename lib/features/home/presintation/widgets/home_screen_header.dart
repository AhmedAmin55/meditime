import 'package:flutter/material.dart';
import 'package:meditime/features/home/presintation/widgets/user_card.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../../../core/widgets/primary_appbar.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryAppbar(
          title: AppTexts.goodMorning,
          titleStyle: AppTextsStyle.poppinsRegular25(context),
          subtitle: AppTexts.hereIsYourMedicineScheduleForToday,
          subtitleStyle: AppTextsStyle.poppinsBold15(context),
          imagePath: AppImages.logo,
        ),
        SizedBox(height: 15),
        UserCard()
      ],
    );
  }
}