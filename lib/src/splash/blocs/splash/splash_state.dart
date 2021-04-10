import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SplashState extends Equatable {
  SplashState([List props = const []]) : super();
}
@immutable
class InitialSplashState extends SplashState {
  @override
  List<Object> get props => [];
}

@immutable
class InitialAppLoad extends SplashState {
  @override
  List<Object> get props => [];
}
@immutable
class OnboardingSeenState extends SplashState {
  @override
  List<Object> get props => [];
}
