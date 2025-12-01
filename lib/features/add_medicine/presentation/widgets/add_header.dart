// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:meditime/core/constants/app_images.dart';
import 'package:meditime/core/constants/app_texts.dart';

class AddHeader extends StatelessWidget {
  const AddHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppTexts.addMedicationForYourselfOrFriends),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Text(AppTexts.hopeToGetBetterSoon),
              ),
            ],
          ),
        ),
        SizedBox(width: 25),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage(AppImages.logo),
          ),
        ),
      ],
    );
  }
}
