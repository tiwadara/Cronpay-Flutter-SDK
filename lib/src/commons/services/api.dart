import 'dart:developer';

import 'package:cron_pay/src/auth/models/token.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/commons/models/success_response_body.dart';
import 'package:dio/dio.dart';

class APIService {
  final Dio _dio;

  APIService(this._dio);

  void setHeaders(Token authToken) async {
    final Map<String, dynamic> existingHeaders = _dio.options.headers;
    existingHeaders['Authorization'] = authToken.tokenType + " " + authToken.accessToken;
  }

  void clearHeaders() async {
    final Map<String, dynamic> existingHeaders = _dio.options.headers;
    existingHeaders.clear();
  }

  Future<ApiResponse> makeRequest(final ApiRequestBuilder apiRequest) async {
    final String generalErrorMessage = "An error occurred, please try again";

    try {
      final Map<String, dynamic> existingHeaders = _dio.options.headers;
      apiRequest.headers.forEach((key, value) {
        existingHeaders[key] = value;
      });
      existingHeaders['content-type'] = 'application/json';

      final Response response = await _dio.request(
        apiRequest.path,
        data: apiRequest.body,
        options: Options(
          method: apiRequest.method,
          headers: existingHeaders,
        ),
      );

      if (response != null && response.data != null) {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return ApiResponse(
              successResponse: SuccessResponse(
                  SuccessResponseBody.fromJson(response.data), apiRequest));
        } else {
          return response.data.runtimeType == String
              ? ApiResponse(
                  errorResponse: ErrorResponse(apiRequest, generalErrorMessage))
              : ApiResponse(
                  errorResponse: ErrorResponse(apiRequest,
                      response.data['message'] ?? generalErrorMessage));
        }
      } else {
        // FirebaseCrashlytics.instance.log("API Error: ${response.data}");
        return ApiResponse(
            errorResponse: ErrorResponse(apiRequest, generalErrorMessage));
      }
    } on DioError catch (e) {

      print("errror" + e.toString());

      print("error  ** " + e.error .toString());

      // FirebaseCrashlytics.instance.log("Network Exception: ${e.toString()} + ${e.response}");
      if (e.response != null) {
        if (e.type == DioErrorType.connectTimeout) {
          return ApiResponse(
            errorResponse: ErrorResponse(apiRequest, "Connection timed out"),
          );
        }
        if (e.type == DioErrorType.receiveTimeout) {
          return ApiResponse(
            errorResponse: ErrorResponse(apiRequest, "Connection timed out"),
          );
        }
        if (e.response.statusCode == 401) {
          clearHeaders();
          return ApiResponse(
            errorResponse: ErrorResponse(apiRequest, "Session Expired"),
          );
        }
        return e.response.data.runtimeType == String
            ? ApiResponse(
                errorResponse: ErrorResponse(apiRequest, generalErrorMessage))
            : ApiResponse(
                errorResponse: ErrorResponse(apiRequest,
                    e.response.data['message'] ?? generalErrorMessage));
      }
      return ApiResponse(
        errorResponse: ErrorResponse(apiRequest, generalErrorMessage),
      );
    }
  }
}
