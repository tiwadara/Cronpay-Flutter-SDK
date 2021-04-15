import 'package:cron_pay/src/auth/blocs/auth/auth_bloc.dart';
import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/app_strings.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/widgets/app_header.dart';
import 'package:cron_pay/src/commons/widgets/app_horizontal_line.dart';
import 'package:cron_pay/src/commons/widgets/app_loader.dart';
import 'package:cron_pay/src/commons/widgets/app_outline_button.dart';
import 'package:cron_pay/src/commons/widgets/app_password_text_input.dart';
import 'package:cron_pay/src/commons/widgets/app_snackbar.dart';
import 'package:cron_pay/src/commons/widgets/primary_button.dart';
import 'package:cron_pay/src/profile/blocs/bank/bank_bloc.dart';
import 'package:cron_pay/src/profile/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SignIn extends StatefulWidget {
  static const String routeName = '/signIn';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  var isButtonDisabled = true;
  AuthBloc _authBloc;
  ProfileBloc _profileBloc;
  BankBloc _bankBloc;
  User user = User();
  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: <String>[
  //     'email',
  //   ],
  // );

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _bankBloc = BlocProvider.of<BankBloc>(context);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    // _googleSignIn.signOut();
    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
    //   _authBloc.add(LoginWithGoogleEvent(account));
    // });

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
            previous: Container(),
            title: " " "Login",
            next: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.signUp);
                },
                child: Text("Sign up",
                    style: TextStyle(color: AppColors.white, fontSize: 16))),
          ),
          SizedBox(
            height: 40.h,
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
                                autofillHints: [AutofillHints.email],
                                style: TextStyle(fontSize: 15),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    hintText: 'Input your email address',
                                    border: InputBorder.none,
                                    labelText: 'EMAIL')),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.lock_outline)),
                          Expanded(
                            child: PasswordTextInput(
                              // helperText: "Must be 8 characters and above ",
                              validator: (password) {
                                if (password.length < 8) {
                                  return ("Password Is too Short");
                                }
                              },
                              autofillHints: [AutofillHints.password],
                              style: TextStyle(fontSize: 15),
                              onChanged: (final String text) {
                                user.password = text;
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
            height: 5.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                  onTap: () => Navigator.pushNamed(context, Routes.resetPassword),
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("Forgot your password? ", style: TextStyle(color: AppColors.primaryDark),))),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          MultiBlocListener(
            listeners: [
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LoginSuccessful) {
                    Navigator.pop(context);
                    showOverlay(context, "Preparing your home screen");
                    _profileBloc.add(GetUserProfile());
                    _bankBloc.add(GetBanksEvent());
                  } else if (state is RequestError) {
                    // _googleSignIn.signOut();
                    Navigator.pop(context);
                    AppSnackBar().show(message: state.errorResponse.message);
                  } else if (state is SigningIn) {
                    showOverlay(context, "Signing you in");
                  }
                },
              ),
              BlocListener<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state is UserProfileReceived) {
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.pop(context);
                      gotoNextScreen();
                    });
                  } else if (state is ErrorWithMessageState) {
                    Navigator.pop(context);
                    AppSnackBar().show(message: state.error);
                  }
                },
              ),
            ],
            child: PrimaryButton(
                icon: Boxicons.bxs_chevron_right_circle,
                label: 'SIGN IN',
                onPressed: isButtonDisabled ? null : () => signIn()),
          ),
          SizedBox(
            height: 25.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 100, child: AppHorizontalLine()),
              SizedBox(
                width: 20,
              ),
              Text(
                "OR SIGN IN USING",
                style: TextStyle(color: AppColors.accentDark),
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(width: 100, child: AppHorizontalLine()),
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          AppOutlineButton(
              leading: Boxicons.bxl_google,
              label: 'SIGN IN WITH GOOGLE',
              onPressed: () {
                _handleGoogleSignIn();
              }),
          SizedBox(
            height: 25.h,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "By clicking sign up, you agree to accept our",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.accentDark),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Text(" & ",
                      style: TextStyle(
                        fontSize: 14,
                      )),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/LoginScreen"),
                    child: Text(
                      "Terms of Service",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
        ],
      ),
    );
  }

  void watchFormState() {
    if (user.checkIfAnyLoginIsNull()) {
      setState(() => isButtonDisabled = true);
    } else {
      setState(() => isButtonDisabled = false);
    }
  }

  void gotoNextScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.navigationHost, (Route<dynamic> route) => false);
  }

  void signIn() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _authBloc.add(LogInEvent(user));
    } else {
      AppSnackBar().show(message: AppStringConstants.formError);
    }
  }

  void _handleGoogleSignIn() async {
    try {
      // _googleSignIn.signIn();
    } catch (error) {
      print("fghfgh" + error.toString());
    }
  }
}
