import 'package:cron_pay/src/auth/screens/Reset_password.dart';
import 'package:cron_pay/src/auth/screens/all_done.dart';
import 'package:cron_pay/src/auth/screens/change_password.dart';
import 'package:cron_pay/src/auth/screens/create_pin.dart';
import 'package:cron_pay/src/auth/screens/new_password.dart';
import 'package:cron_pay/src/auth/screens/signin.dart';
import 'package:cron_pay/src/auth/screens/signup.dart';
import 'package:cron_pay/src/auth/screens/verification.dart';
import 'package:cron_pay/src/beneficiaries/screens/benefiiciaries.dart';
import 'package:cron_pay/src/buttomnav/buttom_nav_bar.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/events/screens/all_events.dart';
import 'package:cron_pay/src/events/screens/event_created.dart';
import 'package:cron_pay/src/events/screens/new_event.dart';
import 'package:cron_pay/src/home/screens/home.dart';
import 'package:cron_pay/src/payment/screens/add_payment_method.dart';
import 'package:cron_pay/src/payment/screens/create_mandate.dart';
import 'package:cron_pay/src/payment/screens/payment_methods.dart';
import 'package:cron_pay/src/payment/widgets/signature_pad.dart';
import 'package:cron_pay/src/profile/screens/edit_profile.dart';
import 'package:cron_pay/src/transactions/screens/transactions.dart';
import 'package:cron_pay/src/splash/screens/onboarding.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => Home());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => Onboarding());
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => SignUp());
      case Routes.signIn:
        return MaterialPageRoute(builder: (_) => SignIn());
      case Routes.verification:
        return MaterialPageRoute(builder: (_) => Verification());
      case Routes.createPin:
        return MaterialPageRoute(builder: (_) => CreatePIN());
      case Routes.confirmPin:
        return MaterialPageRoute(builder: (_) => Verification());
      case Routes.allDone:
        return MaterialPageRoute(builder: (_) => AllDone());
      case Routes.eventCreated:
        return MaterialPageRoute(builder: (_) => EventCreated(arguments));
      case Routes.navigationHost:
        return MaterialPageRoute(builder: (_) => BottomNavBar());
      case Routes.newEvent:
        return MaterialPageRoute(builder: (_) => NewEvent());
      case Routes.beneficiaries:
        return MaterialPageRoute(builder: (_) => Beneficiaries());
      case Routes.allEvent:
        return MaterialPageRoute(builder: (_) => AllEvents());
      case Routes.addPayment:
        return MaterialPageRoute(builder: (_) => AddPaymentMethod());
      case Routes.paymentMethods:
        return MaterialPageRoute(builder: (_) => PaymentMethods());
      case Routes.editProfile:
        return MaterialPageRoute(builder: (_) => EditProfile());
      case Routes.transactions:
        return MaterialPageRoute(builder: (_) => Transactions());
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case Routes.newPassword:
        return MaterialPageRoute(builder: (_) => NewPassword(arguments));
      case Routes.changePassword:
        return MaterialPageRoute(builder: (_) => ChangePassword());
      case Routes.signaturePad:
        return MaterialPageRoute(builder: (_) => SignaturePad());
      case Routes.createMandate:
        return MaterialPageRoute(builder: (_) => CreateMandate(arguments));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
