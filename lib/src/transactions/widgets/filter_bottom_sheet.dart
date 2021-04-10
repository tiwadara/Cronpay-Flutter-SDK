import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_strings.dart';
import 'package:cron_pay/src/commons/util/credit_card.dart';
import 'package:cron_pay/src/commons/util/credit_card_formatter.dart';
import 'package:cron_pay/src/commons/widgets/app_loader.dart';
import 'package:cron_pay/src/commons/widgets/app_outline_button.dart';
import 'package:cron_pay/src/commons/widgets/app_snackbar.dart';
import 'package:cron_pay/src/commons/widgets/app_text_input_blue.dart';
import 'package:cron_pay/src/commons/widgets/primary_button.dart';
import 'package:cron_pay/src/payment/blocs/payment/payment_bloc.dart';
import 'package:cron_pay/src/payment/models/payment_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key key}) : super(key: key);

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  double totalAmount;
  var isButtonDisabled = true;
  String cardRef;
  bool saveCard = false;
  final _formKey = GlobalKey<FormState>();
  List<PaymentMethod> _paymentMethods = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      decoration: BoxDecoration(
          color: AppColors.accentDark,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      height: 447.h,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Filter Transactions",
              style: TextStyle(
                  fontSize: 20,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "You can only search withing an interval of 3 months",
              style: TextStyle(
                  fontSize: 12,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30.h,
            ),
            AppTextInputBlue(
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(19),
                new CardNumberInputFormatter()
              ],
              keyboardType: TextInputType.number,
              icon: FeatherIcons.calendar,
              validator: CardUtils.validateCardNum,
              labelText: "Start Date",
              // onSaved: (String value) => _cardNumber = value,
              onChanged: (text) {},
            ),
            AppTextInputBlue(
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(19),
                new CardNumberInputFormatter()
              ],
              keyboardType: TextInputType.number,
              icon: FeatherIcons.calendar,
              validator: CardUtils.validateCardNum,
              labelText: "End Date",
              // onSaved: (String value) => _cardNumber = value,
              onChanged: (text) {},
            ),
            SizedBox(
              height: 20.h,
            ),
            MultiBlocListener(
              listeners: [
                BlocListener<PaymentBloc, PaymentState>(
                  listener: (dynamic context, state) {
                    if (state is PaymentMethodReceived) {
                      _paymentMethods = state.paymentMethods;
                      // PaystackPlugin.initialize(
                      //     publicKey: _paymentMethods[0].meta.publicKey);
                    } else if (state is CardAddedSuccessfully) {
                      AppSnackBar().show(message: state.message);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else if (state is SendingReference) {
                      showOverlay(context, "Verifying Card");
                    } else if (state is CardFailed) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
              child: PrimaryButton(
                  label: 'SEARCH',
                  color: AppColors.primaryDark,
                  onPressed: () {
                    addPaymentCard();
                  }),
            ),
            SizedBox(
              height: 20.h,
            ),
            AppOutlineButton(
                label: 'CANCEL',
                outlineColor: AppColors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  addPaymentCard() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    } else {
      AppSnackBar().show(message: AppStringConstants.formError);
    }
  }
}
