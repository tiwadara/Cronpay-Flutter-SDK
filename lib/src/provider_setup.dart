import 'package:cron_pay/src/auth/blocs/auth/auth_bloc.dart';
import 'package:cron_pay/src/auth/services/auth_service.dart';
import 'package:cron_pay/src/beneficiaries/blocs/beneficiary/beneficiary_bloc.dart';
import 'package:cron_pay/src/beneficiaries/services/beneficiary_service.dart';
import 'package:cron_pay/src/buttomnav/bloc/bottom_nav_cubit.dart';
import 'package:cron_pay/src/commons/services/api.dart';
import 'package:cron_pay/src/events/blocs/event/event_bloc.dart';
import 'package:cron_pay/src/events/services/event_service.dart';
import 'package:cron_pay/src/home/blocs/home/home_bloc.dart';
import 'package:cron_pay/src/home/services/home_service.dart';
import 'package:cron_pay/src/payment/blocs/directdebit/direct_debit_bloc.dart';
import 'package:cron_pay/src/payment/blocs/payment/payment_bloc.dart';
import 'package:cron_pay/src/payment/services/payment_service.dart';
import 'package:cron_pay/src/profile/blocs/bank/bank_bloc.dart';
import 'package:cron_pay/src/profile/blocs/dashboard/dashboard_bloc.dart';
import 'package:cron_pay/src/profile/blocs/profile/profile_bloc.dart';
import 'package:cron_pay/src/sdk/blocs/splash/bloc.dart';
import 'package:cron_pay/src/transactions/blocs/transaction/transaction_bloc.dart';
import 'package:cron_pay/src/profile/services/bank_service.dart';
import 'package:cron_pay/src/profile/services/profile_service.dart';
import 'package:cron_pay/src/transactions/services/transaction_service.dart';
import 'package:cron_pay/src/splash/blocs/splash/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<HomeBloc>(
    lazy: false,
    create: (dynamic context) =>
        HomeBloc(RepositoryProvider.of<HomeService>(context)),
  ),
  BlocProvider<SplashBloc>(
    lazy: false,
    create: (dynamic context) => SplashBloc(),
  ),
  BlocProvider<AuthBloc>(
    lazy: false,
    create: (dynamic context) =>
        AuthBloc(RepositoryProvider.of<AuthService>(context)),
  ),
  BlocProvider<BottomNavCubit>(
    lazy: false,
    create: (dynamic context) => BottomNavCubit(),
  ),
  BlocProvider<EventBloc>(
    lazy: false,
    create: (dynamic context) =>
        EventBloc(RepositoryProvider.of<EventService>(context)),
  ),
  BlocProvider<BeneficiaryBloc>(
    lazy: false,
    create: (dynamic context) =>
        BeneficiaryBloc(RepositoryProvider.of<BeneficiaryService>(context)),
  ),
  BlocProvider<BankBloc>(
    lazy: false,
    create: (dynamic context) =>
        BankBloc(RepositoryProvider.of<BankService>(context)),
  ),
  BlocProvider<PaymentBloc>(
      lazy: false,
      create: (dynamic context) =>
          PaymentBloc(RepositoryProvider.of<PaymentService>(context))),
  BlocProvider<ProfileBloc>(
      lazy: false,
      create: (dynamic context) =>
          ProfileBloc(RepositoryProvider.of<ProfileService>(context))),
  BlocProvider<TransactionBloc>(
      lazy: false,
      create: (dynamic context) =>
          TransactionBloc(RepositoryProvider.of<TransactionService>(context))),
  BlocProvider<DirectDebitBloc>(
      lazy: false,
      create: (dynamic context) =>
          DirectDebitBloc(RepositoryProvider.of<PaymentService>(context))),
  BlocProvider<DashboardBloc>(
      lazy: false,
      create: (dynamic context) =>
          DashboardBloc(RepositoryProvider.of<ProfileService>(context))),
  BlocProvider<SDKBloc>(
      lazy: false,
      create: (dynamic context) =>
          SDKBloc(RepositoryProvider.of<AuthService>(context))),
];

final KiwiContainer kiwiContainer = KiwiContainer();

List<RepositoryProvider> repositoryProviders = [
  RepositoryProvider<HomeService>(
    create: (context) => kiwiContainer.resolve<HomeService>(),
  ),
  RepositoryProvider<APIService>(
    create: (context) => kiwiContainer.resolve<APIService>(),
  ),
  RepositoryProvider<AuthService>(
    create: (context) => kiwiContainer.resolve<AuthService>(),
  ),
  RepositoryProvider<EventService>(
    create: (context) => kiwiContainer.resolve<EventService>(),
  ),
  RepositoryProvider<BeneficiaryService>(
    create: (context) => kiwiContainer.resolve<BeneficiaryService>(),
  ),
  RepositoryProvider<BankService>(
    create: (context) => kiwiContainer.resolve<BankService>(),
  ),
  RepositoryProvider<ProfileService>(
    create: (context) => kiwiContainer.resolve<ProfileService>(),
  ),
  RepositoryProvider<PaymentService>(
    create: (context) => kiwiContainer.resolve<PaymentService>(),
  ),
  RepositoryProvider<TransactionService>(
    create: (context) => kiwiContainer.resolve<TransactionService>(),
  ),
];
