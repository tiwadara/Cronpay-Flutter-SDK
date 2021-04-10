import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Header extends StatelessWidget {
  final String title;
  final Widget next;
  final Widget previous;

  Header({this.title, this.next, this.previous});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double headerHeight = 55.h;
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Container(
        height: statusBarHeight + headerHeight,
        color: AppColors.accentDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: headerHeight,
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: previous != null
                              ? previous
                              : IconButton(
                                  icon: Icon(
                                    FeatherIcons.arrowLeft,
                                    color: AppColors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 40.h,
                            child: Center(
                              child: Text(
                                title ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 24),
                              ),
                            ),
                          )),
                      Align(
                          alignment: Alignment.centerRight,
                          child: next == null ? Container() : next),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
