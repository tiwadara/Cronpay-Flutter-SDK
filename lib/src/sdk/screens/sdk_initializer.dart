import 'package:cron_pay/src/auth/models/token.dart';
import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/asset_constants.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/constants/storage_constants.dart';
import 'package:cron_pay/src/profile/blocs/profile/profile_bloc.dart';
import 'package:cron_pay/src/sdk/blocs/splash/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:kiwi/kiwi.dart';

class SDKInitializer extends StatefulWidget {
  @override
  _SDKInitializerState createState() => _SDKInitializerState();
}

class _SDKInitializerState extends State<SDKInitializer> {
  SDKBloc _sdkBloc;
  ProfileBloc _profileBloc;

  void initState() {
    _sdkBloc = BlocProvider.of<SDKBloc>(context);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    Future.delayed(Duration(seconds: 1), () {
      _sdkBloc.add(InitializeSDK(
          User(email: "teewah24@gmail.com", password: "tested12")));
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
          BlocListener<ProfileBloc, ProfileState>(
            listener: (dynamic context, state) {
              if (state is UserProfileReceived) {
                return Navigator.pushReplacementNamed(
                    context, Routes.createMandate);
              }
              return Navigator.pushReplacementNamed(context, Routes.signIn);
            },
          ),
          BlocListener<SDKBloc, SDKState>(listener: (context, state) async {
            if (state is SDKInitialized) {
              final tokenBox = await Hive.openBox(StorageConstants.TOKEN_BOX);
              Token authToken = tokenBox.get("token") as Token;
              if (authToken != null) {
                Dio _dio = KiwiContainer().resolve<Dio>();
                final Map<String, dynamic> existingHeaders =
                    _dio.options.headers;
                existingHeaders['Authorization'] =
                    authToken.tokenType + " " + authToken.accessToken;
                _profileBloc.add(GetUserProfile());
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
