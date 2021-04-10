import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/asset_constants.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/util/clipper.dart';
import 'package:cron_pay/src/commons/widgets/primary_button.dart';
import 'package:cron_pay/src/home/blocs/home/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';
  Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.accentDark,
                              AppColors.primaryDark
                            ])),
                  ),
                  clipper: BottomWaveClipper(),
                ),
                Center(
                    child: Image(
                  height: 100,
                  width: 100,
                  image: AssetImage(Assets.logo),
                )),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Welcome to Cronpay",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: AppColors.textColor),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Image(
                      image: AssetImage(Assets.calendar),
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "There are currently no scheduled payments,\nClick here to schedule a new payment",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15,  color: AppColors.textColor,),
                ),
                SizedBox(
                  height: 40.h,
                ),
                PrimaryButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.signUp),
                  label: 'CREATE PAYMENT EVENT',
                ),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
            ClipPath(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      AppColors.primary,
                      AppColors.primaryMid,
                    ])),
              ),
              clipper: TopWaveClipper(),
            ),
          ],
        ));
  }
}
