import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => RegisterCubit()),
          BlocProvider(create: (context) => AuthSwitchCubit()),
        ],
  child: Scaffold(
      body: BlocBuilder<AuthSwitchCubit, AuthSwitchState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: state is AuthSwitchInitial ? height*0.30 : height*0.20,
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
);
  }
}
