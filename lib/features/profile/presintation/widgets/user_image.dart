import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meditime/features/profile/presintation/widgets/custom_show_bottom_sheet.dart';

import '../../../../core/business_logic/user_cubit/user_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

class UserImage extends StatelessWidget {
  UserImage({super.key, this.onTap});

  final GestureTapCallback? onTap;
  XFile? pickedImage;
  final ImagePicker imagePicker = ImagePicker();
  getImage({required ImageSource source}) async {
    pickedImage = await imagePicker.pickImage(source: source);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: width * 0.5,
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                if (state.user.profilePhoto == null) {
                return  CircleAvatar(
                    radius: width * 0.16,
                    backgroundColor: AppColors.splashScreenColor,
                    child: Image.asset(AppImages.personIcon, width: 80),
                  );
                } else if (state.user.profilePhoto != null) {
                return  CircleAvatar(
                    radius: width * 0.16,
                    backgroundColor: AppColors.splashScreenColor,
                    child: Image.network(state.user.profilePhoto.toString()),
                  );
                }else{
                  return SizedBox();
                }
              } else {
                return SizedBox();
              }
            },
          ),
        ),
        Positioned(
          bottom: 0,
          right: 30,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) => CustomShowBottomSheet(
                  onTapForCamera: () {
                    getImage(source: ImageSource.camera);
                    if (pickedImage != null) {
                      context.read<UserCubit>().updatePhoto(
                        FirebaseAuth.instance.currentUser!.uid,
                        pickedImage!,
                      );

                    }
                    Navigator.pop(context);
                  },
                  onTapForGallery: () async {
                    await getImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      context.read<UserCubit>().updatePhoto(
                        FirebaseAuth.instance.currentUser!.uid,
                        pickedImage!,
                      );
                      print("Picked image path: ${pickedImage!.path}");
                    }
                    Navigator.pop(context);
                  },
                ),
              );
            },
            child: Container(
              height: height * 0.055,
              width: width * 0.1,
              decoration: BoxDecoration(
                color: AppColors.changeUserImageColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  AppImages.addScreenIcon,
                  color: AppColors.splashScreenColor,
                  width: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
