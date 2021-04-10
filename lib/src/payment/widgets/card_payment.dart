import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_strings.dart';
import 'package:cron_pay/src/commons/util/credit_card.dart';
import 'package:cron_pay/src/commons/util/credit_card_formatter.dart';
import 'package:cron_pay/src/commons/widgets/app_loader.dart';
import 'package:cron_pay/src/commons/widgets/app_snackbar.dart';
import 'package:cron_pay/src/commons/widgets/app_text_view.dart';
import 'package:cron_pay/src/commons/widgets/primary_button.dart';
import 'package:cron_pay/src/payment/blocs/payment/payment_bloc.dart';
import 'package:cron_pay/src/payment/models/payment_method.dart';
import 'package:cron_pay/src/profile/blocs/profile/profile_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardPayment extends StatefulWidget {
  const CardPayment({Key key}) : super(key: key);

  @override
  _CardPaymentState createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  PaymentBloc _paymentBloc;
  ProfileBloc _profileBloc;
  User _user;
  String _cardNumber;
  String _cvv;
  int _expiryMonth = 0;
  int _expiryYear = 0;
  bool _inProgress = false;
  double totalAmount;
  var isButtonDisabled = true;
  String cardRef;
  bool saveCard = false;
  final _formKey = GlobalKey<FormState>();
  List<PaymentMethod> _paymentMethods = [];
  var isSelected = [true, true];

  @override
  void initState() {
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(GetUserProfile());
    _paymentBloc.add(GetPaymentMethods());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.windowColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
            ),
            AppTextInput(
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(19),
                new CardNumberInputFormatter()
              ],
              keyboardType: TextInputType.number,
              icon: FeatherIcons.creditCard,
              validator: CardUtils.validateCardNum,
              labelText: "Card Number",
              onSaved: (String value) => _cardNumber = value,
              onChanged: (text) {},
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: AppTextInput(
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(4),
                      new CardMonthInputFormatter()
                    ],
                    keyboardType: TextInputType.number,
                    labelText: "Expiry",
                    onChanged: (text) {},
                    validator: CardUtils.validateDate,
                    onSaved: (value) {
                      List<int> expiryDate = CardUtils.getExpiryDate(value);
                      _expiryMonth = expiryDate[0];
                      _expiryYear = expiryDate[1];
                    },
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                    child: AppTextInput(
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    new LengthLimitingTextInputFormatter(4),
                  ],
                  keyboardType: TextInputType.number,
                  labelText: "CVV",
                  validator: CardUtils.validateCVV,
                  onSaved: (String value) => _cvv = value,
                  onChanged: (text) {},
                )),
                // SizedBox(
                //   width: 10.w,
                // ),
                // Expanded(
                //     child: AppTextInputBlue(
                //         keyboardType: TextInputType.text,
                //         labelText: "PIN",
                //         onChanged: (text) {},
                //         onSaved: (String value) =>
                //             _expiryMonth = int.tryParse(value))),
              ],
            ),
            SizedBox(
              height: 40.h,
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
                BlocListener<ProfileBloc, ProfileState>(
                  listener: (dynamic context, state) {
                    if (state is UserProfileReceived) {
                      _user = state.user;
                    }
                  },
                ),
              ],
              child: PrimaryButton(
                  label: 'ADD DEBIT CARD',
                  color: AppColors.accentDark,
                  onPressed: () {
                    addPaymentCard();
                  }),
            ),
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
      // _startAfreshCharge();
    } else {
      AppSnackBar().show(message: AppStringConstants.formError);
    }
  }

  // _startAfreshCharge() async {
  //   _formKey.currentState.save();
  //   setState(() => _inProgress = true);
  //   Charge charge = Charge();
  //   charge.card = _getCardFromUI();
  //   charge
  //     ..amount = 50
  //     ..email = _user.email
  //     ..accessCode = _paymentMethods[0].meta.accessCode
  //     ..putCustomField('Charged From', 'Cron Pay');
  //
  //   _chargeCard(charge);
  // }

  // _chargeCard(Charge charge) async {
  //   final response = await PaystackPlugin.chargeCard(context, charge: charge);
  //   if (response.status) {
  //     AppSnackBar().show(message: response.message);
  //     _paymentBloc.add(
  //         UpdatePaystackCheckoutEvent(_paymentMethods[0], response.reference));
  //     return;
  //   }
  //   if (response.verify) {
  //     AppSnackBar().show(message: response.message);
  //     _paymentBloc.add(
  //         UpdatePaystackCheckoutEvent(_paymentMethods[0], response.reference));
  //   } else {
  //     setState(() => _inProgress = false);
  //     AppSnackBar().show(message: response.message);
  //   }
  // }

  // PaymentCard _getCardFromUI() {
  //   return PaymentCard(
  //     number: _cardNumber,
  //     cvc: _cvv,
  //     expiryMonth: _expiryMonth,
  //     expiryYear: _expiryYear,
  //   );
  // }
}
