import 'dart:async';

import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/profile/services/profile_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends HydratedBloc<ProfileEvent, ProfileState> {
  final ProfileService profileService;

  ProfileBloc(this.profileService) : super(InitialProfileState());

  ProfileState get initialState => InitialProfileState();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is GetUserProfile) {
      
      var response = await profileService.requestUserProfile();
      if (response != null) {
        if (response is SuccessResponse) {
          var data = response.responseBody.data;
          yield UserProfileReceived(User.fromJson(data));
        } else if (response is ErrorResponse) {
          yield ErrorWithMessageState(response.message);
        }
      }
    } else if (event is UpdateUserProfile) {
      var response = await profileService.updateUserProfile(event.user);
      if (response != null) {
        if (response is SuccessResponse) {
          var data = response.responseBody.data;
          yield UserProfileUpdated(User.fromJson(data));
        } else if (response is ErrorResponse) {
          yield ErrorWithMessageState(response.message);
        }
      }
    }else if (event is UpdateProfileImage) {
      yield UpdatingProfilePicture();
      var response = await profileService.updateProfilePicture(event.photoData);
      if (response != null) {
        if (response is SuccessResponse) {
          yield ProfilePictureUpdated();
        } else if (response is ErrorResponse) {
          yield ErrorWithMessageState(response.message);
        }
      }
    }
  }

  @override
  ProfileState fromJson(Map<String, dynamic> json) {
    try {
      return UserProfileReceived(User.fromJson(json));
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(ProfileState state) {
    if (state is UserProfileReceived) {
      return {
        'user': state.user,
      };
    }
    return null;
  }
}
