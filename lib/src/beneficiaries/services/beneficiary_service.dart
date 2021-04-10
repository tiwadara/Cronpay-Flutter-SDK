import 'package:cron_pay/src/commons/constants/network_constants.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/commons/services/api.dart';
import 'package:cron_pay/src/events/models/event.dart';

class BeneficiaryService {
  final APIService apiService;
  BeneficiaryService(this.apiService);

  Future<dynamic> saveEvent(Event event) async {

    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
        NetworkConstants.EVENTS, "POST",
        body: event.toJson());

    print("df" + requestBuilder.body.toString());

    final ApiResponse apiResponse = await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      var jsonData = apiResponse.successResponse.responseBody;
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }

  Future<dynamic> getBeneficiaries() async {

    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
        NetworkConstants.USER_BENEFICIARIES, "GET" );

    final ApiResponse apiResponse = await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      var jsonData = apiResponse.successResponse.responseBody;
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }
}
