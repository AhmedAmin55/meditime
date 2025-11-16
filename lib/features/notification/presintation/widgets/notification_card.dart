import 'package:flutter/material.dart';
import 'package:meditime/core/constants/app_images.dart';
import 'package:meditime/core/constants/app_textstyle.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification item;
  final VoidCallback? onTake;
  final VoidCallback? onSkip;
  final VoidCallback? onDismiss;

  const NotificationCard({
    Key? key,
    required this.item,
    this.onTake,
    this.onSkip,
    this.onDismiss,
  }) : super(key: key);

  Color _bgForType(NotificationType t) {
    switch (t) {
      case NotificationType.missed:
        return Color(0xFFFFF2F2);
      case NotificationType.taken:
        return Color(0xFFF2FFF4);
      default:
        return Colors.white;
    }
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 2,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: height * 0.072,
                  width: width * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.waitingMedicineColor.withOpacity(0.3),
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.waitingIcon,
                      width: 35,
                      fit: BoxFit.fill,
                      color: AppColors.waitingMedicineColor,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: AppTextsStyle.spaceGroteskMedium22(
                          context,
                        ).copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        style: AppTextsStyle.spaceGroteskRegular13(
                          context,
                        ).copyWith(fontSize: 13),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            Image.asset(AppImages.clockIcon, width: 15),
                            SizedBox(width: 4),
                            Text(
                              "Now",
                              style: AppTextsStyle.poppinsRegular25(
                                context,
                              ).copyWith(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Divider(
              color: AppColors.timeLineColor.withOpacity(0.5),
              thickness: 0.7,
              indent: 5,
              endIndent: 5,
            ),
            SizedBox(
              height: height * 0.04,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (item.type != NotificationType.taken) ...[
                    Expanded(
                      child: GestureDetector(
                        onTap: onTake,
                        child: Center(
                          child: Text(
                            "Take now",
                            style: AppTextsStyle.spaceGroteskMedium22(context)
                                .copyWith(
                                  fontSize: 15,
                                  color: AppColors.splashScreenColor,
                                ),
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: AppColors.timeLineColor.withOpacity(0.5),
                      thickness: 0.7,
                      indent: 7,
                      endIndent: 7,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: onSkip,
                        child: Center(
                          child: Text(
                            "Skip",
                            style: AppTextsStyle.spaceGroteskMedium22(
                              context,
                            ).copyWith(fontSize: 14,color: AppColors.black.withOpacity(0.6)),
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    TextButton.icon(
                      onPressed: onDismiss,
                      icon: Image.asset(AppImages.deleteIcon,width: 11,),
                      label: Text(
                        'Dismiss',
                        style: AppTextsStyle.spaceGroteskMedium22(
                          context,
                        ).copyWith(fontSize: 14,color: AppColors.black.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
