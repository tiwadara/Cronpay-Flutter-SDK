import 'package:cron_pay/src/auth/models/token.dart';
import 'package:cron_pay/src/commons/constants/network_constants.dart';
import 'package:cron_pay/src/commons/constants/storage_constants.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/commons/services/api.dart';
import 'package:cron_pay/src/sdk/model/sdk_params.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class SdkService {
  APIService apiService;
  SdkService(this.apiService);

  Future<dynamic> initSdk(String accessToken) async {
    final ApiRequestBuilder requestBuilder =
        ApiRequestBuilder(NetworkConstants.INIT_SDK, "GET");
    apiService
        .setHeaders(new Token(accessToken: accessToken, tokenType: "Bearer"));
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      var jsonData = apiResponse.successResponse.responseBody;
      SdkParams sdkParams = SdkParams.fromJson(jsonData.data);
      final tokenBox = await Hive.openBox(StorageConstants.TOKEN_BOX);
      await tokenBox.put("token",
          new Token(accessToken: sdkParams.accessToken, tokenType: "Bearer"));
      apiService.setHeaders(tokenBox.get("token"));
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }

  Future<String> sendChannelMessage(MethodChannel methodChannel, String method, {String message = "No message"}) async {
    String _responseFromNativeCode;
    methodChannel.invokeMethod(method, message).then((value) {
      _responseFromNativeCode = value;
    }).catchError((error, stackTrace) {
      _responseFromNativeCode = null;
    });
    return _responseFromNativeCode;
  }
}
