import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/app_strings.dart';
import 'package:cron_pay/src/commons/constants/asset_constants.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/widgets/app_header.dart';
import 'package:cron_pay/src/commons/widgets/primary_button.dart';
import 'package:cron_pay/src/payment/blocs/payment/payment_bloc.dart';
import 'package:cron_pay/src/payment/models/payment_method.dart';
import 'package:cron_pay/src/payment/widgets/credit_card_widget.dart';
import 'package:cron_pay/src/payment/widgets/direct_debit_card_widget.dart';
import 'package:cron_pay/src/profile/blocs/profile/profile_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethods extends StatefulWidget {
  static const String routeName = '/paymentMethods';
  PaymentMethods();

  @override
  _PaymentMethodsState createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  final attributeValueTextController = TextEditingController();
  PaymentBloc _paymentBloc;
  ProfileBloc _profileBloc;
  User _user;
  List<PaymentMethod> paymentMethods;

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
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is UserProfileReceived) {
            _user = state.user;
          }
          return Column(
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
                  title: "Payment Methods"),
              BlocBuilder<PaymentBloc, PaymentState>(
                  buildWhen: (previous, current) =>
                      current is SavedCardsReceived,
                  builder: (context, state) {
                    if (state is SavedCardsReceived) {
                      if (state.paymentMethods.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Image(
                                    image: AssetImage(Assets.card),
                                  )),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "My Debit Cards",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                    color: AppColors.textColor),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "Securely and safely manage all the debit cards \nconnected to your cronPay account here.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        paymentMethods = state.paymentMethods;
                        return Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: paymentMethods.length,
                              itemBuilder: (context, position) {
                                var paymentWidget;
                                if (paymentMethods[position].id ==
                                    AppStringConstants.payStackId) {
                                  paymentWidget = CreditCardWidget(
                                      paymentMethods[position], _user);
                                } else if (paymentMethods[position].id ==
                                    AppStringConstants.CMMSId) {
                                  paymentWidget = DirectDebitCardWidget(
                                      paymentMethods[position], _user);
                                }
                                return paymentWidget;
                              }),
                        );
                      }
                    }
                    return Expanded(
                      child: Container(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }),
              SizedBox(
                height: 30.h,
              ),
              PrimaryButton(
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.addPayment),
                label: 'ADD PAYMENT METHOD',
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          );
        }));
  }
}
