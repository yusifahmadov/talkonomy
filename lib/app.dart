import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkonomy_app/features/home/presentation/pages/home_page_view.dart';
import 'package:talkonomy_app/features/user/presentation/bloc/user_cubit.dart';
import 'core/config/theme/app_theme.dart';

import 'features/user/presentation/pages/login/login_page_view.dart';
import 'injection.dart';

import 'features/user/presentation/bloc/auth/auth_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<AuthBloc>()..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => getIt<UserCubit>()..updateUserInformationController(),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
            builder: EasyLoading.init(),
            theme: ThemeManager.craeteTheme(AppThemeLight()),
            home: BlocBuilder<AuthBloc, AuthState>(
              bloc: context.read<AuthBloc>(),
              builder: (context, state) {
                if (state is AuthNotAuthenticated) {
                  return LoginPageView();
                } else if (state is AuthAuthenticated) {
                  return const HomePageView();
                } else {
                  return const SizedBox();
                }
              },
            ),
            navigatorKey: navigatorKey,
          );
        }),
      ),
      builder: (context, child) {
        return child!;
      },
    );
  }
}
