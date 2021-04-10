import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SplashEvent extends Equatable {
  SplashEvent([List props = const []]) : super();
}

class LoadSplashEvent extends SplashEvent {
  @override
  List<Object> get props => [];
}
class OnboardingSeenEvent extends SplashEvent {
  @override
  List<Object> get props => [];
}