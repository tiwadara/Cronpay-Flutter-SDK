import 'dart:io';

import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/services/navigation_service.dart';
import 'package:cron_pay/src/payment/screens/add_payment_method.dart';
import 'package:cron_pay/src/payment/screens/create_mandate.dart';
import 'package:cron_pay/src/provider_setup.dart';
import 'package:cron_pay/src/route_manager.dart';
import 'package:cron_pay/src/sdk/screens/sdk_initializer.dart';
import 'package:cron_pay/src/splash/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:kiwi/kiwi.dart';
import 'package:overlay_support/overlay_support.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // AppUpdateInfo _updateInfo;

  @override
  void initState() {
    // if (Platform.isAndroid) {
    //   InAppUpdate.checkForUpdate().then((info) {
    //     setState(() {
    //       _updateInfo = info;
    //     });
    //     if (_updateInfo?.updateAvailable ?? false) {
    //       InAppUpdate.performImmediateUpdate().then((_) {});
    //     }
    //   });
    // } else if (Platform.isIOS) {
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: repositoryProviders,
      child: MultiBlocProvider(
        providers: blocProviders,
        child: OverlaySupport(
          child: MaterialApp(
            title: 'Cronpay',
            theme: ThemeData(
                fontFamily: 'Avenir',
                primaryColor: AppColors.accentDark,
                accentColor: AppColors.primary,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                scaffoldBackgroundColor: AppColors.windowColor),
            // darkTheme: ThemeData.dark(),
            home: SDKInitializer(),
            navigatorKey:
                KiwiContainer().resolve<NavigationService>().navigationKey,
            onGenerateRoute: RouteManager.generateRoute,
          ),
        ),
      ),
    );
  }
}
