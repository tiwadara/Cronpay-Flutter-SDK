import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/services/navigation_service.dart';
import 'package:cron_pay/src/provider_setup.dart';
import 'package:cron_pay/src/route_manager.dart';
import 'package:cron_pay/src/sdk/screens/sdk_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:overlay_support/overlay_support.dart';

class App extends StatelessWidget {
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
