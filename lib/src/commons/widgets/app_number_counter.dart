import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCounter extends StatefulWidget {
  final Function onChanged;
  final Function onTap;
  final String hintText;
  final String labelText;
  final FocusNode focusNode;
  final bool enabled;

  const AppCounter({
    Key key,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.focusNode,
    this.onTap,
    this.enabled,
  }) : super(key: key);

  @override
  _AppCounterState createState() => _AppCounterState();
}

class _AppCounterState extends State<AppCounter> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    return Container(
      // width: 50,
      height: 55.h,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: AppColors.shadow,
                blurRadius: 15.0,
                offset: Offset(0, 8)),
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
          children: [
        SizedBox(
          width: 50.w,
          child: Center(
            child: Text(
              count.toString(),
              style: TextStyle(fontSize: 15, color: AppColors.textColor),
            ),
          ),
        ),
        Column(children: [
          Expanded(
            child: InkWell(
              onTap: () {
                count++;
                widget.onChanged(count);
                setState(() {});
              },
              child: Container(
                alignment: Alignment(0, 0),
                width: 25.w,
                decoration: BoxDecoration(
                  color: AppColors.accentDark,
                  borderRadius:
                  BorderRadius.only(topRight: Radius.circular(10)),
                  border: Border.all(color: AppColors.white, width: 1),
                ),
                child: Text(
                  "+",
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (count > 1) count--;
                widget.onChanged(count);
              },
              child: Container(
                alignment: Alignment(0, 0),
                width: 25.w,
                decoration: BoxDecoration(
                  color: AppColors.accentDark,
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(10)),
                  border: Border.all(color: AppColors.white, width: 1),
                ),
                child: Text(
                  "-",
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ),
        ])
      ]),
    );
  }
}
