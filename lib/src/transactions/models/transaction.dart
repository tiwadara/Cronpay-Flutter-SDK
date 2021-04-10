import 'package:cron_pay/src/beneficiaries/models/beneficiary.dart';
import 'package:cron_pay/src/payment/models/payment_method.dart';

class Transaction {
  double amount;
  Beneficiary beneficiary;
  String createdOn;
  PaymentMethod paymentMethod;
  int scheduleId;
  String status;
  String reference;

  Transaction(
      {this.amount,
      this.beneficiary,
      this.createdOn,
      this.paymentMethod,
      this.scheduleId,
      this.status,
      this.reference});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: json['amount'],
      beneficiary: json['beneficiary'] != null
          ? Beneficiary.fromJson(json['beneficiary'])
          : null,
      createdOn: json['createdOn'],
      paymentMethod: json['paymentMethod'] != null
          ? PaymentMethod.fromJson(json['paymentMethod'])
          : null,
      scheduleId: json['scheduleId'],
      status: json['status'],
      reference: json['reference'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['scheduleId'] = this.scheduleId;
    data['status'] = this.status;
    data['reference'] = this.reference;
    if (this.beneficiary != null) {
      data['beneficiary'] = this.beneficiary.toJson();
    }
    data['createdOn'] = this.createdOn;

    if (this.paymentMethod != null) {
      data['paymentMethod'] = this.paymentMethod.toJson();
    }
    return data;
  }
}
