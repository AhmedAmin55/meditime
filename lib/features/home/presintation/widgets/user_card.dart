import 'package:flutter/material.dart';
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "sgesrgesg",
                        style: AppTextsStyle.poppinsBold15(
                          context,
                        ).copyWith(fontSize: 16, color: AppColors.white),
                      ),
                      const SizedBox(height: 5),

                      Text(
                        "zrhdhxrh",
                        style: AppTextsStyle.poppinsRegular25(
                          context,
                        ).copyWith(fontSize: 14, color: AppColors.ageColor),
                      ),
                    ],
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
                              // child: Image.asset(AppImages.logo,fit: BoxFit.fill,),
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

Widget _buildProfileSection() {
  return Row(
    children: [
      CircleAvatar(radius: 25, backgroundImage: AssetImage("")),
      const SizedBox(width: 15),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "",
            style: const TextStyle(fontSize: 16, color: Color(0xFFCBE1FF)),
          ),
        ],
      ),
    ],
  );
}

Widget _buildDivider() {
  return Divider(color: Colors.white.withOpacity(0.1), thickness: 1);
}

Widget _buildLinkMemberSection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
        ),
        onPressed: () {},
        icon: const Icon(
          Icons.person_add_alt_outlined,
          size: 20,
          color: Colors.black,
        ),
        label: const Text(
          "Link Member",
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
      Row(
        children: [
          _buildMemberAvatars(),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    ],
  );
}

Widget _buildMemberAvatars() {
  return SizedBox(
    width: 90,
    height: 40,
    child: Stack(
      children: List.generate(3, (index) {
        return Positioned(
          left: 25.0 * index,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue.shade200,
            child: const Icon(Icons.person, color: Colors.white, size: 18),
          ),
        );
      }),
    ),
  );
}

Widget _buildStatusSection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildStatusItem(),
      const SizedBox(width: 15),
      _buildStatusItem(),
      const SizedBox(width: 15),
      _buildStatusItem(),
    ],
  );
}

Widget _buildStatusItem() {
  return Row(
    children: [
      Icon(Icons.eleven_mp, color: Colors.white, size: 20),
      const SizedBox(width: 5),
      Text("taken", style: const TextStyle(fontSize: 14, color: Colors.white)),
    ],
  );
}
