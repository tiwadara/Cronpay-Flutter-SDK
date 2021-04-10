part of 'bank_bloc.dart';

abstract class BankEvent extends Equatable {
  const BankEvent();
}

@immutable
class GetBanksEvent extends BankEvent {

  @override
  List<Object> get props => [];
}