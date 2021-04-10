part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();
}

class InitialProfileState extends ProfileState {
  @override
  List<Object> get props => [];
}

@immutable
class ErrorWithMessageState extends ProfileState {
  final String error;
  ErrorWithMessageState(this.error);
  @override
  List<Object> get props => [error];
}

class UpdatingProfilePicture extends ProfileState {
  @override
  List<Object> get props => [];
}

@immutable
class UserProfileReceived extends ProfileState {
  final User user;
  UserProfileReceived(this.user);
  @override
  List<Object> get props => [user];
}

@immutable
class UserProfileUpdated extends ProfileState {
  final User user;
  UserProfileUpdated(this.user);
  @override
  List<Object> get props => [user];
}

@immutable
class ProfilePictureUpdated extends ProfileState {
  @override
  List<Object> get props => [];
}
