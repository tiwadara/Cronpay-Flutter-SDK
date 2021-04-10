part of '../../../transactions/blocs/transaction/transaction_bloc.dart';

@immutable
abstract class TransactionState extends Equatable {
  const TransactionState();
}

class InitialTransactionState extends TransactionState {
  @override
  List<Object> get props => [];
}

@immutable
class ErrorWithMessageState extends TransactionState {
  final String error;
  ErrorWithMessageState(this.error);
  @override
  List<Object> get props => [error];
}

class LoadingState extends TransactionState {
  @override
  List<Object> get props => [];
}

@immutable
class TransactionsReceived extends TransactionState {
  final List<Transaction> transactions;
  TransactionsReceived(this.transactions);
  @override
  List<Object> get props => [transactions];
}
