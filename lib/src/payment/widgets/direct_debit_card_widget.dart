import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/payment/models/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DirectDebitCardWidget extends StatefulWidget {
  final PaymentMethod paymentMethod;
  final User user;
  const DirectDebitCardWidget(
    this.paymentMethod,
    this.user, {
    Key key,
  }) : super(key: key);

  @override
  _DirectDebitCardWidgetState createState() => _DirectDebitCardWidgetState();
}

class _DirectDebitCardWidgetState extends State<DirectDebitCardWidget> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border(),
        color: AppColors.grey,
        // gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [AppColors.accentDark, AppColors.primaryLighter])
      ),
      child: Row(
        children: [
          SizedBox(
            width: 25,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              child: Icon(
                Boxicons.bxs_bank,
                size: 40,
                color: AppColors.white,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 300.w,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  "${widget.paymentMethod.meta.accountNumber}",
                  style: TextStyle(
                      fontSize: 10,
                      wordSpacing: 10,
                      letterSpacing: 5,
                      color: AppColors.white,
                      fontFamily: "Proxima"),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 300.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account Owner",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          "${widget.user.firstName + " " + widget.user.lastName}"
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          "${widget.paymentMethod.meta.status}",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ])
        ],
      ),
    );
  }
}
