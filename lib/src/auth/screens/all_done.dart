import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/asset_constants.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/widgets/primary_button.dart';
import 'package:cron_pay/src/home/blocs/home/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllDone extends StatefulWidget {
  static const String routeName = '/allDone';
  AllDone();

  @override
  _AllDoneState createState() => _AllDoneState();
}

class _AllDoneState extends State<AllDone> {
  final attributeValueTextController = TextEditingController();
  HomeBloc walletBloc;

  @override
  void initState() {
    walletBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
        backgroundColor: AppColors.windowColor,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.accentDark,
                        AppColors.primaryMid,
                        AppColors.white
                      ])),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Center(
                  child: Image(
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
                image: AssetImage(Assets.successRocket),
              )),
            ),
            Positioned(
              left: 25,
              right: 25,
              bottom: 73.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "All done!",
                    style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor),
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  Text(
                    "Thanks for confirming your email. \nLet’s add some information to your profile",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 15.sp, color: AppColors.textColor),
                  ),
                  SizedBox(
                    height: 44.h,
                  ),
                  PrimaryButton(
                      icon: FeatherIcons.chevronRight,
                      label: 'COMPLETE MY PROFILE',
                      onPressed: () {}),
                  SizedBox(
                    height: 29.h,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.home);
                      },
                      child: Text(
                        "NOT NOW",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
