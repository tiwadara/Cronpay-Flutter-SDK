part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

@immutable
class GetEventCount extends DashboardEvent {
  @override
  List<Object> get props => [];
}

@immutable
class UpdateUserProfile extends DashboardEvent {
  final User user;
  UpdateUserProfile(this.user);
  @override
  List<Object> get props => [user];
}


