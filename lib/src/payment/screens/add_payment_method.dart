import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/widgets/app_button_tab.dart';
import 'package:cron_pay/src/commons/widgets/app_header.dart';
import 'package:cron_pay/src/payment/blocs/payment/payment_bloc.dart';
import 'package:cron_pay/src/payment/widgets/card_payment.dart';
import 'package:cron_pay/src/payment/widgets/direct_deposit_payment.dart';
import 'package:cron_pay/src/profile/blocs/profile/profile_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPaymentMethod extends StatefulWidget {
  static const String routeName = '/addPaymentMethod';
  AddPaymentMethod();

  @override
  _AddPaymentMethodState createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  final attributeValueTextController = TextEditingController();
  PaymentBloc _paymentBloc;
  ProfileBloc _profileBloc;
  var tab = 1;
  var firstTabId = 1;
  var secondTabId = 2;

  @override
  void initState() {
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
    _paymentBloc.add(GetSavedPaymentMethods());
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(GetUserProfile());
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
            Header(
                previous: Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      FeatherIcons.arrowLeft,
                      color: AppColors.white,
                    ),
                  ),
                ),
                title: "Add Payment Method"),
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              shrinkWrap: true,
              children: [
                // SizedBox(height: 10.h),
                // Text(
                //   "Select a Payment Method ",
                //   style: TextStyle(
                //       fontSize: 20,
                //       color: AppColors.textColor,
                //       fontWeight: FontWeight.bold),
                // ),
                SizedBox(
                  height: 15.h,
                ),
                ButtonTab((groupValue) {
                  print(groupValue);
                  setState(() {
                    tab = groupValue;
                  });
                }),
                // if (tab == firstTabId)
                //   // DirectDeposit()
                // else if (tab == secondTabId)
                //   CardPayment()
              ],
            ),
          ],
        ));
  }
}
