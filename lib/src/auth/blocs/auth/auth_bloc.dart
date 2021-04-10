import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cron_pay/src/auth/models/bvn.dart';
import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/auth/services/auth_service.dart';
import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  AuthBloc(this.authService) : super(HomeInitialState());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is UpdateBVN) {
      yield VerifyingBVN();
      var response = await authService.verifyBvn(event.bvn);
      if (response != null) {
        if (response) {
          yield BVNVeried();
        } else {
          yield InvalidBVN();
        }
      }
    } else if (event is VerifyUser) {
      yield VerifyingOTP();
      var response = await authService.verifyUser(event.pin, event.user);
      if (response != null) {
        if (response) {
          yield OTPConfirmed();
        } else {
          yield InvalidOTP();
        }
      }
    } else if (event is LogInEvent) {
      yield SigningIn();
      var response = await authService.logIn(event.user);
      if (response != null) {
        if (response is SuccessResponse) {
          yield LoginSuccessful();
        } else if (response is ErrorResponse) {
          yield RequestError(response);
        }
      }
    } else if (event is RequestPasswordResetEvent) {
      yield RequestingPasswordReset();
      var response = await authService.resetPassword(event.user);
      if (response != null) {
        if (response is SuccessResponse) {
          yield ResetCodeSent();
        } else if (response is ErrorResponse) {
          yield RequestError(response);
        }
      }
    } else if (event is SetNewPasswordEvent) {
      yield RequestingPasswordReset();
      var response = await authService.newPassword(event.newPassword, event.otp);
      if (response != null) {
        if (response is SuccessResponse) {
          yield ResetCodeSent();
        } else if (response is ErrorResponse) {
          yield RequestError(response);
        }
      }
    } else if (event is LoginWithGoogleEvent) {
      yield SigningIn();
      var response = await authService.loginWithGoogle(event.user);
      if (response != null) {
        if (response is SuccessResponse) {
          yield LoginSuccessful();
        } else if (response is ErrorResponse) {
          yield RequestError(response);
        }
      }
    }else if (event is SignUpEvent) {
      yield SigningUp();
      var response = await authService.signUp(event.user, event.otp);
      if (response != null) {
        if (response is SuccessResponse) {
          yield SigUpSuccessful();
        } else if (response is ErrorResponse) {
          yield RequestError(response);
        }
      }
    } else if (event is SignUpWithGoogleEvent) {
      yield SigningUp();
      var response = await authService.signUpWithGoogle(event.user);
      if (response != null) {
        if (response is SuccessResponse) {
          yield SigUpWithGoogleSuccessful(event.user);
        } else if (response is ErrorResponse) {
          yield RequestError(response);
        }
      }
    } else if (event is RequestOTP) {
      yield RequestingOTP();
      var response = await authService.requestOTP(event.user);
      if (response != null) {
        if (response is SuccessResponse) {
          yield OTPSuccessful();
        } else if (response is ErrorResponse) {
          yield RequestError(response);
        }
      }
    } else if (event is LogoutRequestEvent) {
      await authService.logOut();
      yield LogoutSuccessful();
    }
  }
}
