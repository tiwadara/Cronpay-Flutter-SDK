import 'package:cron_pay/src/auth/models/token.dart';
import 'package:cron_pay/src/commons/constants/network_constants.dart';
import 'package:cron_pay/src/commons/constants/storage_constants.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/commons/models/bank.dart';
import 'package:cron_pay/src/commons/services/api.dart';
import 'package:hive/hive.dart';

class BankService {
  final APIService apiService;
  BankService(this.apiService);

  Future<dynamic> getBanks() async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(NetworkConstants.BANKS, "GET");
    final ApiResponse apiResponse = await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      List jsonData = apiResponse.successResponse.responseBody.data;
      final bankBox = await Hive.openBox(StorageConstants.BANK_BOX);
      bankBox.put(
          "banks", jsonData.map((json) => new Bank.fromJson(json)).toList());
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }
}
