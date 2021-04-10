import 'package:cron_pay/src/commons/constants/storage_constants.dart';
import 'package:hive/hive.dart';

part 'token.g.dart';

@HiveType(typeId: StorageConstants.TYPE_TOKEN)
class Token {
  @HiveField(0)
  String accessToken;
  @HiveField(1)
  String tokenType;

  Token({
    this.accessToken,
    this.tokenType,
  });

  Token.fromJson(dynamic json) {
    accessToken = json["access_token"];
    tokenType = json["token_type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["access_token"] = accessToken;
    map["token_type"] = tokenType;
    return map;
  }
}
