import 'package:cron_pay/src/commons/constants/storage_constants.dart';
import 'package:cron_pay/src/home/models/expense.dart';
import 'package:hive/hive.dart';

class HomeService {
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
