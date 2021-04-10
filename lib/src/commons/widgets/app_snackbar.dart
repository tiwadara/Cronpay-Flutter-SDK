import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppSnackBar {
   show( {String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: AppColors.accentDark,
        textColor: Colors.white,
        fontSize: 16.0
    );
    // showSimpleNotification(
    //   Container(child: Text(message, style:  TextStyle(fontWeight: FontWeight.bold),)),
    //   subtitle:  Container(child: Text(message)),
    //   position: NotificationPosition.top,
    //   contentPadding:  EdgeInsets.all( 10),
    //   slideDismiss: true,
    //   duration: Duration(seconds: 5),
    //   background: AppColors.primary,
    // );

  }
}
