import 'package:cron_pay/src/auth/blocs/auth/auth_bloc.dart';
import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/app_strings.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/widgets/app_header.dart';
import 'package:cron_pay/src/commons/widgets/app_loader.dart';
import 'package:cron_pay/src/commons/widgets/app_password_text_input.dart';
import 'package:cron_pay/src/commons/widgets/app_snackbar.dart';
import 'package:cron_pay/src/commons/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';

class NewPassword extends StatefulWidget {
  static const String routeName = '/newPassword';
  NewPassword(this.user);
  final User user;

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  var isButtonDisabled = true;
  AuthBloc _authBloc;
  String _otp, _newPassword = "";

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.windowColor,
      body: Column(
        children: <Widget>[
          Header(
            title: "New Password",
            next: Container(),
          ),
          SizedBox(
            height: 25.h,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      'Please enter the 4-digit code that has been \nsent to ',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.textColor,
                  ),
                ),
                TextSpan(
                  text: '${widget.user.email}',
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 15.0,
                          offset: Offset(0, 8)),
                    ]),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                FeatherIcons.key,
                                color: AppColors.grey,
                              )),
                          Expanded(
                            child: TextField(
                                onChanged: (final String text) {
                                  _otp = text;
                                  watchFormState();
                                },
                                style: TextStyle(fontSize: 15),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    hintText: 'Input OTP sent to email address',
                                    border: InputBorder.none,
                                    labelText: 'ENTER OTP')),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.lock_outline,
                                color: AppColors.grey,
                              )),
                          Expanded(
                            child: PasswordTextInput(
                              label: "NEW PASSWORD",
                              // helperText: "Must be 8 characters and above ",
                              validator: (password) {
                                if (password.length < 8) {
                                  return ("Password Is too Short");
                                }
                              },
                              style: TextStyle(fontSize: 15),
                              onChanged: (final String text) {
                                _newPassword = text;
                                watchFormState();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is RequestingPasswordReset) {
                showOverlay(context, "Sending reset code");
              } else if (state is RequestError) {
                Navigator.pop(context);
                AppSnackBar().show(message: state.errorResponse.message);
              } else if (state is ResetCodeSent) {
                Navigator.pop(context);
                Navigator.pushNamed(context, Routes.newPassword);
              }
            },
            child: PrimaryButton(
                icon: Boxicons.bxs_chevron_right_circle,
                label: 'SEND CODE',
                onPressed: isButtonDisabled ? null : () => resetPassword()),
          ),
          SizedBox(
            height: 25.h,
          ),
        ],
      ),
    );
  }

  void watchFormState() {
    if (_otp.isEmpty || _newPassword.isEmpty) {
      setState(() => isButtonDisabled = true);
    } else {
      setState(() => isButtonDisabled = false);
    }
  }

  void gotoNextScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.navigationHost, (Route<dynamic> route) => false);
  }

  void resetPassword() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _authBloc.add(SetNewPasswordEvent(newPassword: _newPassword, otp: _otp));
    } else {
      AppSnackBar().show(message: AppStringConstants.formError);
    }
  }
}
