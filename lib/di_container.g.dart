// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'di_container.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => AuthService(c<APIService>()));
    container.registerSingleton((c) => NavigationService());
    container.registerSingleton((c) => HomeService());
    container.registerSingleton((c) => APIService(c<Dio>()));
    container.registerSingleton((c) => EventService(c<APIService>()));
    container.registerSingleton((c) => BeneficiaryService(c<APIService>()));
    container.registerSingleton((c) => BankService(c<APIService>()));
    container.registerSingleton((c) => PaymentService(c<APIService>()));
    container.registerSingleton((c) => ProfileService(c<APIService>()));
    container.registerSingleton((c) => TransactionService(c<APIService>()));
  }
}
