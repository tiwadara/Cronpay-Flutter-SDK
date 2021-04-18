class SdkParams {
  String accessToken;
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

  SdkParams(
      {this.accessToken,
      this.amount,
      this.startDate,
      this.endDate,
      this.customerReference,
      this.bvn,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.narration});

  SdkParams.fromJson(dynamic json) {
    accessToken = json["accessToken"];
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
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["accessToken"] = accessToken;
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
    return map;
  }
}
