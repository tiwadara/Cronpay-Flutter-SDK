import 'package:cron_pay/src/commons/constants/storage_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bank.g.dart';

@HiveType(typeId: StorageConstants.TYPE_BANK)
@JsonSerializable()
class Bank {
  @HiveField(0)
  String abbr;
  @HiveField(1)
  int id;
  @HiveField(2)
  String name;

  Bank({this.abbr, this.id, this.name});

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  Map<String, dynamic> toJson() => _$BankToJson(this);
}
