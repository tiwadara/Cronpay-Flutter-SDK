import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cron_pay/src/auth/services/auth_service.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';

import 'bloc.dart';

class SDKBloc extends Bloc<SDKEvent, SDKState> {
  final AuthService authService;
  SDKBloc(this.authService) : super(InitialSDKState());

  @override
  Stream<SDKState> mapEventToState(
    SDKEvent event,
  ) async* {
    if (event is InitializeSDK) {
      yield Initializing();
      var response = await authService.logIn(event.user);
      if (response != null) {
        if (response is SuccessResponse) {
          yield SDKInitialized();
        } else if (response is ErrorResponse) {
          yield RequestError(response);
        }
      }
    }
  }
}
