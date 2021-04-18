import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_strings.dart';
import 'package:cron_pay/src/commons/models/bank.dart';
import 'package:cron_pay/src/commons/widgets/app_snackbar.dart';
import 'package:cron_pay/src/commons/widgets/app_spinner.dart';
import 'package:cron_pay/src/commons/widgets/app_text_view.dart';
import 'package:cron_pay/src/commons/widgets/primary_button.dart';
import 'package:cron_pay/src/payment/blocs/directdebit/direct_debit_bloc.dart';
import 'package:cron_pay/src/profile/blocs/bank/bank_bloc.dart';
import 'package:cron_pay/src/profile/blocs/profile/profile_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepBankDetails extends StatefulWidget {
  const StepBankDetails({Key key}) : super(key: key);

  @override
  _StepBankDetailsState createState() => _StepBankDetailsState();
}

class _StepBankDetailsState extends State<StepBankDetails> {
  DirectDebitBloc _directDepositBloc;
  BankBloc _bankBloc;
  double totalAmount;
  bool isButtonDisabled = true;
  bool isVerified = false;
  String cardRef;
  bool saveCard = false;
  final _formKey = GlobalKey<FormState>();
  var isSelected = [true, true];
  List<Bank> banks = [];
  AppDropDown2Item _selectedBank;
  String _accountNumber = "";
  String _accountName;
  double _maxAmount;
  List<AppDropDown2Item> _banksDropDownList = [];
  TextEditingController dateTextController = TextEditingController();
  TextEditingController endDateTextController = TextEditingController();
  final MoneyMaskedTextController _moneyMaskedTextController =
      new MoneyMaskedTextController(
          decimalSeparator: ".", initialValue: 0.00, thousandSeparator: ",");

  @override
  void initState() {
    _directDepositBloc = BlocProvider.of<DirectDebitBloc>(context);
    _bankBloc = BlocProvider.of<BankBloc>(context);
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
                BlocBuilder<BankBloc, BankState>(
                    buildWhen: (previous, current) =>
                        current is BankListReceived,
                    builder: (context, state) {
                      if (state is BankListReceived) {
                        banks = state.banks;
                        _banksDropDownList.clear();
                        for (int i = 0; i < banks.length; i++) {
                          final Bank singleBank = banks[i];
                          _banksDropDownList.add(AppDropDown2Item(
                              singleBank.id, singleBank.name,
                              meta: singleBank.toJson()));
                        }
                        return Container(
                          width: double.maxFinite,
                          child: Spinner(
                            hintText: "Select a Bank",
                            onSelect: (AppDropDown2Item value) {
                              _selectedBank = value;
                              watchFormState();
                              if (_accountNumber?.length == 10) {
                                verifyNuban();
                              }
                            },
                            selected: _selectedBank,
                            items: _banksDropDownList,
                          ),
                        );
                      }
                      return Container();
                    }),
                AppTextInput(
                  keyboardType: TextInputType.number,
                  labelText: "Account Number",
                  onChanged: (String text) {
                    _accountNumber = text;
                    watchFormState();
                    if (text.length == 10 && _selectedBank != null) {
                      verifyNuban();
                    }
                  },
                  validator: (String value) =>
                      value.isEmpty ? AppStringConstants.fieldReq : null,
                ),
                BlocConsumer<DirectDebitBloc, DirectDepositState>(
                    listener: (context, state) {
                  if (state is VerifyingBankDetails) {
                    isVerified = false;
                    watchFormState();
                  } else if (state is BankDetailsVerified) {
                    isVerified = true;
                    watchFormState();
                  } else if (state is AccountDetailsIncorrect) {
                    isVerified = false;
                    watchFormState();
                  }
                }, builder: (context, state) {
                  if (state is VerifyingBankDetails) {
                    isVerified = false;
                    return Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Container(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    );
                  } else if (state is BankDetailsVerified) {
                    isVerified = true;
                    _accountName = state.bankDetail.accountName;
                    return Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Container(
                                  child: Text(
                                state.bankDetail.accountName,
                                style: TextStyle(fontSize: 10),
                              )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    );
                  } else if (state is AccountDetailsIncorrect) {
                    isVerified = false;
                    return Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Container(
                                    child: Text(
                                  state.error.toString(),
                                  style: TextStyle(fontSize: 10),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    );
                  }
                  return Container();
                }),
                AppTextInput(
                  controller: _moneyMaskedTextController,
                  keyboardType: TextInputType.number,
                  labelText: "Maximum Debit Amount",
                  onChanged: (text) {
                    _maxAmount = _moneyMaskedTextController.numberValue;
                    watchFormState();
                  },
                  textAsIcon: "NGN",
                  validator: (String value) =>
                      value.isEmpty ? AppStringConstants.fieldReq : null,
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            PrimaryButton(
              width: double.maxFinite,
                label: 'PROCEED',
                color: AppColors.accentDark,
                onPressed: isButtonDisabled
                    ? null
                    : () {
                        proceedToAuthorisation();
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

  proceedToAuthorisation() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _directDepositBloc.add(ProceedToSigning(_maxAmount,
          Bank.fromJson(_selectedBank.meta), _accountName, _accountNumber));
    } else {
      AppSnackBar().show(message: AppStringConstants.formError);
    }
  }

  void verifyNuban() {
    _directDepositBloc.add(RequestBankDetails(
      _selectedBank.code.toString(),
      _accountNumber,
    ));
  }
}
