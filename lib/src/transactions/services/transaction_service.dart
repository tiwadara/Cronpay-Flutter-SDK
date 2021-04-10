import 'package:cron_pay/src/commons/constants/network_constants.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/commons/services/api.dart';

class TransactionService {
  final APIService apiService;
  TransactionService(this.apiService);

  Future<dynamic> getUserTransactions() async {
    final ApiRequestBuilder requestBuilder =
        ApiRequestBuilder(NetworkConstants.USER_TRANSACTIONS, "GET");
    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      var jsonData = apiResponse.successResponse.responseBody;
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }
}
