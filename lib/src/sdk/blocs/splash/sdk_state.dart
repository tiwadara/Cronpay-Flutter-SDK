import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SDKState extends Equatable {
  SDKState([List props = const []]) : super();
}
@immutable
class InitialSDKState extends SDKState {
  @override
  List<Object> get props => [];
}

@immutable
class Initializing extends SDKState {
  @override
  List<Object> get props => [];
}

@immutable
class SDKInitialized extends SDKState {
  @override
  List<Object> get props => [];
}

@immutable
class RequestError extends SDKState {
  final ErrorResponse errorResponse;
  RequestError(this.errorResponse);

  @override
  List<Object> get props => [errorResponse];
}
