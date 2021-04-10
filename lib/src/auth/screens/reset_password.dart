import 'package:cron_pay/src/auth/blocs/auth/auth_bloc.dart';
import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/app_strings.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/widgets/app_header.dart';
import 'package:cron_pay/src/commons/widgets/app_loader.dart';
import 'package:cron_pay/src/commons/widgets/app_snackbar.dart';
import 'package:cron_pay/src/commons/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ResetPassword extends StatefulWidget {
  static const String routeName = '/resetPassword';

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  var isButtonDisabled = true;
  AuthBloc _authBloc;
  User user = User();

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
            title: "Password Reset",
            next: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text("Login",
                    style: TextStyle(color: AppColors.white, fontSize: 16))),
          ),
          SizedBox(
            height: 25.h,
          ),
          Text(
            'Cronpay will send a one-time code to verify \nyour email address',
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 25.h,
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.perm_identity)),
                          Expanded(
                            child: TextField(
                                onChanged: (final String text) {
                                  user.email = text;
                                  watchFormState();
                                },
                                style: TextStyle(fontSize: 15),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    hintText: 'Input your email address',
                                    border: InputBorder.none,
                                    labelText: 'EMAIL')),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          SizedBox(
            height: 25.h,
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
               gotoNextScreen();
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
    if (user.email.isEmpty) {
      setState(() => isButtonDisabled = true);
    } else {
      setState(() => isButtonDisabled = false);
    }
  }

  void gotoNextScreen() {
    Navigator.pushReplacementNamed(context, Routes.newPassword,  arguments: user);
  }

  void resetPassword() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _authBloc.add(RequestPasswordResetEvent(user));
    } else {
      AppSnackBar().show(message: AppStringConstants.formError);
    }
  }
}
