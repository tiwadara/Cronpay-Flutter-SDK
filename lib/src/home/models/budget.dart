import 'package:cron_pay/src/commons/constants/storage_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'budget.g.dart';

@JsonSerializable()
@HiveType(typeId: StorageConstants.TYPE_BUDGET)
class Budget {
  @HiveField(0)
  int id;
  @HiveField(2)
  double amount;
  @HiveField(3)
  String createdAt;
  @HiveField(4)
  String updatedAt;
  @HiveField(5)
  String category;

  bool checkIfAnyIsNull() {
    List searchProperties = [amount];
    return searchProperties.contains(null) || searchProperties.contains("");
  }

  Budget({
    this.id,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory Budget.fromJson(Map<String, dynamic> json) =>
      _$BudgetFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetToJson(this);
}
