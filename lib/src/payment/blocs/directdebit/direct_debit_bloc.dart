import 'dart:async';

import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/commons/models/bank.dart';
import 'package:cron_pay/src/payment/models/bank_detail.dart';
import 'package:cron_pay/src/payment/models/payment_method.dart';
import 'package:cron_pay/src/payment/services/payment_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'direct_debit_event.dart';
part 'direct_debit_state.dart';

class DirectDebitBloc
    extends HydratedBloc<DirectDepositEvent, DirectDepositState> {
  final PaymentService paymentService;

  DirectDebitBloc(this.paymentService) : super(InitialPaymentState());

  DirectDepositState get initialState => InitialPaymentState();

  @override
  Stream<DirectDepositState> mapEventToState(DirectDepositEvent event) async* {
    if (event is GetPaymentMethod) {
      var response = await paymentService.getPaymentMethods();
      if (response is SuccessResponse) {
        List data = response.responseBody.data;
        yield PaymentMethodReceived(
            data.map((e) => PaymentMethod.fromJson(e)).toList());
      } else if (response is ErrorResponse) {
        yield DirectDebitFailed(response.message);
      }
    } else if (event is AddDirectDebit) {
      yield SendingReference();
      var response = await paymentService.startDirectDebit(event.paymentMethod,
          event.account, event.bank, event.maxAmount, event.signature);
      if (response is SuccessResponse) {
        String message = response.responseBody.message;
        yield MandateInitiated(message);
      } else if (response is ErrorResponse) {
        yield DirectDebitFailed(response.message);
      }
    } else if (event is RequestBankDetails) {
      yield VerifyingBankDetails();
      var response = await paymentService.verifyBankAccount(
          accountNumber: event.account, bankId: event.bank);
      if (response is SuccessResponse) {
        var data = response.responseBody.data;
        yield BankDetailsVerified(BankDetail.fromJson(data));
      } else if (response is ErrorResponse) {
        yield AccountDetailsIncorrect(response.message);
      }
    } else if (event is GetSavedCards) {
      var response = await paymentService.getSavedCards();
      if (response is SuccessResponse) {
        List data = response.responseBody.data;
        yield SavedCardsReceived(
            data.map((e) => PaymentMethod.fromJson(e)).toList());
      } else if (response is ErrorResponse) {
        yield DirectDebitFailed(response.message);
      }
    } else if (event is ProceedToSigning) {
      yield SigningState(
          event.maxAmount, event.bank, event.accountNumber, event.name);
    } else if (event is RestartDirectDebit) {
      yield Restarted();
    }
  }

  @override
  DirectDepositState fromJson(Map<String, dynamic> json) {
    try {
      final cards =
          (json as List).map((e) => PaymentMethod.fromJson(e)).toList();
      return SavedCardsReceived(cards);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(DirectDepositState state) {
    if (state is SavedCardsReceived) {
      return {
        'paymentMethods': state.paymentMethods,
      };
    }
    return null;
  }
}
