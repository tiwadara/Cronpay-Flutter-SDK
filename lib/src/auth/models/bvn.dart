class BVN {
  int id;
  String phone;
  String bvn;
  String dob;
  String firstName;
  String lastName;
  String otherName;

  BVN(
      {this.id,
      this.phone,
        this.bvn,
      this.dob,
      this.lastName,
      this.firstName,
      this.otherName});

  BVN.fromJson(dynamic json) {
    id = json["id"];
    phone = json["phone"];
    bvn = json["bvn"];
    dob = json["dob"];
    lastName = json["lastName"];
    firstName = json["firstName"];
    otherName = json["otherName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["phone"] = phone;
    map["bvn"] = bvn;
    map["dob"] = dob;
    map["lastName"] = lastName;
    map["firstName"] = firstName;
    map["otherName"] = otherName;
    return map;
  }

  bool checkIfAnyBvnDetailIsNull() {
    List searchProperties = [bvn, dob];
    return searchProperties.contains(null) || searchProperties.contains("");
  }
}
