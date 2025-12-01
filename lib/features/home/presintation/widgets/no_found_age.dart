// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../core/business_logic/user_cubit/user_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyle.dart';

class NoFoundAge extends StatelessWidget {
  NoFoundAge({super.key});

  DateTime pickedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return DatePickerDialog(
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
              helpText: "Add your birth date",
            );
          },
        ).then((value) {
          if (value != null) {
            pickedDate = value;
            var userAge = DateTime.now().year - pickedDate.year;
            print(pickedDate);
            print(userAge);
            context.read<UserCubit>().updateAge(
              FirebaseAuth.instance.currentUser!.uid,
              userAge,
            );
          }
        });
      },
      child: Text(
        "Tap here to add your age",
        style: AppTextsStyle.poppinsRegular25(
          context,
        ).copyWith(fontSize: 14, color: AppColors.ageColor),
      ),
    );
  }
}
