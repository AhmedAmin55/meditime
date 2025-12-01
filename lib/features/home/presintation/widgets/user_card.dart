// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:meditime/features/home/presintation/widgets/no_found_age.dart';
import '../../../../core/business_logic/user_cubit/user_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_textstyle.dart';
import 'medication_status.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AspectRatio(
      aspectRatio: 3 / 1.8,
      child: Card(
        margin: EdgeInsets.only(right: 7),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.only(
            left: 22,
            right: 22,
            top: height * 0.03,
            bottom: height * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.userCardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(AppImages.logo),
                  ),
                  const SizedBox(width: 15),
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      if (state is UserLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user.name,
                              style: AppTextsStyle.poppinsBold15(
                                context,
                              ).copyWith(fontSize: 16, color: AppColors.white),
                            ),
                            const SizedBox(height: 5),
                            if (state.user.age != null) ...[
                              Text(
                                "${state.user.age} years old",
                                style: AppTextsStyle.poppinsRegular25(context)
                                    .copyWith(
                                      fontSize: 14,
                                      color: AppColors.ageColor,
                                    ),
                              ),
                            ],
                            if (state.user.age == null) ...[NoFoundAge()],
                          ],
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 60,
                            height: 14,
                            decoration: BoxDecoration(
                              color: AppColors.ageColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              Flexible(child: SizedBox(height: height * 0.02)),
              Divider(color: Colors.white.withOpacity(0.1), thickness: 1),
              Flexible(child: SizedBox(height: height * 0.02)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width * 0.35,
                    height: height * 0.04,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Link Member",
                          style: AppTextsStyle.leagueSpartanRegular14(context),
                        ),
                        SizedBox(width: 5),
                        Image.asset(
                          AppImages.linkMemberIcon,
                          width: width * 0.053,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: width * 0.28,
                    height: height * 0.05,
                    child: Flexible(
                      child: Stack(
                        alignment: Alignment.center,
                        children: List.generate(4, (index) {
                          return Positioned(
                            left: 20.0 * index,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                AppImages.facebookIcon,
                              ),
                              backgroundColor: Colors.blue.shade200,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      AppImages.arrowRight,
                      width: width * 0.07,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              Flexible(child: SizedBox(height: height * 0.04)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MedicationStatus(
                    Icon: AppImages.missedIcon,
                    count: 1,
                    statusName: "Missed",
                  ),
                  const SizedBox(width: 15),
                  MedicationStatus(
                    Icon: AppImages.missedIcon,
                    count: 2,
                    statusName: "Taken",
                  ),
                  const SizedBox(width: 15),
                  MedicationStatus(
                    Icon: AppImages.missedIcon,
                    count: 1,
                    statusName: "Waiting",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
