import 'dart:async';

import 'package:cron_pay/src/auth/blocs/auth/auth_bloc.dart';
import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/asset_constants.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/widgets/app_header.dart';
import 'package:cron_pay/src/commons/widgets/app_loader.dart';
import 'package:cron_pay/src/commons/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class Verification extends StatefulWidget {
  static const String routeName = '/verification';
  final User user;

  Verification([this.user]);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  AuthBloc _authBloc;
  int _start = 40;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    startTimer();
    super.initState();
  }

  void startTimer() {
    new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setStateIfMounted(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.windowColor,
      body: Column(
        children: <Widget>[
          Header(title: "Verification"),
          SizedBox(
            height: 28.h,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 28.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: SizedBox(
                        height: 104.h,
                        child: Image(
                          image: AssetImage(Assets.otp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 23.h,
                    ),
                    Text(
                      "OTP Verification",
                      style: TextStyle(
                          fontSize: 21.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColors.textColor),
                        children: [
                          TextSpan(
                            text: "Enter the 4-digit code sent to ",
                          ),
                          TextSpan(
                            text: " ${widget.user.email}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: " to verify your email",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    SizedBox(
                      width: 250.w,
                      height: 40.h,
                      child: PinInputTextField(
                        autoFocus: true,
                        pinLength: 4,
                        decoration: BoxLooseDecoration(
                          strokeWidth: 2,
                          strokeColorBuilder: PinListenColorBuilder(
                              AppColors.primaryDark, AppColors.borderGrey),
                        ),
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.number,
                        onSubmit: (pin) {
                        },
                        onChanged: (pin) {
                          if (pin.length == 4) {
                            _verifyUser(pin);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 28.h,
                    ),
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is SigUpSuccessful) {
                          Future.delayed(Duration(seconds: 3), () {
                            Navigator.pop(context);
                            showOverlay(context, "Creating User Account");
                            _authBloc.add(LogInEvent(widget.user));
                          });
                        } else if (state is SigningUp) {
                          showOverlay(context, "Verifying Email");
                        } else if (state is LoginSuccessful) {
                          Navigator.pop(context);
                          showOverlay(context, "Signing you in");
                          Future.delayed(Duration(seconds: 3), () {
                            Navigator.pop(context);
                            gotoNextScreen();
                          });
                        } else if (state is OTPSuccessful) {
                          Navigator.pop(context);
                          showOverlay(context, "Sending Verification code");
                          Future.delayed(Duration(seconds: 3), () {
                            Navigator.pop(context);
                          });
                        } else if (state is RequestingOTP) {
                          showOverlay(context, "Requesting new OTP");
                        } else if (state is RequestError) {
                          Navigator.pop(context);
                          AppSnackBar()
                              .show(message: state.errorResponse.message);
                        }
                      },
                      child: Container(),
                    ),
                    SizedBox(
                      height: 31.h,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _start > 0
                              ? Text("Request another code in " +
                                  _start.toString() +
                                  " seconds")
                              : InkWell(
                                  onTap: _requestAnotherOTP,
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: "Didn’t receive OTP code ? ",
                                          style: TextStyle(
                                              color: AppColors.accentDark)),
                                      TextSpan(
                                          text: "RESEND CODE",
                                          style: TextStyle(
                                              color: AppColors.primaryDark))
                                    ]),
                                  )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void pop() {
    Navigator.pop(context);
  }

  void gotoNextScreen() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.navigationHost, (Route<dynamic> route) => false);
  }

  void _verifyUser(String pin) {
    FocusScope.of(context).unfocus();
    _authBloc.add(SignUpEvent(widget.user, pin));
  }

  void _requestAnotherOTP() {
    setStateIfMounted(() {
      _start = 40;
      startTimer();
    });
    _authBloc.add(RequestOTP(widget.user));
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }
}
