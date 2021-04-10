import 'package:cron_pay/src/auth/blocs/auth/auth_bloc.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/asset_constants.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/widgets/app_outline_button.dart';
import 'package:cron_pay/src/commons/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoutWidget extends StatefulWidget {
  const LogoutWidget({Key key}) : super(key: key);

  @override
  _LogoutWidgetState createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {
  AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.accentDark,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))
      ),
      height: 369.h,
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 104.h,
            child: Image(
              image: AssetImage(Assets.questionMark),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Are you sure you want to log out?",
            style: TextStyle(color: AppColors.white),
          ),
          SizedBox(
            height: 20.h,
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (dynamic context, state) {
              if (state is LogoutSuccessful) {
                return Navigator.pushNamedAndRemoveUntil(
                    context, Routes.signIn, (Route<dynamic> route) => false);
              }
            },
            child: PrimaryButton(
                label: 'SIGN OUT',
                color: AppColors.primaryDark,
                onPressed: () {
                  signOut();
                }),
          ),
          SizedBox(
            height: 20.h,
          ),
          AppOutlineButton(
              label: 'CANCEL',
              outlineColor: AppColors.white,
              onPressed: () {
                Navigator.pop(context);
              }),
          SizedBox(
            height: 25.h,
          ),
        ],
      ),
    );
  }

  signOut() {
    _authBloc.add(LogoutRequestEvent());
  }
}
