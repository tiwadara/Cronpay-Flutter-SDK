import 'package:cron_pay/src/auth/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SDKEvent extends Equatable {
  SDKEvent([List props = const []]) : super();
}

class InitializeSDK extends SDKEvent {
  final String accessToken;

  InitializeSDK(this.accessToken);
  @override
  List<Object> get props => [accessToken];
}

class GetSdkMerchantToken extends SDKEvent {
  @override
  List<Object> get props => [];
}

class InitializationFailed extends SDKEvent {
  @override
  List<Object> get props => [];
}

class SendSuccessCallBackToPlatform extends SDKEvent {
  @override
  List<Object> get props => [];
}

class SendCloseCallBackToPlatform extends SDKEvent {
  @override
  List<Object> get props => [];
}
