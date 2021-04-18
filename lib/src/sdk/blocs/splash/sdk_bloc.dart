import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cron_pay/src/commons/constants/method_channel_constants.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/sdk/model/mandate.dart';
import 'package:cron_pay/src/sdk/services/sdk_service.dart';

import 'bloc.dart';

class SDKBloc extends Bloc<SDKEvent, SDKState> {
  final SdkService sdkService;
  SDKBloc(this.sdkService) : super(InitialSDKState());

  @override
  Stream<SDKState> mapEventToState(
    SDKEvent event,
  ) async* {
    if (event is InitializeSDK) {
      yield Initializing();
      var response = await sdkService.initSdk(event.accessToken);
      if (response != null) {
        if (response is SuccessResponse) {
          yield SDKInitialized(Mandate.fromJson(response.responseBody.data));
        } else if (response is ErrorResponse) {
          yield RequestError(response);
        }
      }
    } else if (event is GetSdkMerchantToken) {
      yield Initializing();
      const token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJmaXJzdE5hbWUiOiJUaXdhIiwibGFzdE5hbWUiOiJCYWJhbG9sYSIsImlkIjoiMyIsImV4cCI6MTY1MDE2MzE1OSwiZW1haWwiOiJ0ZWV3YWgyNEBnbWFpbC5jb20iLCJqdGkiOiIzYTM1NTU5OC0zNmI2LTQxZWQtYWJhYS1mYjhkMThkNjVjOTciLCJjbGllbnRfaWQiOiJjbGllbnRJZCJ9.WnIVTzcmIfesLcmwx6TuYgHL07nPhLaGcVy9jDb012L7BQeeRCH2srSM0eHCyk7ZIV0IOlwx5C_ZR7LmySGdZgwkn0-QKHm9K3CkpXLKYsVtSFdt8PQlAl4TgPB43gsxt7XvvxgmtFJe9jQoml-JlV61I09aDTR9ymnZakaPE9Y";
      var response = await sdkService.sendChannelMessage(MethodChannelConstants.CHANNEL, MethodChannelConstants.METHOD_INITIALIZE);

      if  (response == null || response == "") {
        yield SDKMerchantTokenReceived(token);
      }else {
        yield SDKMerchantTokenReceived(response);
      }
    }  else if (event is SendSuccessCallBackToPlatform) {
      yield SendingCallBack();
      var response = await sdkService.sendChannelMessage(
          MethodChannelConstants.CHANNEL,
          MethodChannelConstants.METHOD_SEND_SUCCESS_CALLBACK);
      print(response);
    } else if (event is SendCloseCallBackToPlatform) {
      yield SendingCallBack();
      var response = await sdkService.sendChannelMessage(
          MethodChannelConstants.CHANNEL,
          MethodChannelConstants.METHOD_SEND_CLOSE_CALLBACK);
      print(response);
    }
  }
}
