import 'dart:async';

import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/commons/models/bank.dart';
import 'package:cron_pay/src/profile/services/bank_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'bank_event.dart';
part 'bank_state.dart';

class BankBloc extends HydratedBloc<BankEvent, BankState> {
  final BankService userService;

  BankBloc(this.userService) : super(UserInitialState());

  @override
  Stream<BankState> mapEventToState(
    BankEvent event,
  ) async* {
    if (event is GetBanksEvent) {
      var response = await userService.getBanks();
      if (response != null) {
        if (response is SuccessResponse) {
          List jsonData = response.responseBody.data;
          var f = jsonData
              .map((json) => Bank.fromJson(json as Map<String, dynamic>))
              .toList();
          yield BankListReceived(f);
        } else if (response is ErrorResponse) {
          yield RequestErrorResponse(response);
        }
      }
    }
  }

  @override
  BankState fromJson(Map<String, dynamic> json) {
    try {
      final banks = (json as List).map((e) => Bank.fromJson(e)).toList();
      return BankListReceived(banks);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(BankState state) {
    if (state is BankListReceived) {
      return {
        'banks': state.banks,
      };
    }
    return null;
  }
}
