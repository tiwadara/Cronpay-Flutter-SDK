import 'package:json_annotation/json_annotation.dart';

part 'success_response_body.g.dart';

@JsonSerializable()
class SuccessResponseBody {
  final int status;
  final String message;
  final dynamic data;

  SuccessResponseBody({this.status, this.message, this.data});

  factory SuccessResponseBody.fromJson(Map<String, dynamic> json) =>
      _$SuccessResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessResponseBodyToJson(this);
}
