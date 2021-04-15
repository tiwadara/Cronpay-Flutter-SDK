import 'package:cron_pay/src/auth/blocs/auth/auth_bloc.dart';
import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/auth/screens/verification.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
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
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthBloc _authBloc;
  ProfileBloc _profileBloc;
  BankBloc _bankBloc;
  User user = User();
  final _formKey = GlobalKey<FormState>();
  var isButtonDisabled = true;
  //
  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: <String>[
  //     'email',
  //   ],
  // );

  @override
  void initState() {
    super.initState();
    // _googleSignIn.signOut();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _bankBloc = BlocProvider.of<BankBloc>(context);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
    //   _authBloc.add(SignUpWithGoogleEvent(account));
    // });
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
            title: "Sign up",
            next: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.signIn);
                },
                child: Text("Login",
                    style: TextStyle(color: AppColors.white, fontSize: 16))),
          ),
          SizedBox(
            height: 25.h,
          ),
          Text(
            'Cronpay will send a one-time code to verify \nyour email address',
            style: TextStyle(fontSize: 15.sp),
            textAlign: TextAlign.center,
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
                                FeatherIcons.user,
                                color: AppColors.grey,
                              )),
                          Expanded(
                              child: TextFormField(
                                  onChanged: (final String text) {
                                    user.firstName = text;
                                    watchFormState();
                                  },
                                  style: TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelStyle:
                                          TextStyle(color: AppColors.grey),
                                      labelText: 'FIRST NAME'))),
                          Expanded(
                              child: TextField(
                                  onChanged: (final String text) {
                                    user.lastName = text;
                                    watchFormState();
                                  },
                                  style: TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    labelText: 'LAST NAME',
                                    border: InputBorder.none,
                                    labelStyle:
                                        TextStyle(color: AppColors.grey),
                                  ))),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.mail_outline,
                                color: AppColors.grey,
                              )),
                          Expanded(
                            child: TextFormField(
                                validator: (email) =>
                                    EmailValidator.validate(email)
                                        ? null
                                        : "Invalid email address",
                                onChanged: (final String text) {
                                  user.email = text;
                                  watchFormState();
                                },
                                style: TextStyle(fontSize: 15),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelStyle:
                                        TextStyle(color: AppColors.grey),
                                    labelText: 'EMAIL')),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.lock_outline,
                                  color: AppColors.grey)),
                          Expanded(
                            child: PasswordTextInput(
                              // helperText: "Must be 8 characters and above ",
                              validator: (password) {
                                if (password.length < 8) {
                                  return ("Password Is too Short");
                                }
                              },
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
            height: 25.h,
          ),
          MultiBlocListener(
            listeners: [
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is OTPSuccessful) {
                    Navigator.pop(context);
                    showOverlay(context, "Sending Verification code");
                    Future.delayed(Duration(seconds: 3), () {
                      Navigator.pop(context);
                      gotoNextScreen();
                    });
                  }
                  // if (state is SigUpWithGoogleSuccessful) {
                  //   Navigator.pop(context);
                  //     showOverlay(context, "Creating User Account");
                  //     _authBloc.add(LoginWithGoogleEvent(state.user));
                  // }
                  else if (state is SigningUp) {
                    showOverlay(context, "Verifying Email");
                  } else if (state is LoginSuccessful) {
                    Navigator.pop(context);
                    showOverlay(context, "Signing you in");
                    _profileBloc.add(GetUserProfile());
                    _bankBloc.add(GetBanksEvent());
                  }
                  // else if (state is RequestError) {
                  //   _googleSignIn.signOut();
                  //   Navigator.pop(context);
                  //   AppSnackBar().show(message: state.errorResponse.message);
                  // }
                  else if (state is RequestingOTP) {
                    showOverlay(context, "Signing you up");
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
                icon: FeatherIcons.chevronRight,
                label: 'SIGN UP',
                onPressed: isButtonDisabled ? null : () => signUp()),
          ),
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: AppHorizontalLine()),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  "OR SIGN UP USING",
                  style: TextStyle(color: AppColors.accentDark),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(child: AppHorizontalLine()),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          AppOutlineButton(
              leading: Boxicons.bxl_google,
              label: 'SIGN UP WITH GOOGLE',
              onPressed: () {
                _handleGoogleSignIn();
              }),
          SizedBox(
            height: 20.h,
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
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, Routes.home),
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                  Text(" & ",
                      style: TextStyle(
                        fontSize: 14,
                      )),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, Routes.home),
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
            height: 20.h,
          ),
        ],
      ),
    );
  }

  void watchFormState() {
    if (user.checkIfAnyIsNull()) {
      setState(() => isButtonDisabled = true);
    } else {
      setState(() => isButtonDisabled = false);
    }
  }

  void gotoNextScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return Verification(user);
      }),
    );
  }

  void signUp() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _authBloc.add(RequestOTP(user));
    } else {
      AppSnackBar().show(message: "Please, correct invalid fields");
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
