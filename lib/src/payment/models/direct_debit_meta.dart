import 'package:cron_pay/src/commons/models/bank.dart';

class DirectDebitMeta {
  String accountNumber;
  bool active;
  Bank bank;
  String endDate;
  int id;
  String mandateCode;
  String startDate;

  DirectDebitMeta(
      {this.accountNumber,
      this.active,
      this.bank,
      this.endDate,
      this.id,
      this.mandateCode,
      this.startDate});

  factory DirectDebitMeta.fromJson(Map<String, dynamic> json) {
    return DirectDebitMeta(
      accountNumber: json['accountNumber'],
      active: json['active'],
      bank: json['bank'] != null ? Bank.fromJson(json['bank']) : null,
      endDate: json['endDate'],
      id: json['id'],
      mandateCode: json['mandateCode'],
      startDate: json['startDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountNumber'] = this.accountNumber;
    data['active'] = this.active;
    data['endDate'] = this.endDate;
    data['id'] = this.id;
    data['mandateCode'] = this.mandateCode;
    data['startDate'] = this.startDate;
    if (this.bank != null) {
      data['bank'] = this.bank.toJson();
    }
    return data;
  }
}
