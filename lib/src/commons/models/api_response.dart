import 'package:cron_pay/src/commons/models/success_response_body.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class ApiResponse extends Equatable  {
  final SuccessResponse successResponse;
  final ErrorResponse errorResponse;

  @override
  List<Object> get props => [successResponse, errorResponse];

  ApiResponse({this.successResponse, this.errorResponse});

  @override
  String toString() {
    return super.toString();
  }
}

@immutable
class SuccessResponse extends Equatable {
  final SuccessResponseBody responseBody;
  final String message;
  final ApiRequestBuilder apiRequest;


  @override
  List<Object> get props => [responseBody, message, apiRequest];
  SuccessResponse(this.responseBody, this.apiRequest, {this.message=""});
}

@immutable
class ErrorResponse  extends Equatable {
  final String message;
  final ApiRequestBuilder apiRequest;

  @override
  List<Object> get props => [apiRequest, message];

  ErrorResponse(this.apiRequest, this.message);
}

@immutable
class ApiRequestBuilder extends Equatable {
  final String path;
  final String method;
  final Map<String, dynamic> body;
  final Map<String, dynamic> headers;

  @override
  List<Object> get props => [path, method, body, headers];

  ApiRequestBuilder(this.path, this.method, {this.body, this.headers=const {}});

}