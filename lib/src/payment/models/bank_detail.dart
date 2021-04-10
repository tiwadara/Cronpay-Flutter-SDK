import 'package:cron_pay/src/commons/models/bank.dart';

class BankDetail {
  String accountName;
  Bank bank;

  BankDetail({this.accountName, this.bank});

  BankDetail.fromJson(dynamic json) {
    bank = json["bank"] != null ? Bank.fromJson(json["bank"]) : null;
    accountName = json["accountName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["accountName"] = accountName;
    if (bank != null) {
      map["bank"] = bank.toJson();
    }
    return map;
  }
}
