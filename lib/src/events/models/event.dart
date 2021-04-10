import 'package:cron_pay/src/beneficiaries/models/beneficiary.dart';

class Event {
  int id;
  String lastRunDate;
  String nextRunDate;
  String status;
  String name;
  String description;
  double amount;
  String interval;
  int increment;
  String startDate;
  String endDate;
  Beneficiary beneficiary;

  Event(
      {
        this.id,
      this.lastRunDate,
      this.nextRunDate,
      this.status,
      this.name,
      this.description,
      this.amount,
      this.interval,
      this.increment,
      this.startDate,
      this.endDate,
      this.beneficiary});

  Event.fromJson(dynamic json) {
    id = json["id"];
    lastRunDate = json["lastRunDate"];
    nextRunDate = json["nextRunDate"];
    status = json["status"];
    name = json["name"];
    description = json["description"];
    amount = json["amount"];
    interval = json["interval"];
    increment = json["increment"];
    startDate = json["startDate"];
    endDate = json["endDate"];
    beneficiary = json["beneficiary"] != null
        ? Beneficiary.fromJson(json["beneficiary"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    // map["id"] = id;
    // map["lastRunDate"] = lastRunDate;
    // map["nextRunDate"] = nextRunDate;
    // map["status"] = status;
    map["name"] = name;
    map["description"] = description;
    map["amount"] = amount;
    map["interval"] = interval;
    map["increment"] = increment;
    map["startDate"] = startDate;
    map["endDate"] = endDate;
    if (beneficiary != null) {
      map["beneficiary"] = beneficiary.toJson();
    }
    return map;
  }

  bool checkIfAnyIsNull() {
    List searchProperties = [name, amount, beneficiary, startDate];
    return searchProperties.contains(null) || searchProperties.contains("");
  }
}
