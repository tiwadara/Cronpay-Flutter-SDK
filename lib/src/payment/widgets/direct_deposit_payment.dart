import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/app_strings.dart';
import 'package:cron_pay/src/commons/models/bank.dart';
import 'package:cron_pay/src/commons/widgets/app_snackbar.dart';
import 'package:cron_pay/src/commons/widgets/app_spinner.dart';
import 'package:cron_pay/src/payment/blocs/directdebit/direct_debit_bloc.dart';
import 'package:cron_pay/src/payment/blocs/payment/payment_bloc.dart';
import 'package:cron_pay/src/payment/widgets/step_bank_details.dart';
import 'package:cron_pay/src/payment/widgets/step_mandate_created.dart';
import 'package:cron_pay/src/payment/widgets/step_sign_document.dart';
import 'package:cron_pay/src/payment/widgets/timeline.dart';
import 'package:cron_pay/src/profile/blocs/bank/bank_bloc.dart';
import 'package:cron_pay/src/profile/blocs/profile/profile_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DirectDeposit extends StatefulWidget {
  const DirectDeposit({Key key}) : super(key: key);

  @override
  _DirectDepositState createState() => _DirectDepositState();
}

class _DirectDepositState extends State<DirectDeposit> {
  DirectDebitBloc _directDepositBloc;
  BankBloc _bankBloc;
  ProfileBloc _profileBloc;
  PaymentBloc _paymentBloc;
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
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
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
                  } else  if (state is MandateInitiated) {
                    _stage = stageThree;
                  }else  if (state is Restarted) {
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
                    return StepSignDocument(
                      maxAmount: state.maxAmount,
                      accountNumber: state.accountNumber,
                      bank: state.bank,
                      accountName: state.name,
                    );
                  }else if (state is MandateInitiated) {
                    return StepMandateCreated();
                  }else if (state is Restarted) {
                    _paymentBloc.add(GetSavedPaymentMethods());
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
