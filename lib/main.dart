// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart';
// Project imports:
import 'core/business_logic/medicine_cubit/medicine_cubit.dart';
import 'core/business_logic/nav_cubit/nav_cubit.dart';
import 'core/business_logic/user_cubit/user_cubit.dart';
import 'core/constants/app_texts.dart';
import 'core/repo/user_repo.dart';
import 'core/services/user_medicine_service.dart';
import 'core/services/user_service.dart';
import 'features/add_medicine/business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import 'features/calendar/business_logic_layer/days_cubit/days_cubit.dart';
import 'features/home/business_logic/search_cubit/search_cubit.dart';
import 'features/notification/data/services/notification_service.dart';
import 'features/splash/presintation/screens/splash_screen.dart';

bool shouldOpenNotifications = false;
bool shouldOpenNotificationsTab = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  runApp( DevicePreview(
    enabled: true,
    builder: (context) {
      return Meditime();
    }
  ));
}

class Meditime extends StatelessWidget {
  const Meditime({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavCubit()),
        BlocProvider(create: (_) => AddMedicineCubit()),
        BlocProvider(create: (_) => DaysCubit()),
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(create: (_) => MedicineCubit(UserMedicineService())),
        BlocProvider(create: (_) => UserCubit(UserRepo(UserService()))),
      ],
      child: MaterialApp(
        navigatorKey: NotificationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: AppTexts.appName,
        home: const SplashScreen(),
      ),
    );
  }
}
