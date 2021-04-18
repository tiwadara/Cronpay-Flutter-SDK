import 'package:cron_pay/src/auth/services/auth_service.dart';
import 'package:cron_pay/src/beneficiaries/services/beneficiary_service.dart';
import 'package:cron_pay/src/commons/services/api.dart';
import 'package:cron_pay/src/events/services/event_service.dart';
import 'package:cron_pay/src/payment/services/payment_service.dart';
import 'package:cron_pay/src/profile/services/bank_service.dart';
import 'package:cron_pay/src/profile/services/profile_service.dart';
import 'package:cron_pay/src/sdk/services/sdk_service.dart';
import 'package:cron_pay/src/transactions/services/transaction_service.dart';
import 'package:dio/dio.dart';
import 'package:kiwi/kiwi.dart';

import 'src/commons/services/navigation_service.dart';
import 'src/home/services/home_service.dart';

part 'di_container.g.dart';

abstract class Injector {
  @Register.singleton(AuthService)
  @Register.singleton(NavigationService)
  @Register.singleton(HomeService)
  @Register.singleton(APIService)
  @Register.singleton(EventService)
  @Register.singleton(BeneficiaryService)
  @Register.singleton(BankService)
  @Register.singleton(PaymentService)
  @Register.singleton(ProfileService)
  @Register.singleton(TransactionService)
  @Register.singleton(SdkService)

  void configure();
}

void setupDI() {
  var injector = _$Injector();
  injector.configure();
}
