part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

@immutable
class GetUserProfile extends ProfileEvent {
  @override
  List<Object> get props => [];
}

@immutable
class UpdateUserProfile extends ProfileEvent {
  final User user;
  UpdateUserProfile(this.user);
  @override
  List<Object> get props => [user];
}

@immutable
class UpdateProfileImage extends ProfileEvent {
  final String photoData;
  UpdateProfileImage(this.photoData);
  @override
  List<Object> get props => [photoData];
}

