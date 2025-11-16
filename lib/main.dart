import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/business_logic/nav_cubit/nav_cubit.dart';
import 'core/constants/app_texts.dart';
import 'features/add_medicine/business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import 'features/calendar/business_logic_layer/days_cubit/days_cubit.dart';
import 'features/home/business_logic/search_cubit/search_cubit.dart';
import 'features/splash/presintation/screens/splash_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DevicePreview(enabled: false, builder: (ctx) => const Meditime()));
}

class Meditime extends StatelessWidget {
  const Meditime({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DaysCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => NavCubit()),
        BlocProvider(create: (context) => AddMedicineCubit())
      ],
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: AppTexts.appName,
        home: SplashScreen(),
      ),
    );
  }
}
