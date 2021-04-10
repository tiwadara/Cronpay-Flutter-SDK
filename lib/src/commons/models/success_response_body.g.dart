// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessResponseBody _$SuccessResponseBodyFromJson(Map<String, dynamic> json) {
  return SuccessResponseBody(
    status: json['status'] as int,
    message: json['message'] as String,
    data: json['data'],
  );
}

Map<String, dynamic> _$SuccessResponseBodyToJson(
        SuccessResponseBody instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
