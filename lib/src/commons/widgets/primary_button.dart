import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PrimaryButton extends StatefulWidget {
  const PrimaryButton(
      {Key key,
      this.icon,
      @required this.label,
      this.width,this.color,
      @required this.onPressed, })
      : super(key: key);

  final double width;
  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final Color color;

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight), allowFontScaling: false);
    return SizedBox(
      height: 46.h,
      width: widget.width ?? 330.w,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
        color: widget.color ?? AppColors.accentDark,
        onPressed: widget.onPressed,
        textColor: Colors.white,
        child: new Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Align(
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
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
