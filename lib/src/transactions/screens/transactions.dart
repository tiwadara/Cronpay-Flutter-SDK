import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/util/bottom_sheet.dart';
import 'package:cron_pay/src/commons/widgets/app_header.dart';
import 'package:cron_pay/src/commons/widgets/app_widget_transition.dart';
import 'package:cron_pay/src/transactions/blocs/transaction/transaction_bloc.dart';
import 'package:cron_pay/src/transactions/widgets/filter_bottom_sheet.dart';
import 'package:cron_pay/src/transactions/models/transaction.dart';
import 'package:cron_pay/src/transactions/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Transactions extends StatefulWidget {
  static const String routeName = '/transactions';
  Transactions();

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with TickerProviderStateMixin {
  final attributeValueTextController = TextEditingController();
  TransactionBloc _transactionBloc;
  List<Transaction> _transations = [];

  @override
  void initState() {
    _transactionBloc = BlocProvider.of<TransactionBloc>(context);
    _transactionBloc.add(GetTransactions());
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Header(
              previous: Container(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    FeatherIcons.x,
                    color: AppColors.white,
                  ),
                ),
              ),
              title: "History",
              next: IconButton(
                icon: Icon(
                  Boxicons.bx_filter,
                  color: AppColors.white,
                ),
                onPressed: () {
                  displayBottomSheet(context, FilterBottomSheet());
                },
              ),
            ),
            BlocBuilder<TransactionBloc, TransactionState>(
                buildWhen: (previous, current) =>
                    current is TransactionsReceived || current is LoadingState,
                builder: (context, state) {
                  if (state is TransactionsReceived) {
                    _transations = state.transactions.toList();
                    if (_transations.isEmpty) {
                      return buildEmptyEventContainer(context);
                    } else {
                      return Expanded(
                        child: ShowUp(
                          child: TransactionList(
                              forMonthsView: false, transactions: _transations),
                        ),
                      );
                    }
                  } else if (state is LoadingState) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator()),
                    );
                  }
                  return Container();
                })
          ],
        ));
  }

  Container buildEmptyEventContainer(BuildContext context) {
    return Container(
      height: 200.h,
      child: Column(
        children: [
          IconButton(
            icon: Icon(
              Boxicons.bxs_plus_circle,
              color: AppColors.primaryDark,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.newEvent);
            },
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "No upcoming events, create one",
            textAlign: TextAlign.center,
            style: TextStyle(),
          )),
        ],
      ),
    );
  }
}
