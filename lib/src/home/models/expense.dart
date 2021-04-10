import 'package:cron_pay/src/commons/constants/storage_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

@JsonSerializable()
@HiveType(typeId: StorageConstants.TYPE_EXPENSE)
class Expense {
  @HiveField(0)
  int id;
  @HiveField(1)
  String memo;
  @HiveField(2)
  double amount;
  @HiveField(3)
  String createdAt;
  @HiveField(4)
  String updatedAt;
  @HiveField(5)
  String category;

  bool checkIfAnyIsNull() {
    List searchProperties = [memo, amount, category];
    return searchProperties.contains(null) || searchProperties.contains("");
  }

  Expense({
    this.id,
    this.memo,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
