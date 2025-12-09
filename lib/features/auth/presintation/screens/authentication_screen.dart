// Flutter imports:
import 'package:flutter/material.dart';
 
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../core/business_logic/user_cubit/user_cubit.dart';
import '../../../../core/repo/user_repo.dart';
import '../../../../core/services/user_service.dart';
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
        BlocProvider(
          create: (context) => LoginCubit(userRepo: UserRepo(UserService())),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(userRepo: UserRepo(UserService())),
        ),
        BlocProvider(create: (context) => AuthSwitchCubit()),
      ],

      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            print(
              "Register successful from AuthenticationScreen. Fetching user data...",
            );
            context.read<UserCubit>().fetchUser(uid: state.uid);

            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          } else if (state is RegisterFailure) {
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
                    expandedHeight: state is AuthSwitchInitial
                        ? height * 0.30
                        : height * 0.20,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: AuthenticationScreenHeader(),
                    ),
                  ),
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
