import 'package:cron_pay/src/commons/models/bank.dart';

class CardMeta {
  String accessCode;
  String publicKey;
  String cardFirstSixDigits;
  String cardLastFourDigits;
  String cardType;
  int expiryMonth;
  int expiryYear;
  int id;
  bool active;

  String accountNumber;
  Bank bank;
  String endDate;
  String mandateCode;
  String startDate;
  String status;

  CardMeta(
      {this.accessCode,
      this.publicKey,
      this.cardFirstSixDigits,
      this.cardLastFourDigits,
      this.cardType,
      this.expiryYear,
      this.active,
      this.id,
      this.expiryMonth,

        this.accountNumber,
        this.bank,
        this.endDate,
        this.mandateCode,
        this.startDate,
        this.status
      });

  factory CardMeta.fromJson(Map<String, dynamic> json) {
    return CardMeta(
      accessCode: json['access_code'],
      publicKey: json['public_key'],
      cardFirstSixDigits: json['cardFirstSixDigits'],
      cardLastFourDigits: json['cardLastFourDigits'],
      cardType: json['cardType'],
      id: json['id'],
      active: json['active'],
      expiryYear: json['expiryYear'],
      expiryMonth: json['expiryMonth'],

      accountNumber: json['accountNumber'],
      bank: json['bank'] != null ? Bank.fromJson(json['bank']) : null,
      endDate: json['endDate'],
      mandateCode: json['mandateCode'],
      startDate: json['startDate'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_code'] = this.accessCode;
    data['public_key'] = this.publicKey;
    data['cardType'] = this.cardType;
    data['cardLastFourDigits'] = this.cardLastFourDigits;
    data['cardFirstSixDigits'] = this.cardFirstSixDigits;
    data['active'] = this.active;
    data['id'] = this.id;
    data['expiryMonth'] = this.expiryMonth;
    data['expiryYear'] = this.expiryYear;

    data['accountNumber'] = this.accountNumber;
    data['endDate'] = this.endDate;
    data['mandateCode'] = this.mandateCode;
    data['startDate'] = this.startDate;
    if (this.bank != null) {
      data['bank'] = this.bank.toJson();
    }
    data['status'] = this.status;

    return data;
  }
}
