import 'dart:async';

import 'package:cron_pay/src/beneficiaries/models/beneficiary.dart';
import 'package:cron_pay/src/beneficiaries/services/beneficiary_service.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'beneficiary_event.dart';
part 'beneficiary_state.dart';

class BeneficiaryBloc extends HydratedBloc<BeneficiaryEvent, BeneficiaryState> {
  final BeneficiaryService beneficiaryService;

  BeneficiaryBloc(this.beneficiaryService) : super(InitialBeneficiaryState());

  BeneficiaryState get initialState => InitialBeneficiaryState();

  @override
  Stream<BeneficiaryState> mapEventToState(BeneficiaryEvent event) async* {
    if (event is GetBeneficiaries) {
      if (state is InitialBeneficiaryState ) {
        yield GettingBeneficiaries();
      }
      var response = await beneficiaryService.getBeneficiaries();
      if (response is SuccessResponse) {
        List data = response.responseBody.data;
        yield BeneficiariesReturned(
            data.map((e) => Beneficiary.fromJson(e)).toList());
      } else if (response is ErrorResponse) {
        yield ErrorMessageState(response.message);
      }
    } else if (event is FilterEvent) {
      yield FilteringState();
      yield FilteredState(event.filterResult);
    } else if (event is PickBeneficiary) {
      yield BeneficiaryPicked(event.beneficiary);
    }else if (event is CreateNewBeneficiary) {
      yield CreateNewPicked();
    }else if (event is SwitchToPickBeneficiary) {
      yield SwitchToExistingPicked();
    }


  }

  @override
  BeneficiaryState fromJson(Map<String, dynamic> json) {
    try {
      final beneficiaries = (json as List).map((e) => Beneficiary.fromJson(e)).toList();
      return BeneficiariesReturned(beneficiaries);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(BeneficiaryState state) {
    if (state is BeneficiariesReturned) {
      return {
        'beneficiaries': state.beneficiaries,
      };
    }
    return null;
  }

}
