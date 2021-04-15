part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class HomeInitialState extends AuthState {
  @override
  List<Object> get props => [];
}

@immutable
class BVNVeried extends AuthState {
  BVNVeried( );

  @override
  List<Object> get props => [];
}

@immutable
class VerifyingBVN extends AuthState {
  VerifyingBVN();

  @override
  List<Object> get props => [];
}

@immutable
class InvalidBVN extends AuthState {
  InvalidBVN();

  @override
  List<Object> get props => [];
}

@immutable
class OTPConfirmed extends AuthState {
  OTPConfirmed();

  @override
  List<Object> get props => [];
}

@immutable
class InvalidOTP extends AuthState {
  InvalidOTP();

  @override
  List<Object> get props => [];
}

@immutable
class VerifyingOTP extends AuthState {
  VerifyingOTP();

  @override
  List<Object> get props => [];
}

@immutable
class SigningUp extends AuthState {
  SigningUp();

  @override
  List<Object> get props => [];
}

@immutable
class SigningIn extends AuthState {
  SigningIn();

  @override
  List<Object> get props => [];
}

@immutable
class RequestingPasswordReset extends AuthState {
  @override
  List<Object> get props => [];
}

@immutable
class LoginSuccessful extends AuthState {
  LoginSuccessful();

  @override
  List<Object> get props => [];
}

@immutable
class ResetCodeSent extends AuthState {
  ResetCodeSent();

  @override
  List<Object> get props => [];
}


@immutable
class SigUpSuccessful extends AuthState {
  SigUpSuccessful();

  @override
  List<Object> get props => [];
}

// @immutable
// class SigUpWithGoogleSuccessful extends AuthState {
//   final GoogleSignInAccount user;
//   SigUpWithGoogleSuccessful(this.user);
//
//   @override
//   List<Object> get props => [user];
// }

@immutable
class RequestError extends AuthState {
  final ErrorResponse errorResponse;
  RequestError(this.errorResponse);

  @override
  List<Object> get props => [errorResponse];
}

@immutable
class OTPSuccessful extends AuthState {
  OTPSuccessful();

  @override
  List<Object> get props => [];
}
@immutable
class LogoutSuccessful extends AuthState {
  LogoutSuccessful();

  @override
  List<Object> get props => [];
}

@immutable
class RequestingOTP extends AuthState {
  RequestingOTP();

  @override
  List<Object> get props => [];
}
