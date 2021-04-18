import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/models/bank.dart';
import 'package:cron_pay/src/commons/widgets/app_spinner.dart';
import 'package:cron_pay/src/payment/blocs/directdebit/direct_debit_bloc.dart';
import 'package:cron_pay/src/payment/widgets/step_bank_details.dart';
import 'package:cron_pay/src/payment/widgets/step_mandate_created.dart';
import 'package:cron_pay/src/payment/widgets/step_sign_document.dart';
import 'package:cron_pay/src/payment/widgets/timeline.dart';
import 'package:cron_pay/src/profile/blocs/bank/bank_bloc.dart';
import 'package:cron_pay/src/sdk/blocs/splash/bloc.dart';
import 'package:cron_pay/src/sdk/model/mandate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DirectDeposit extends StatefulWidget {
  final Mandate mandate;
  const DirectDeposit(this.mandate, {Key key}) : super(key: key);

  @override
  _DirectDepositState createState() => _DirectDepositState();
}

class _DirectDepositState extends State<DirectDeposit> {
  BankBloc _bankBloc;
  SDKBloc _sdkBloc;
  double totalAmount;
  bool isButtonDisabled = true;
  bool isVerified = false;
  String cardRef;
  bool saveCard = false;
  final _formKey = GlobalKey<FormState>();
  var isSelected = [true, true];
  List<Bank> banks = [];
  AppDropDown2Item _selectedBank;
  var _accountNumber;
  double _maxAmount;
  List<AppDropDown2Item> _banksDropDownList = [];
  TextEditingController dateTextController = TextEditingController();
  TextEditingController endDateTextController = TextEditingController();
  final MoneyMaskedTextController _moneyMaskedTextController =
      new MoneyMaskedTextController(
          decimalSeparator: ".", initialValue: 0.00, thousandSeparator: ",");
  final stageOne = 1;
  final stageTwo = 2;
  final stageThree = 3;
  int _stage;

  @override
  void initState() {
    _bankBloc = BlocProvider.of<BankBloc>(context);
    _sdkBloc = BlocProvider.of<SDKBloc>(context);
    _bankBloc.add(GetBanksEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            BlocBuilder<DirectDebitBloc, DirectDepositState>(
                buildWhen: (previous, current) =>
                    current is SigningState ||
                    current is MandateInitiated ||
                    current is Restarted,
                builder: (context, state) {
                  if (state is SigningState) {
                    _stage = stageTwo;
                  } else if (state is MandateInitiated) {
                    _stage = stageThree;
                  } else if (state is Restarted) {
                    _stage = stageOne;
                  }
                  return Timeline(_stage);
                }),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<DirectDebitBloc, DirectDepositState>(
                buildWhen: (previous, current) =>
                    current is SigningState ||
                    current is MandateInitiated ||
                    current is Restarted,
                builder: (context, state) {
                  if (state is SigningState) {
                    widget.mandate.accountNumber = state.accountNumber;
                    widget.mandate.amount = state.maxAmount.toInt();
                    widget.mandate.bankId = state.bank.id.toString();
                    return StepSignDocument(
                      mandate: widget.mandate,
                      bank: state.bank,
                      accountName: state.name,
                    );
                  } else if (state is MandateInitiated) {
                    _sdkBloc.add(SendSuccessCallBackToPlatform());
                    return StepMandateCreated();
                  } else if (state is Restarted) {
                    return StepBankDetails();
                  }
                  return StepBankDetails();
                }),
          ],
        ),
      ),
    );
  }

  void watchFormState() {
    if (_maxAmount == null ||
        _selectedBank.code == null ||
        _accountNumber == null ||
        !isVerified) {
      setState(() => isButtonDisabled = true);
    } else {
      setState(() => isButtonDisabled = false);
    }
  }
}
