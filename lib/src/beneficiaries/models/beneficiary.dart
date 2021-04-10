import 'package:cron_pay/src/commons/models/bank.dart';

class Beneficiary {
  String accountNumber;
  String alias;
  Bank bank;
  int bankId;
  int id;
  String name;

  Beneficiary({this.accountNumber, this.alias, this.bank, this.bankId,
    this.id, this.name
  });

  Beneficiary.fromJson(dynamic json) {
    accountNumber = json["accountNumber"];
    alias = json["alias"];
    bank = json["bank"] != null ? Bank.fromJson(json["bank"]) : null;
    bankId = json["bankId"];
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["accountNumber"] = accountNumber;
    map["alias"] = alias;
    if (bank != null) {
      map["bank"] = bank.toJson();
    }
    map["bankId"] = bankId;
    map["id"] = id;
    map["name"] = name;
    return map;
  }
}
