import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class _LoadingPage extends ModalRoute<void> {
  final String message;

  _LoadingPage({this.message});

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => AppColors.white.withOpacity(0.7);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.canvas,
      // make sure that the overlay content is not cut off
      child:  SafeArea(
          child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return LoaderInPage(message: message);
  }

  // @override
  // Widget buildTransitions(BuildContext context, Animation<double> animation,
  //     Animation<double> secondaryAnimation, Widget child) {
  //   // You can add your own animations for the overlay content
  //   return FadeTransition(
  //     opacity: animation,
  //     child: ScaleTransition(
  //       scale: animation,
  //       child: child,
  //     ),
  //   );
  // }
}

class LoaderInPage extends StatelessWidget {

  LoaderInPage({this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 80,
                height: 80,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryDark),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Wait a moment,  \n ${message ??  "processing..."}",
              style: TextStyle(
                color: AppColors.mainBlack,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 12,
            ),
            // Text(
            //   message,
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     color: AppColors.primary,
            //     fontSize: 10,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

void showOverlay(final BuildContext context, [final String message]) {
  Navigator.of(context).push(_LoadingPage(message: message));
}

void showAlertMessage(final BuildContext context, final String message) {
  ScreenUtil.init(context,
      designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
      allowFontScaling: false);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Oops!')),
          content: SizedBox(
            height: 150.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // FlatButton(
                      //     child: Text('Yes'),
                      //     onPressed: () {
                      //       Navigator.of(context).pop();
                      //     }),
                      FlatButton(
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          })
                    ])
              ],
            ),
          ),
        );
      });
}
