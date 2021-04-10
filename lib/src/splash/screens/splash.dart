import 'package:cron_pay/src/auth/blocs/auth/auth_bloc.dart';
import 'package:cron_pay/src/auth/models/token.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/asset_constants.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/constants/storage_constants.dart';
import 'package:cron_pay/src/profile/blocs/profile/profile_bloc.dart';
import 'package:cron_pay/src/splash/blocs/splash/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:kiwi/kiwi.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashBloc _splashBloc;
  AuthBloc _authBloc;
  ProfileBloc _profileBloc;

  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _splashBloc = BlocProvider.of<SplashBloc>(context);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    Future.delayed(Duration(seconds: 1), () {
      _splashBloc.add(LoadSplashEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (dynamic context, state) {
              if (state is LogoutSuccessful) {
               return Navigator.pushReplacementNamed(context, Routes.signIn);
              }
              return Navigator.pushReplacementNamed(context, Routes.signIn);
            },
          ),
          BlocListener<ProfileBloc, ProfileState>(
            listener: (dynamic context, state) {
              if (state is UserProfileReceived) {
                return Navigator.pushReplacementNamed(context,Routes.navigationHost);
              }
              return Navigator.pushReplacementNamed(context, Routes.signIn);
            },
          ),
          BlocListener<SplashBloc, SplashState>(
              listener: (context, state) async {
            if (state is InitialAppLoad) {
              return Navigator.pushReplacementNamed(context, Routes.onBoarding);
            } else if (state is OnboardingSeenState) {
              final tokenBox = await Hive.openBox(StorageConstants.TOKEN_BOX);
              Token authToken = tokenBox.get("token") as Token;
              if (authToken != null) {
                Dio _dio = KiwiContainer().resolve<Dio>();
                final Map<String, dynamic> existingHeaders = _dio.options.headers;
                existingHeaders['Authorization'] = authToken.tokenType + " " + authToken.accessToken;
                _profileBloc.add(GetUserProfile());
              } else {
                _authBloc.add(LogoutRequestEvent());
              }
            }
          })
        ],
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                AppColors.primary,
                AppColors.primaryDark,
                AppColors.accentDark
              ])),
          child: Center(
            child: SizedBox(width: 150.w, child: Image.asset(Assets.logo)),
          ),
        ),
      ),
      // )
    );
  }
}
