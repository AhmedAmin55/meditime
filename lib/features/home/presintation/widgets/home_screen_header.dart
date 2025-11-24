import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/core/repo/user_repo.dart';
import 'package:meditime/features/home/presintation/widgets/user_card.dart';
import '../../../../core/business_logic/user_cubit/user_cubit.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../../../core/services/user_service.dart';
import '../../../../core/widgets/primary_appbar.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              return PrimaryAppbar(
                title:
                    "${AppTexts.goodMorning}, ${state.user.name.split(" ").first}",
                titleStyle: AppTextsStyle.poppinsRegular25(context),
                subtitle: AppTexts.hereIsYourMedicineScheduleForToday,
                subtitleStyle: AppTextsStyle.poppinsBold15(context),
                imagePath: AppImages.logo,
              );
            } else {
              return SizedBox();
            }
          },
        ),
        SizedBox(height: 15),
        UserCard(),
      ],
    );
  }
}
