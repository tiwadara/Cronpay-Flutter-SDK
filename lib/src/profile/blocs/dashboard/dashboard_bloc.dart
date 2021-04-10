import 'dart:async';

import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/profile/services/profile_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends HydratedBloc<DashboardEvent, DashboardState> {
  final ProfileService profileService;

  DashboardBloc(this.profileService) : super(InitialProfileState());

  DashboardState get initialState => InitialProfileState();

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is GetEventCount) {
      var response = await profileService.getDashboardCount();
      if (response != null) {
        if (response is SuccessResponse) {
          var data = response.responseBody.data;
          yield DashboardCountReceived(data);
        } else if (response is ErrorResponse) {
          yield ErrorWithMessageState(response.message);
        }
      }
    }
  }

  @override
  DashboardState fromJson(Map<String, dynamic> json) {
    try {
      return DashboardCountReceived(json.values.first);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(DashboardState state) {
    if (state is DashboardCountReceived) {
      return {
        'count': state.count,
      };
    }
    return null;
  }
}
