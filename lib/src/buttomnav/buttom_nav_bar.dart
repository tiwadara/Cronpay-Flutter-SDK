import 'package:cron_pay/src/buttomnav/bloc/bottom_nav_cubit.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/events/screens/events.dart';
import 'package:cron_pay/src/profile/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = '/navigationHost';

  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  BottomNavCubit _bottomNavCubit;
  int currentIndex = 0;

  @override
  void initState() {
    _bottomNavCubit = BlocProvider.of<BottomNavCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      extendBody: true,
      body: BlocBuilder<BottomNavCubit, BottomNavState>(
          builder: (context, state) {
        if (state is HomeMenu) {
          currentIndex = 0;
          return Events();
        } else if (state is ProfileMenu) {
          currentIndex = 1;
          return Profile();
        }
        return Events();
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryDark,
        onPressed: () {
          Navigator.pushNamed(context, Routes.newEvent);
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: AppColors.white,
        ),
        elevation: 2.0,
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 15,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            height: 60.h,
            child: BlocBuilder<BottomNavCubit, BottomNavState>(
                builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      _bottomNavCubit.navigateHome();
                    },
                    child: Container(
                      width: 80.w,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Icon(
                            FeatherIcons.calendar,
                            color: currentIndex == 0
                                ? AppColors.primaryDark
                                : AppColors.grey,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Events",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: currentIndex == 0
                                  ? AppColors.primaryDark
                                  : AppColors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 100.w),
                  InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      _bottomNavCubit.navigateProfile();
                    },
                    child: Container(
                      width: 80.w,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Icon(
                            FeatherIcons.user,
                            color: currentIndex == 1
                                ? AppColors.primaryDark
                                : AppColors.grey,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Account",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: currentIndex == 1
                                  ? AppColors.primaryDark
                                  : AppColors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ), // T
                ],
              );
            })),
        shape: CircularNotchedRectangle(),
        color: Colors.white,
      ),

      // ),
    );
  }
}
