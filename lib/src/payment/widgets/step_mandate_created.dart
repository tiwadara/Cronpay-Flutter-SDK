import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/models/bank.dart';
import 'package:cron_pay/src/commons/widgets/primary_button.dart';
import 'package:cron_pay/src/payment/blocs/directdebit/direct_debit_bloc.dart';
import 'package:cron_pay/src/profile/blocs/bank/bank_bloc.dart';
import 'package:cron_pay/src/profile/blocs/profile/profile_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class StepMandateCreated extends StatefulWidget {
  final double maxAmount;
  final String accountNumber;
  final Bank bank;
  final String accountName;

  const StepMandateCreated(
      {this.maxAmount,
      this.accountName,
      this.bank,
      this.accountNumber,
      Key key})
      : super(key: key);

  @override
  _StepMandateCreatedState createState() => _StepMandateCreatedState();
}

class _StepMandateCreatedState extends State<StepMandateCreated> {
  DirectDebitBloc _directDepositBloc;
  BankBloc _bankBloc;
  ProfileBloc _profileBloc;
  double totalAmount;
  String cardRef;
  bool saveCard = false;
  final _formKey = GlobalKey<FormState>();

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
                SizedBox(
                  height: 50,
                ),
                Icon(
                  FeatherIcons.checkCircle,
                  size: 80,
                  color: AppColors.primaryDark,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "THANK YOU",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "We have sent your request and you will be notified upon approval",
                  style: TextStyle(fontSize: 14, color: AppColors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                    label: 'CLOSE',
                    color: AppColors.accentDark,
                    onPressed: () {
                      restartDirectDeposit();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void restartDirectDeposit() {
    _directDepositBloc.add(RestartDirectDebit());
  }
}
