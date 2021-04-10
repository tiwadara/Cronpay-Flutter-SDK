import 'dart:convert';

import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_strings.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/models/bank.dart';
import 'package:cron_pay/src/commons/util/strings.dart';
import 'package:cron_pay/src/commons/widgets/app_loader.dart';
import 'package:cron_pay/src/commons/widgets/app_snackbar.dart';
import 'package:cron_pay/src/commons/widgets/primary_button.dart';
import 'package:cron_pay/src/payment/blocs/directdebit/direct_debit_bloc.dart';
import 'package:cron_pay/src/payment/models/payment_method.dart';
import 'package:cron_pay/src/profile/blocs/bank/bank_bloc.dart';
import 'package:cron_pay/src/profile/blocs/profile/profile_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StepSignDocument extends StatefulWidget {
  final double maxAmount;
  final String accountNumber;
  final Bank bank;
  final String accountName;

  const StepSignDocument(
      {this.maxAmount,
      this.accountName,
      this.bank,
      this.accountNumber,
      Key key})
      : super(key: key);

  @override
  _StepSignDocumentState createState() => _StepSignDocumentState();
}

class _StepSignDocumentState extends State<StepSignDocument> {
  DirectDebitBloc _directDepositBloc;
  BankBloc _bankBloc;
  ProfileBloc _profileBloc;
  User _user;
  bool _inProgress = false;
  double totalAmount;
  bool isButtonDisabled = true;
  String cardRef;
  bool saveCard = false;
  final _formKey = GlobalKey<FormState>();
  List<PaymentMethod> _paymentMethods = [];
  var isSelected = [true, true];
  String _signature;

  @override
  void initState() {
    _directDepositBloc = BlocProvider.of<DirectDebitBloc>(context);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _bankBloc = BlocProvider.of<BankBloc>(context);
    _profileBloc.add(GetUserProfile());
    _directDepositBloc.add(GetPaymentMethod());
    _bankBloc.add(GetBanksEvent());
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
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Dear ",
                      style: TextStyle(color: AppColors.textColor)),
                  TextSpan(
                      text: "${camelize(widget.accountName ?? "")}, \n",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                          height: 2)),
                  TextSpan(
                      text:
                          "We are creating a direct debit authorisation Request "
                          "on your behalf for your account with details below : \n"
                          "Account Number : ${widget.accountNumber} \n"
                          "Bank : ${widget.bank.name} \n"
                          "Maximum Debit Amount : ${NumberFormat.currency(name: "NGN ").format(widget.maxAmount)}",
                      style: TextStyle(color: AppColors.textColor, height: 2))
                ])),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.signaturePad)
                        .then((data) {
                      _signature = base64Encode(data);
                      watchFormState();
                    });
                  },
                  child: DottedBorder(
                    dashPattern: [4, 3],
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12),
                    color: AppColors.borderGrey,
                    child: _signature != null
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            height: 100,
                            child: Center(
                                child: Image.memory(base64Decode(_signature))))
                        : Container(
                            height: 100,
                            child: Center(
                                child: Text(
                              'Tap To Sign',
                              style: TextStyle(color: AppColors.grey),
                            ))),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                MultiBlocListener(
                  listeners: [
                    BlocListener<DirectDebitBloc, DirectDepositState>(
                      listener: (dynamic context, state) {
                        if (state is PaymentMethodReceived) {
                          _paymentMethods = state.paymentMethods;
                        } else if (state is MandateInitiated) {
                          AppSnackBar().show(message: state.message);
                          Navigator.pop(context);
                        } else if (state is SendingReference) {
                          showOverlay(context, "Creating Mandate");
                        } else if (state is DirectDebitFailed) {
                          AppSnackBar().show(message: state.error);
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
                      label: 'PROCEED',
                      color: AppColors.accentDark,
                      onPressed: isButtonDisabled
                          ? null
                          : () {
                              makeDirectPayment();
                            }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void watchFormState() {
    if (widget.maxAmount == null ||
        widget.bank == null ||
        widget.accountNumber == null ||
        _signature == null) {
      setState(() => isButtonDisabled = true);
    } else {
      setState(() => isButtonDisabled = false);
    }
  }

  makeDirectPayment() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_paymentMethods[1].toJson().toString());
      _directDepositBloc.add(AddDirectDebit(
          widget.bank.id.toString(),
          widget.accountNumber,
          widget.maxAmount,
          _signature,
          _paymentMethods[1]));
    } else {
      AppSnackBar().show(message: AppStringConstants.formError);
    }
  }
}
