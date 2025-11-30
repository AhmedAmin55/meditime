import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditime/core/business_logic/user_cubit/user_cubit.dart';
import 'package:meditime/core/repo/user_repo.dart';
import 'package:meditime/core/services/user_service.dart';

import 'core/business_logic/medicine_cubit/medicinde_cubit.dart';
import 'core/business_logic/nav_cubit/nav_cubit.dart';
import 'core/constants/app_texts.dart';

import 'core/services/get_medicine_service.dart';
import 'features/add_medicine/business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import 'features/calendar/business_logic_layer/days_cubit/days_cubit.dart';
import 'features/home/business_logic/search_cubit/search_cubit.dart';
import 'features/splash/presintation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    DevicePreview(
      enabled: false, // غيّرها true لو عايز تشغل Device Preview
      builder: (context) => const Meditime(),
    ),
  );
}

class Meditime extends StatelessWidget {
  const Meditime({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DaysCubit()),
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(create: (_) => NavCubit()),
        BlocProvider(create: (_) => AddMedicineCubit()),
        BlocProvider(create: (_) => MedicineCubit(GetMedicineService())),
        BlocProvider(create: (_) => UserCubit(UserRepo(UserService()))),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey, // ← السطر الوحيد اللي زاد
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: AppTexts.appName,
        home: const SplashScreen(),
      ),
    );
  }
}