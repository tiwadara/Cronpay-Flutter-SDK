

import 'package:cron_pay/src/commons/constants/storage_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
@HiveType(typeId: StorageConstants.TYPE_USER)
class User {
  String id;
  @HiveField(0)
  String phone;
  String bvn;
  @HiveField(1)
  String email;
  @HiveField(2)
  String firstName;
  @HiveField(3)
  String lastName;
  @HiveField(4)
  String photoUrl;
  @HiveField(5)
  String socialAuthentication;
  String password;

  User(
      {this.id,
      this.phone,
        this.bvn,
      this.email,
      this.lastName,
      this.firstName,
      this.password,
      this.photoUrl,
      this.socialAuthentication});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  bool checkIfAnyIsNull() {
    List searchProperties = [firstName, lastName, password, email];
    return searchProperties.contains(null) || searchProperties.contains("");
  }

  bool checkIfAnyEditParamIsNull() {
    List searchProperties = [firstName, lastName];
    return searchProperties.contains(null) || searchProperties.contains("");
  }

  bool checkIfAnyLoginIsNull() {
    List searchProperties = [ email, password];
    return  searchProperties.contains(null) || searchProperties.contains("");
  }

}
