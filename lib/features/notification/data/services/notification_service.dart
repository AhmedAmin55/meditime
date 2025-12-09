// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../core/business_logic/nav_cubit/nav_cubit.dart';

bool shouldOpenNotificationsTab = false;

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Future<void> init() async {
   await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    String? token = await _messaging.getToken();
    debugPrint('FCM Token: $token');
    _handleNotificationClicks();
  }

  void _handleNotificationClicks() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _openNotificationsTab();
    });

    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        _openNotificationsTab();
      }
    });
  }

  static void _openNotificationsTab() {
    shouldOpenNotificationsTab = true;

    final navigatorContext = navigatorKey.currentContext;
    if (navigatorContext != null && navigatorContext.mounted) {
      navigatorContext.read<NavCubit>().changeScreen(index: 3);
      shouldOpenNotificationsTab = false;
    }
  }
}
