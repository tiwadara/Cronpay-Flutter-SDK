part of 'direct_debit_bloc.dart';

@immutable
abstract class DirectDepositState extends Equatable {
  const DirectDepositState();
}

class InitialPaymentState extends DirectDepositState {
  @override
  List<Object> get props => [];
}
@immutable
class DirectDebitFailed extends DirectDepositState {
  final String error;
  DirectDebitFailed(this.error);
  @override
  List<Object> get props => [error];
}

class SendingReference extends DirectDepositState {
  @override
  List<Object> get props => [];
}

class VerifyingBankDetails extends DirectDepositState {
  @override
  List<Object> get props => [];
}

class SigningState extends DirectDepositState {
  final double maxAmount;
  final String accountNumber;
  final Bank bank;
  final String name;

  SigningState(this.maxAmount, this.bank, this.accountNumber, this.name);

  @override
  List<Object> get props => [maxAmount, accountNumber, name, bank];
}

class BankDetailsVerified extends DirectDepositState {
  final BankDetail bankDetail;

  BankDetailsVerified(this.bankDetail);
  @override
  List<Object> get props => [bankDetail];
}
class Restarted extends DirectDepositState {
  @override
  List<Object> get props => [];
}

@immutable
class AccountDetailsIncorrect extends DirectDepositState {
  final String error;
  AccountDetailsIncorrect(this.error);
  @override
  List<Object> get props => [error];
}

@immutable
class PaymentMethodReceived extends DirectDepositState {
  final List<PaymentMethod> paymentMethods;
  PaymentMethodReceived(this.paymentMethods);

  @override
  List<Object> get props => [paymentMethods];
}

@immutable
class MandateInitiated extends DirectDepositState {
  final String  message;
  MandateInitiated(this.message);

  @override
  List<Object> get props => [message];
}

@immutable
class SavedCardsReceived extends DirectDepositState {
  final List<PaymentMethod>  paymentMethods;
  SavedCardsReceived(this.paymentMethods);

  @override
  List<Object> get props => [paymentMethods];
}

