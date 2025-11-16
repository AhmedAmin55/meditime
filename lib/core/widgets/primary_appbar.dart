import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/app_images.dart';
import '../constants/app_textstyle.dart';
import '../../features/auth/presintation/screens/authentication_screen.dart';

class PrimaryAppbar extends StatelessWidget {
  PrimaryAppbar({
    super.key,
    required this.title,
    this.titleStyle,
    required this.subtitle,
    this.subtitleStyle,
    required this.imagePath,
  });

  final String title;
  final TextStyle? titleStyle;
  final String subtitle;
  final TextStyle? subtitleStyle;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text(title, style: titleStyle),
      subtitle: Text(subtitle, style: subtitleStyle),
      trailing: GestureDetector(
        child: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imagePath),
        ),
      ),
    );
  }
}
