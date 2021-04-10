import 'dart:async';

import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/transactions/services/transaction_service.dart';
import 'package:cron_pay/src/transactions/models/transaction.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends HydratedBloc<TransactionEvent, TransactionState> {
  final TransactionService transactionService;

  TransactionBloc(this.transactionService) : super(InitialTransactionState());

  TransactionState get initialState => InitialTransactionState();

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is GetTransactions) {
      if (state is InitialTransactionState) {
        yield LoadingState();
      }
      var response = await transactionService.getUserTransactions();
      if (response != null) {
        if (response is SuccessResponse) {
          // var data = response.responseBody.data;
          List data = response.responseBody.data;
          yield TransactionsReceived(data.map((e) => Transaction.fromJson(e)).toList());
        } else if (response is ErrorResponse) {
          yield ErrorWithMessageState(response.message);
        }
      }
    }
  }

  @override
  TransactionState fromJson(Map<String, dynamic> json) {
    try {
      final transactions = (json as List).map((e) => Transaction.fromJson(e)).toList();
      return TransactionsReceived(transactions);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(TransactionState state) {
    if (state is TransactionsReceived) {
      return {
        'transaction': state.transactions,
      };
    }
    return null;
  }
}
