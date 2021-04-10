import 'package:cron_pay/src/beneficiaries/blocs/beneficiary/beneficiary_bloc.dart';
import 'package:cron_pay/src/beneficiaries/models/beneficiary.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/models/bank.dart';
import 'package:cron_pay/src/commons/util/remove_text_view_focus.dart';
import 'package:cron_pay/src/commons/util/strings.dart';
import 'package:cron_pay/src/commons/widgets/app_header.dart';
import 'package:cron_pay/src/commons/widgets/app_loader.dart';
import 'package:cron_pay/src/commons/widgets/app_number_counter.dart';
import 'package:cron_pay/src/commons/widgets/app_search_filter.dart';
import 'package:cron_pay/src/commons/widgets/app_sliding_switch.dart';
import 'package:cron_pay/src/commons/widgets/app_snackbar.dart';
import 'package:cron_pay/src/commons/widgets/app_spinner.dart';
import 'package:cron_pay/src/commons/widgets/app_text_view.dart';
import 'package:cron_pay/src/commons/widgets/primary_button.dart';
import 'package:cron_pay/src/events/blocs/event/event_bloc.dart';
import 'package:cron_pay/src/events/models/event.dart';
import 'package:cron_pay/src/profile/blocs/bank/bank_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NewEvent extends StatefulWidget {
  static const String routeName = '/newEvent';
  NewEvent();

  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  EventBloc eventBloc;
  BankBloc _bankBloc;
  BeneficiaryBloc _beneficiaryBloc;
  final _formKey = GlobalKey<FormState>();
  var isButtonDisabled = true;
  var hasSwitchedBeneficiary = false;
  Event event = Event();
  List<Bank> banks = [];
  AppDropDown2Item _selectedBank;
  List<AppDropDown2Item> _banksDropDownList = [];
  AppDropDown2Item _selectedInterval;
  List<AppDropDown2Item> _intervals = [];
  TextEditingController dateTextController = TextEditingController();
  TextEditingController endDateTextController = TextEditingController();
  final MoneyMaskedTextController _moneyMaskedTextController =
      new MoneyMaskedTextController(
          decimalSeparator: ".", initialValue: 0.00, thousandSeparator: ",");

  @override
  void initState() {
    eventBloc = BlocProvider.of<EventBloc>(context);
    _bankBloc = BlocProvider.of<BankBloc>(context);
    _beneficiaryBloc = BlocProvider.of<BeneficiaryBloc>(context);
    _beneficiaryBloc.add(CreateNewBeneficiary());
    _bankBloc.add(GetBanksEvent());
    event.beneficiary = Beneficiary();
    event.increment = 1;
    _intervals.add(AppDropDown2Item("WEEKLY", "Week(s)"));
    _intervals.add(AppDropDown2Item("MONTHLY", "Month(s)"));
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Header(
              title: "New Event",
              // next: SizedBox(
              //     width: 70,
              //     child: OutlineButton(
              //       shape: new RoundedRectangleBorder(
              //           borderRadius: new BorderRadius.circular(10.0)),
              //       borderSide: BorderSide(color: AppColors.white, width: 2),
              //       child: Text(
              //         "Save",
              //         style: TextStyle(color: AppColors.white),
              //       ),
              //       onPressed: () {
              //         createEvent();
              //       },
              //       highlightedBorderColor: AppColors.shadow,
              //     ))
            ),
            // CleanCalendarExample(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 19.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            AppTextInput(
                              hintText: 'Add Title e.g  Kids monthly stipends',
                              labelText: "Title",
                              onChanged: (text) {
                                event.name = text;
                                watchFormState();
                              },
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AppTextInput(
                                      // icon: FeatherIcons.calendar,
                                      labelText: "Start Date",
                                      onChanged: (text) {
                                        event.startDate = text;
                                        watchFormState();
                                      },
                                      focusNode: AlwaysDisabledFocusNode(),
                                      onTap: () async {
                                        DateTime pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          builder: (context, child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                primaryColor:
                                                    AppColors.primaryDark,
                                                accentColor:
                                                    AppColors.accentDark,
                                                colorScheme: ColorScheme.light(
                                                    primary:
                                                        AppColors.primaryDark),
                                                buttonTheme: ButtonThemeData(
                                                    textTheme: ButtonTextTheme
                                                        .primary),
                                              ),
                                              child: child,
                                            );
                                          },
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(3000),
                                          errorFormatText: 'Enter valid date',
                                          errorInvalidText:
                                              'Enter date in valid range',
                                        );
                                        setState(() {
                                          var formattedDate =
                                              DateFormat("EE, MMM dd, yyyy")
                                                  .format(pickedDate);
                                          event.startDate =
                                              DateFormat("dd-MM-yyyy")
                                                  .format(pickedDate);
                                          dateTextController.text =
                                              formattedDate.toString();
                                          watchFormState();
                                        });
                                      },
                                      enabled: true,
                                      controller: dateTextController,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: AppTextInput(
                                      // icon: FeatherIcons.calendar,
                                      labelText: "End Date",
                                      onChanged: (text) {
                                        event.endDate = text;
                                        watchFormState();
                                      },
                                      focusNode: AlwaysDisabledFocusNode(),
                                      onTap: () async {
                                        DateTime pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          builder: (context, child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                primaryColor:
                                                    AppColors.primaryDark,
                                                accentColor:
                                                    AppColors.accentDark,
                                                colorScheme: ColorScheme.light(
                                                    primary:
                                                        AppColors.primaryDark),
                                                buttonTheme: ButtonThemeData(
                                                    textTheme: ButtonTextTheme
                                                        .primary),
                                              ),
                                              child: child,
                                            );
                                          },
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(3000),
                                          errorFormatText: 'Enter valid date',
                                          errorInvalidText:
                                              'Enter date in valid range',
                                        );
                                        setState(() {
                                          var formattedDate =
                                              DateFormat("EE, MMM dd, yyyy")
                                                  .format(pickedDate);
                                          event.endDate =
                                              DateFormat("dd-MM-yyyy")
                                                  .format(pickedDate);
                                          endDateTextController.text =
                                              formattedDate.toString();
                                          watchFormState();
                                        });
                                      },
                                      enabled: true,
                                      controller: endDateTextController,
                                    ),
                                  ),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Repeat Every",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      AppCounter(
                                        onChanged: (int count) {
                                          event.increment = count;
                                          watchFormState();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Spinner(
                                    hintText: "Select Interval",
                                    onSelect: (AppDropDown2Item value) {
                                      event.interval = value.code;
                                      _selectedInterval = value;
                                      watchFormState();
                                    },
                                    selected: _selectedInterval,
                                    items: _intervals,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SlidingSwitch(
                                inactiveColor: AppColors.accentDark,
                                colorOn: AppColors.white,
                                colorOff: AppColors.white,
                                buttonColor: AppColors.accentDark,
                                textOn: "Existing Beneficiary",
                                textOff: "New beneficiary",
                                value: false,
                                onChanged: (value) {
                                  if (!value) {
                                    _beneficiaryBloc
                                        .add(CreateNewBeneficiary());
                                  } else {
                                    _beneficiaryBloc
                                        .add(SwitchToPickBeneficiary());
                                  }
                                  setState(() {
                                    hasSwitchedBeneficiary = value;
                                  });
                                }),
                            SizedBox(
                              height: 10.h,
                            ),
                            hasSwitchedBeneficiary
                                ? Hero(
                                    tag: "search",
                                    child: SearchFilter(
                                      focusNode: AlwaysDisabledFocusNode(),
                                      onClicked: () {
                                        Navigator.pushNamed(
                                                context, Routes.beneficiaries)
                                            .then((value) {
                                        });
                                      },
                                      onResultUpdated: () {},
                                    ),
                                  )
                                : Container(),
                            BlocBuilder<BeneficiaryBloc, BeneficiaryState>(
                                builder: (context, state) {
                              if (state is CreateNewPicked) {
                                return Column(children: [
                                  BlocBuilder<BankBloc, BankState>(
                                      buildWhen: (previous, current) =>
                                          current is BankListReceived,
                                      builder: (context, state) {
                                        if (state is BankListReceived) {
                                          banks = state.banks;
                                          _banksDropDownList.clear();
                                          for (int i = 0;
                                              i < banks.length;
                                              i++) {
                                            final Bank singleBank = banks[i];
                                            _banksDropDownList.add(
                                                AppDropDown2Item(singleBank.id,
                                                    singleBank.name,
                                                    meta: singleBank.toJson()));
                                          }
                                          return Container(
                                            width: double.maxFinite,
                                            child: Spinner(
                                              hintText: "Select a Bank",
                                              onSelect:
                                                  (AppDropDown2Item value) {
                                                event.beneficiary = Beneficiary(
                                                    bankId: value.code);
                                                _selectedBank = value;
                                                watchFormState();
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
                                    onChanged: (text) {
                                      event.beneficiary.accountNumber = text;
                                      watchFormState();
                                    },
                                  ),
                                  AppTextInput(
                                    keyboardType: TextInputType.text,
                                    hintText: 'Alias e.g Gardener',
                                    labelText: "Alias",
                                    onChanged: (text) {
                                      event.beneficiary.alias = text;
                                      watchFormState();
                                    },
                                  ),
                                ]);
                              } else if (state is BeneficiaryPicked) {
                                event.beneficiary = Beneficiary(
                                    bankId: state.beneficiary.bank.id);
                                event.beneficiary.accountNumber =
                                    state.beneficiary.accountNumber;
                                event.beneficiary.alias =
                                    state.beneficiary.alias;
                                return Hero(
                                  tag: "beneficiary",
                                  child: Material(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "${camelize(state.beneficiary.name)}  ${state.beneficiary.alias == null ? "" : " - " + "${state.beneficiary.alias}"}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .textColor),
                                                  ),
                                                  Text(
                                                    state.beneficiary.name +
                                                        "  .  " +
                                                        state.beneficiary
                                                            .accountNumber +
                                                        "  .  " +
                                                        state.beneficiary.bank
                                                            .name,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: AppColors
                                                            .textColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: AppColors.shadow,
                                                blurRadius: 15.0,
                                                offset: Offset(0, 8)),
                                          ]),
                                    ),
                                  ),
                                );
                              } else if (state is SwitchToExistingPicked) {
                                return Container();
                              }
                              return Container();
                            }),
                            AppTextInput(
                              controller: _moneyMaskedTextController,
                              keyboardType: TextInputType.number,
                              textAsIcon: "NGN",
                              labelText: "Amount",
                              onChanged: (text) {
                                event.amount =
                                    _moneyMaskedTextController.numberValue;
                                watchFormState();
                              },
                            ),
                            AppTextInput(
                              keyboardType: TextInputType.text,
                              labelText: "Description / Remarks",
                              onChanged: (text) {
                                event.description = text;
                                watchFormState();
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    BlocConsumer<EventBloc, EventState>(
                      builder: (context, state) {
                        return PrimaryButton(
                            icon: Boxicons.bxs_chevron_right_circle,
                            label: 'SAVE EVENT',
                            onPressed:
                                isButtonDisabled ? null : () => createEvent());
                      },
                      listener: (context, state) {
                        if (state is ErrorWithMessageState) {
                          Navigator.pop(context);
                          AppSnackBar().show(message: state.error);
                        } else if (state is EventSaved) {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, Routes.eventCreated, arguments: event.startDate);
                        }
                      },
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  void watchFormState() {
    print("event" + event.toJson().toString());
    if (event.checkIfAnyIsNull()) {
      setState(() => isButtonDisabled = true);
    } else {
      setState(() => isButtonDisabled = false);
    }
  }

  void gotoNextScreen() {
    Navigator.pushReplacementNamed(context, Routes.navigationHost);
  }

  void createEvent() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      showOverlay(context, "Creating Schedule");
      eventBloc.add(SaveEvent(event));
    } else {
      AppSnackBar().show(message: "Please, correct invalid fields");
    }
  }

  @override
  void dispose() {
    endDateTextController.dispose();
    _moneyMaskedTextController.dispose();
    dateTextController.dispose();
    super.dispose();
  }
}
