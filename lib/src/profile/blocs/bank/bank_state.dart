part of 'bank_bloc.dart';

abstract class BankState extends Equatable {
  const BankState();
}

class UserInitialState extends BankState {
  @override
  List<Object> get props => [];
}

@immutable
class RequestErrorResponse extends BankState {
  final ErrorResponse errorResponse;
  RequestErrorResponse(this.errorResponse);

  @override
  List<Object> get props => [errorResponse];
}

@immutable
class BankListReceived extends BankState {
  final List<Bank> banks;
  BankListReceived(this.banks);

  @override
  List<Object> get props => [banks];
}