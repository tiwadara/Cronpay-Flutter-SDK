import 'dart:developer';

import 'package:cron_pay/src/commons/constants/network_constants.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/commons/services/api.dart';
import 'package:cron_pay/src/payment/models/payment_method.dart';

class PaymentService {
  APIService apiService;
  PaymentService(this.apiService);

  Future<dynamic> getPaymentMethods() async {
    final ApiRequestBuilder requestBuilder =
        ApiRequestBuilder(NetworkConstants.PAYMENT_METHODS, "GET");
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      var jsonData = apiResponse.successResponse.responseBody;
      print(jsonData.toJson().toString());
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }

  Future<dynamic> verifyBankAccount({String accountNumber, String bankId}) async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(NetworkConstants.VERIFY_ACCOUNT, "POST",
    body: {
    "accountNumber": accountNumber,
    "bankId": bankId
    });
    final ApiResponse apiResponse = await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      var jsonData = apiResponse.successResponse.responseBody;
      print(jsonData.toJson().toString());
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }


  Future<dynamic> startDirectDebit(PaymentMethod paymentMethod,
      String accountNumber, String bankId, double maxAmount, String signature) async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
        NetworkConstants.PAYMENT_METHODS + "/${paymentMethod.id}", "POST",
        body: {
          "accountNumber": accountNumber,
          "bankId": bankId,
          "amount": maxAmount,
          "signature" : signature
        });
    final ApiResponse apiResponse = await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }

  Future<dynamic> updateCheckout(
      PaymentMethod paymentMethod, String reference) async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
        NetworkConstants.PAYMENT_METHODS + "/${paymentMethod.id}", "POST",
        body: {"reference": reference});
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }

  Future<dynamic> getSavedCards() async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(NetworkConstants.SAVED_CARDS, "GET");
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      log(apiResponse.successResponse.responseBody.toJson().toString());
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }
}
