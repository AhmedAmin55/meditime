// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';

// Project imports:
import 'package:meditime/core/constants/app_images.dart';
import 'package:meditime/core/constants/app_texts.dart';
import 'package:meditime/core/constants/app_textstyle.dart';
import 'package:meditime/core/widgets/primary_appbar.dart';
import 'package:meditime/features/notification/presintation/widgets/info_container.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/notification_model.dart';
import '../widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key, this.message});

  final RemoteMessage? message;
  final List<AppNotification> _items = [
    AppNotification(
      title: 'Medicine Due now',
      subtitle: 'Time to take panadol 500g',
      time: DateTime.now(),
      type: NotificationType.now,
    ),
    AppNotification(
      title: 'Missed Dose Alert',
      subtitle: 'You missed panadol 500g at 12:00',
      time: DateTime.now().subtract(Duration(hours: 8)),
      type: NotificationType.missed,
    ),
    AppNotification(
      title: 'taken Dose confirmed',
      subtitle: 'You have taken panadol 500g at 12:00',
      time: DateTime.now().subtract(Duration(hours: 3)),
      type: NotificationType.taken,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: PrimaryAppbar(
                title: AppTexts.alertsAndNotifications,
                titleStyle: AppTextsStyle.poppinsRegular25(
                  context,
                ).copyWith(color: AppColors.black),
                subtitle: AppTexts.newNotifications,
                subtitleStyle: AppTextsStyle.poppinsMedium20(
                  context,
                ).copyWith(fontSize: 13, color: AppColors.timeColor),
                imagePath: AppImages.logo,
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: InfoContainer(
                      title: AppTexts.taken,
                      value: "1:7",
                      Icon: AppImages.nofiTakenIcon,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: InfoContainer(
                      title: AppTexts.rate,
                      value: "20%",
                      Icon: AppImages.rateIcon,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                color: AppColors.scaffoldColor,
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (_, i) {
                    final it = _items[i];
                    return NotificationCard(
                      item: it,
                      onTake: () => ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Take now'))),
                      onSkip: () => ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Skipped'))),
                      onDismiss: () => ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Dismissed'))),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
