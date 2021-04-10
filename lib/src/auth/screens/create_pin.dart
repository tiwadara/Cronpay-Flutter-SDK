import 'dart:async';

import 'package:cron_pay/src/auth/blocs/auth/auth_bloc.dart';
import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/asset_constants.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/widgets/app_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class CreatePIN extends StatefulWidget {
  static const String routeName = '/createPin';
  final User user;

  CreatePIN([this.user]);

  @override
  _CreatePINState createState() => _CreatePINState();
}

class _CreatePINState extends State<CreatePIN> {
  AuthBloc _authBloc;
  int _start = 40;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    // _bvn = widget.bvn;
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
          Header(title: "Create PIN"),
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
                          image: AssetImage(Assets.pin),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 23.h,
                    ),
                    Text(
                      "Welcome to CronPay",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Text(
                      "Enter a 4-digits PIN for your CronPay account",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    SizedBox(
                      width: 230.w,
                      height: 40.h,
                      child: PinInputTextField(
                        pinLength: 4,
                        decoration: BoxLooseDecoration(
                          obscureStyle: ObscureStyle(
                              obscureText: "*", isTextObscure: true),
                          strokeWidth: 2,
                          strokeColorBuilder: PinListenColorBuilder(
                              AppColors.primaryDark, AppColors.borderGrey),
                        ),
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.number,
                        onSubmit: (pin) {
                          print("OnS SUbmit");
                        },
                        onChanged: (pin) {
                          print("OnS change " + pin);
                          if (pin.length == 4) {
                            // _verifyBVN(pin);
                            gotoNextScreen();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 28.h,
                    ),
                    // BlocConsumer<AuthBloc, AuthState>(
                    //   listener: (context, state) {
                    //     if (state is OTPConfirmed) {
                    //       Future.delayed(Duration(seconds: 2), () {
                    //         gotoNextScreen();
                    //       });
                    //     }
                    //   },
                    //   builder: (BuildContext context, state) {
                    //     if (state is OTPConfirmed) {
                    //       return Row(
                    //         children: [
                    //           Icon(
                    //             Boxicons.bxs_check_circle,
                    //             color: AppColors.primary,
                    //             size: 14,
                    //           ),
                    //           Text(
                    //             " Verified",
                    //             style: TextStyle(
                    //                 color: AppColors.primary, fontSize: 10),
                    //           )
                    //         ],
                    //       );
                    //     } else if (state is InvalidOTP) {
                    //       return Row(
                    //         children: [
                    //           Icon(
                    //             Boxicons.bxs_x_circle,
                    //             color: AppColors.red,
                    //             size: 14,
                    //           ),
                    //           Text(
                    //             " Invalid",
                    //             style: TextStyle(
                    //                 color: AppColors.red, fontSize: 10),
                    //           )
                    //         ],
                    //       );
                    //     } else if (state is VerifyingOTP) {
                    //       return SizedBox(
                    //           height: 10,
                    //           width: 10,
                    //           child: CircularProgressIndicator(
                    //             strokeWidth: 1.5,
                    //           ));
                    //     }
                    //     return Container();
                    //   },
                    // ),
                    SizedBox(
                      height: 31.h,
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
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.allDone, (Route<dynamic> route) => false);
  }

  void _verifyBVN(String pin) {
    FocusScope.of(context).unfocus();
    _authBloc.add(VerifyUser(pin, widget.user));
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }
}
