import 'package:cron_pay/src/commons/constants/network_constants.dart';
import 'package:cron_pay/src/commons/constants/storage_constants.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/commons/services/api.dart';
import 'package:cron_pay/src/events/models/event.dart';
import 'package:cron_pay/src/home/models/expense.dart';
import 'package:hive/hive.dart';

class EventService {
  final APIService apiService;
  EventService(this.apiService);

  Future<dynamic> saveEvent(Event event) async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
        NetworkConstants.EVENTS, "POST",
        body: event.toJson());

    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      var jsonData = apiResponse.successResponse.responseBody;
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }

  Future<dynamic> getEvents(int pageKey, int pageSize) async {
    final ApiRequestBuilder requestBuilder = ApiRequestBuilder(
        NetworkConstants.UPCOMING_EVENTS +
            "?unpaged=true&size=$pageSize&page=$pageKey",
        "GET");

    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }

  Future<dynamic> getEventDates(int pageKey, int pageSize) async {
    final ApiRequestBuilder requestBuilder =
        ApiRequestBuilder(NetworkConstants.USER_EVENT_DATES, "GET");

    final ApiResponse apiResponse =
        await apiService.makeRequest(requestBuilder);

    if (apiResponse.successResponse != null) {
      return apiResponse.successResponse;
    } else {
      return apiResponse.errorResponse;
    }
  }

  Future<void> clearAllExpenses() async {
    final cartBox = await Hive.openBox(StorageConstants.USER_EXPENSES);
    await cartBox.clear();
  }

  Future<List<Expense>> removeExpense(Expense expense) async {
    List<Expense> expenses = List<Expense>();
    final expenseBox = await Hive.openBox(StorageConstants.USER_EXPENSES);
    expenseBox.delete(expense);
    expenses.addAll(expenseBox.values.map((e) => e));
    return expenses;
  }
}
