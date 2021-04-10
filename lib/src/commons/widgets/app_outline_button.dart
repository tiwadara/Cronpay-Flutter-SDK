import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AppOutlineButton extends StatefulWidget {
  const AppOutlineButton(
      {Key key,
        this.icon,
        @required this.label,
        this.width,
        @required this.onPressed, this.leading, this.outlineColor, })
      : super(key: key);

  final double width;
  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final IconData leading;
  final Color outlineColor;

  @override
  _AppOutlineButtonState createState() => _AppOutlineButtonState();
}

class _AppOutlineButtonState extends State<AppOutlineButton> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    return SizedBox(
      height: 46.h,
      width: widget.width ?? 330.w,
      child: FlatButton(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: widget.outlineColor ?? AppColors.accentDark, width: 2.0),
        ),
        color: Colors.transparent,
        onPressed: widget.onPressed,
        textColor:  widget.outlineColor ?? AppColors.accentDark,
        child: new Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Align(
              child: Row(
                 mainAxisAlignment : MainAxisAlignment.center,
                children: [
                  widget.leading == null ? Container() : Icon(widget.leading, size: 30,),
                  SizedBox(width: 5,),
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              alignment: Alignment.center,
            ),
//          _isLoading
//              ? Align(
//                  child: CircularProgressIndicator(),
//                  alignment: Alignment.centerRight,
//                )
//              :
            Align(
              child: Icon(widget.icon, size: 35,),
              alignment: Alignment.centerRight,
            ),
          ],
        ),
      ),
    );
  }
}
