import 'dart:async';

import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/home/models/expense.dart';
import 'package:cron_pay/src/payment/models/payment_method.dart';
import 'package:cron_pay/src/payment/services/payment_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends HydratedBloc<PaymentEvent, PaymentState> {
  final PaymentService paymentService;

  PaymentBloc(this.paymentService) : super(InitialPaymentState());

  PaymentState get initialState => InitialPaymentState();

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    if (event is GetPaymentMethods) {
      var response = await paymentService.getPaymentMethods();
      if (response is SuccessResponse) {
        List data = response.responseBody.data;
        yield PaymentMethodReceived(
            data.map((e) => PaymentMethod.fromJson(e)).toList());
      } else if (response is ErrorResponse) {
        yield CardFailed(response.message);
      }
    } else if (event is UpdatePaystackCheckoutEvent) {
      yield SendingReference();
      var response = await paymentService.updateCheckout(
          event.paymentMethod, event.reference);
      if (response is SuccessResponse) {
        String message = response.responseBody.message;
        yield CardAddedSuccessfully(message);
        this.add(GetSavedPaymentMethods());
      } else if (response is ErrorResponse) {
        yield CardFailed(response.message);
      }
    } else if (event is GetSavedPaymentMethods) {
      var response = await paymentService.getSavedCards();
      if (response is SuccessResponse) {
        List data = response.responseBody.data;
        yield SavedCardsReceived(
            data.map((e) => PaymentMethod.fromJson(e)).toList());
      } else if (response is ErrorResponse) {
        yield CardFailed(response.message);
      }
    }
  }

  @override
  PaymentState fromJson(Map<String, dynamic> json) {
    try {
      final cards =
          (json as List).map((e) => PaymentMethod.fromJson(e)).toList();
      return SavedCardsReceived(cards);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(PaymentState state) {
    if (state is SavedCardsReceived) {
      return {
        'paymentMethods': state.paymentMethods,
      };
    }
    return null;
  }
}
