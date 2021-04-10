import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/util/credit_card.dart';
import 'package:cron_pay/src/payment/models/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditCardWidget extends StatefulWidget {
  final PaymentMethod paymentMethod;
  final User user;
  const CreditCardWidget(
    this.paymentMethod,
    this.user, {
    Key key,
  }) : super(key: key);

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
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
          color: AppColors.primaryDark,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.accentDark, AppColors.primaryLighter])),
      child: Row(
        children: [
          SizedBox(
            width: 25,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              width: 70.w,
              child: CardUtils.getCardIcon2(widget.paymentMethod.meta.cardType),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 300.w,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  "${widget.paymentMethod.meta.cardFirstSixDigits.substring(0, 4) + " " + widget.paymentMethod.meta.cardFirstSixDigits.substring(4)}··  ···· ${widget.paymentMethod.meta.cardLastFourDigits}",
                  style: TextStyle(
                      fontSize: 20,
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
                          "Card Holder",
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
                          "Expires",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          "${widget.paymentMethod.meta.expiryMonth}/${widget.paymentMethod.meta.expiryYear}",
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
