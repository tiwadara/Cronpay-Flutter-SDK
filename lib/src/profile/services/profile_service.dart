import 'dart:developer';

import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/network_constants.dart';
import 'package:cron_pay/src/commons/constants/storage_constants.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/commons/services/api.dart';
import 'package:hive/hive.dart';

class ProfileService {
  final APIService apiService;
  ProfileService(this.apiService);

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
      return apiResponse.errorResponse;
    }
  }

  Future<dynamic> getDashboardCount() async {
    final ApiRequestBuilder requestBuilder =
        ApiRequestBuilder(NetworkConstants.COUNT, "GET");
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }

  Future<dynamic> updateUserProfile(User user) async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
        NetworkConstants.PROFILE, "PATCH",
        body: {"firstName": user.firstName, "lastName": user.lastName});
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);
    if (apiResponse.successResponse != null) {
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }

  Future<dynamic> updateProfilePicture(String photoData) async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
        NetworkConstants.PHOTO, "PATCH",
        body: {"data": photoData});
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);
    if (apiResponse.successResponse != null) {
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }
}
