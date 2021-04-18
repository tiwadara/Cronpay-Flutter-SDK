import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/sdk/model/mandate.dart';
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
  final Mandate mandate;
  SDKInitialized(this.mandate);
  @override
  List<Object> get props => [mandate];
}

@immutable
class SDKMerchantTokenReceived extends SDKState {
  final String token;
  SDKMerchantTokenReceived(this.token);

  @override
  List<Object> get props => [token];
}

@immutable
class RequestError extends SDKState {
  final ErrorResponse errorResponse;
  RequestError(this.errorResponse);

  @override
  List<Object> get props => [errorResponse];
}

@immutable
class SendingCallBack extends SDKState {
  @override
  List<Object> get props => [];
}

@immutable
class CallbackSent extends SDKState {
  @override
  List<Object> get props => [];
}
