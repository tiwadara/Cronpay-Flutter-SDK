import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/widgets/app_header.dart';
import 'package:cron_pay/src/payment/widgets/direct_deposit_payment.dart';
import 'package:cron_pay/src/sdk/model/mandate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateMandate extends StatefulWidget {
  static const String routeName = '/createMandate';
  final Mandate mandate;
  CreateMandate(this.mandate);

  @override
  _CreateMandateState createState() => _CreateMandateState();
}

class _CreateMandateState extends State<CreateMandate> {
  final attributeValueTextController = TextEditingController();
  var tab = 1;
  var firstTabId = 1;
  var secondTabId = 2;
  Mandate _mandate;

  @override
  void initState() {
    _mandate = widget.mandate;
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
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Header(previous: Container(), title: "Create Mandate"),
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                DirectDeposit(_mandate)
              ],
            ),
          ],
        ));
  }
}
