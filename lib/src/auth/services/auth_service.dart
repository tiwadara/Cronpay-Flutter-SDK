import 'dart:developer';

import 'package:cron_pay/src/auth/models/bvn.dart';
import 'package:cron_pay/src/auth/models/token.dart';
import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/network_constants.dart';
import 'package:cron_pay/src/commons/constants/storage_constants.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/commons/models/bank.dart';
import 'package:cron_pay/src/commons/services/api.dart';
import 'package:hive/hive.dart';

class AuthService {
  final APIService apiService;
  AuthService(this.apiService);

  Future<dynamic> verifyBvn(BVN bvn) async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
        "verification/bvn", "POST",
        body: {"bvn": bvn.bvn, "dob": bvn.dob});
    print("bvn req " + requestBuilder.path.toString());
    print("bvn body " + requestBuilder.body.toString());
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      var jsonData = apiResponse.successResponse.responseBody;
      return true;
    }
    return false;
  }

  Future<dynamic> verifyUser(String pin, User user) async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
      NetworkConstants.VERIFY + "?email=${user.email}",
      "GET",
    );
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      var jsonData = apiResponse.successResponse.responseBody;
      return true;
    }
    return false;
  }

  Future<dynamic> logIn(User user) async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
        NetworkConstants.LOGIN, "POST",
        body: {"username": user.email, "password": user.password});
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      var jsonData = apiResponse.successResponse.responseBody;
      final tokenBox = await Hive.openBox(StorageConstants.TOKEN_BOX);
      tokenBox.put("token", Token.fromJson(jsonData.data));
      apiService.setHeaders(tokenBox.get("token"));
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }

  Future<dynamic> resetPassword(User user) async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
        NetworkConstants.PASSWORD_RESET + "?email=${user.email}", "GET");
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      var jsonData = apiResponse.successResponse.responseBody;
      log(jsonData.toJson().toString());
      return apiResponse.successResponse;
    } else {
      log(apiResponse.errorResponse.message.toString());
      return apiResponse.errorResponse;
    }
  }

  Future<dynamic> newPassword(String newPassword, String otp) async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
        NetworkConstants.NEW_PASSWORD, "PATCH", body: {
      "currentPassword": "string",
      "newPassword": newPassword,
      "otp": otp
    });
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      var jsonData = apiResponse.successResponse.responseBody;
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }

  // Future<dynamic> loginWithGoogle(GoogleSignInAccount user) async {
  //   var idToken = ( await user?.authentication)?.idToken ?? "";
  //   final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
  //       NetworkConstants.GOOGLE_LOGIN, "POST",
  //       body: {"idToken": idToken, "provider": "GOOGLE"});
  //
  //   final ApiResponse apiResponse =
  //       await apiService.makeRequest(requestBuilder);
  //
  //   if (apiResponse.successResponse != null) {
  //     var jsonData = apiResponse.successResponse.responseBody;
  //     final tokenBox = await Hive.openBox(StorageConstants.TOKEN_BOX);
  //     tokenBox.put("token", Token.fromJson(jsonData.data));
  //     apiService.setHeaders(tokenBox.get("token"));
  //     return apiResponse.successResponse;
  //   } else {
  //     return apiResponse.errorResponse;
  //   }
  // }

  Future<void> logOut() async {
    final userBox = await Hive.openBox(StorageConstants.USER_BOX);
    final tokenBox = await Hive.openBox(StorageConstants.TOKEN_BOX);
    apiService.clearHeaders();
    userBox.clear();
    tokenBox.clear();
  }

  Future<dynamic> signUp(User user, String otp) async {
    final ApiRequestBuilder requestBuilder =
        ApiRequestBuilder(NetworkConstants.SIGN_UP, "POST", body: {
      "firstName": user.firstName,
      "lastName": user.lastName,
      "otp": otp,
      "email": user.email,
      "phone": user.phone,
      "password": user.password
    });
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }

  // Future<dynamic> signUpWithGoogle(GoogleSignInAccount user) async {
  //   var idToken = ( await user?.authentication)?.idToken ?? "";
  //   final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
  //       NetworkConstants.GOOGLE_SIGN_UP, "POST",
  //       body: {"idToken": idToken, "provider": "GOOGLE"});
  //
  //   final ApiResponse apiResponse =
  //       await apiService.makeRequest(requestBuilder);
  //
  //   if (apiResponse.successResponse != null) {
  //     return apiResponse.successResponse;
  //   } else {
  //     return apiResponse.errorResponse;
  //   }
  // }

  Future<dynamic> requestOTP(User user) async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
        NetworkConstants.REQUEST_OTP + "?email=${user.email}", "GET");
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }

  Future<dynamic> requestUserProfile() async {
    final ApiRequestBuilder requestBuilder =
        ApiRequestBuilder(NetworkConstants.PROFILE, "GET");
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      var jsonData = apiResponse.successResponse.responseBody;
      final userBox = await Hive.openBox(StorageConstants.USER_BOX);
      userBox.put("user", new User.fromJson(jsonData.data));
      return apiResponse.successResponse;
    } else {
      print("1 body " + apiResponse.errorResponse.message.toString());
      return apiResponse.errorResponse;
    }
  }

  Future<dynamic> getBanks() async {
    final ApiRequestBuilder requestBuilder =
        ApiRequestBuilder(NetworkConstants.BANKS, "GET");
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      List jsonData = apiResponse.successResponse.responseBody.data;
      final bankBox = await Hive.openBox(StorageConstants.BANK_BOX);
      bankBox.put(
          "banks", jsonData.map((json) => new Bank.fromJson(json)).toList());
      return apiResponse.successResponse;
    } else {
      print("1 body " + apiResponse.errorResponse.message.toString());
      return apiResponse.errorResponse;
    }
  }
}
