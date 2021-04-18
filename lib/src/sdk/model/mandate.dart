class Mandate {
  int amount;
  String startDate;
  String endDate;
  String customerReference;
  String bvn;
  String firstName;
  String lastName;
  String email;
  String phone;
  String narration;
  String accountNumber;
  String bankId;
  String signature;

  Mandate(
      {this.amount,
      this.startDate,
      this.endDate,
      this.customerReference,
      this.bvn,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.accountNumber,
      this.bankId,
      this.signature,
      this.narration});

  Mandate.fromJson(dynamic json) {
    amount = json["amount"];
    startDate = json["startDate"];
    endDate = json["endDate"];
    customerReference = json["customerReference"];
    bvn = json["bvn"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    phone = json["phone"];
    narration = json["narration"];
    accountNumber = json["accountNumber"];
    bankId = json["bankId"];
    signature = json["signature"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["amount"] = amount;
    map["startDate"] = startDate;
    map["endDate"] = endDate;
    map["customerReference"] = customerReference;
    map["bvn"] = bvn;
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["email"] = email;
    map["phone"] = phone;
    map["narration"] = narration;
    map["accountNumber"] = accountNumber;
    map["bankId"] = bankId;
    map["signature"] = signature;
    return map;
  }
}
