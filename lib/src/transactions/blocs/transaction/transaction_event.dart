part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent extends Equatable {
  const TransactionEvent();
}

@immutable
class GetTransactions extends TransactionEvent {
  @override
  List<Object> get props => [];
}


