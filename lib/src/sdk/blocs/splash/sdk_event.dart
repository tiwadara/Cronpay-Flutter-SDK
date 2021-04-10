import 'package:cron_pay/src/auth/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SDKEvent extends Equatable {
  SDKEvent([List props = const []]) : super();
}

class InitializeSDK extends SDKEvent {
  final User user;

  InitializeSDK(this.user);
  @override
  List<Object> get props => [user];
}

class InitializationFailed extends SDKEvent {
  @override
  List<Object> get props => [];
}
