part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState extends Equatable {
  const DashboardState();
}

class InitialProfileState extends DashboardState {
  @override
  List<Object> get props => [];
}

@immutable
class ErrorWithMessageState extends DashboardState {
  final String error;
  ErrorWithMessageState(this.error);
  @override
  List<Object> get props => [error];
}

class UpdatingProfilePicture extends DashboardState {
  @override
  List<Object> get props => [];
}

@immutable
class DashboardCountReceived extends DashboardState {
  final int count;
  DashboardCountReceived(this.count);
  @override
  List<Object> get props => [count];
}
