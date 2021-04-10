part of 'direct_debit_bloc.dart';

@immutable
abstract class DirectDepositEvent extends Equatable {
  const DirectDepositEvent();
}

@immutable
class AddDirectDebit extends DirectDepositEvent {
  final String bank;
  final String account;
  final double maxAmount;
  final String signature;
  final PaymentMethod paymentMethod;

  AddDirectDebit(this.bank, this.account,this.maxAmount, this.signature, this.paymentMethod);
  @override
  List<Object> get props => [bank,account,maxAmount, signature, paymentMethod];
}

@immutable
class GetPaymentMethod extends DirectDepositEvent {
  @override
  List<Object> get props => [];
}

@immutable
class RequestBankDetails extends DirectDepositEvent {
  final String bank;
  final String account;
  
  RequestBankDetails(this.bank, this.account);
  
  @override
  List<Object> get props => [bank, account];
}

@immutable
class AuthoriseMandate extends DirectDepositEvent {
  @override
  List<Object> get props => [];
}

@immutable
class RestartDirectDebit extends DirectDepositEvent {
  @override
  List<Object> get props => [];
}

@immutable
class ProceedToSigning extends DirectDepositEvent {

  final double maxAmount;
  final String accountNumber;
  final Bank bank;
  final String name;

  ProceedToSigning(this.maxAmount, this.bank, this.name, this.accountNumber);

  @override
  List<Object> get props => [maxAmount, name, accountNumber, bank];
}


@immutable
class GetSavedCards extends DirectDepositEvent {
  @override
  List<Object> get props => [];
}
