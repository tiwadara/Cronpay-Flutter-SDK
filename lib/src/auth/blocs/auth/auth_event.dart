part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

@immutable
class UpdateBVN extends AuthEvent {
  final BVN bvn;

  UpdateBVN(this.bvn);

  @override
  List<Object> get props => [bvn];
}

@immutable
class VerifyUser extends AuthEvent {
  final String pin;
  final User user;

  VerifyUser(this.pin, this.user);

  @override
  List<Object> get props => [pin, user];
}

@immutable
class LogInEvent extends AuthEvent {
  final User user;

  LogInEvent(this.user);

  @override
  List<Object> get props => [user];
}

@immutable
class RequestPasswordResetEvent extends AuthEvent {
  final User user;

  RequestPasswordResetEvent(this.user);

  @override
  List<Object> get props => [user];
}

@immutable
class SetNewPasswordEvent extends AuthEvent {
  final String newPassword;
  final String otp;

  SetNewPasswordEvent({this.newPassword, this.otp});

  @override
  List<Object> get props => [newPassword, otp];
}

// @immutable
// class LoginWithGoogleEvent extends AuthEvent {
//   final GoogleSignInAccount user;
//
//   LoginWithGoogleEvent(this.user);
//
//   @override
//   List<Object> get props => [user];
// }

@immutable
class SignUpEvent extends AuthEvent {
  final User user;
  final String otp;

  SignUpEvent(this.user, this.otp);

  @override
  List<Object> get props => [user, otp];
}

// @immutable
// class SignUpWithGoogleEvent extends AuthEvent {
//   final GoogleSignInAccount user;
//
//   SignUpWithGoogleEvent(this.user);
//
//   @override
//   List<Object> get props => [user];
// }

@immutable
class RequestOTP extends AuthEvent {
  final User user;

  RequestOTP(this.user);

  @override
  List<Object> get props => [user];
}

@immutable
class LogoutRequestEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
