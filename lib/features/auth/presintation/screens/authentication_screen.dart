import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/business_logic/user_cubit/user_cubit.dart'; // ١. استيراد UserCubit
import '../../../../core/repo/user_repo.dart';
import '../../../../core/services/user_service.dart';
// ٢. استيراد الشاشة الرئيسية وصفحات أخرى إذا لزم الأمر
import '../../../home/presintation/screens/home_screen.dart';
import '../../business_logic/auth_switch_cubit/auth_switch_cubit.dart';
import '../../business_logic/login_cubit/login_cubit.dart';
import '../../business_logic/register_cubit/register_cubit.dart';
import '../widgets/authentication_screen_header.dart';
import '../widgets/login_screen_body.dart';
import '../widgets/signup_screen_body.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(userRepo: UserRepo(UserService()))),
        BlocProvider(create: (context) => RegisterCubit(userRepo: UserRepo(UserService()))),
        BlocProvider(create: (context) => AuthSwitchCubit()),
      ],
      // --- ٣. إضافة BlocListener هنا ---
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            // نجاح التسجيل!
            // أ. اطلب من UserCubit تحديث بياناته
            print("Register successful from AuthenticationScreen. Fetching user data...");
            context.read<UserCubit>().fetchUser(uid: state.uid);

            // ب. انتقل إلى الشاشة الرئيسية مع إزالة كل الشاشات السابقة
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()), // تأكد من أن هذا هو اسم شاشتك الرئيسية
                  (route) => false,
            );
          } else if (state is RegisterFailure) {
            // فشل التسجيل، اعرض رسالة خطأ
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          body: BlocBuilder<AuthSwitchCubit, AuthSwitchState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                      pinned: true,
                      expandedHeight: state is AuthSwitchInitial ? height * 0.30 : height * 0.20,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: AuthenticationScreenHeader(),
                      )),
                  SliverFillRemaining(
                    child: state is AuthSwitchInitial
                        ? Loginscreenbody()
                        : SignupScreenBody(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}