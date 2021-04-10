import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/widgets/app_horizontal_line.dart';
import 'package:cron_pay/src/commons/widgets/app_outline_button.dart';
import 'package:cron_pay/src/transactions/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TransactionDetailsBottomSheet extends StatefulWidget {
  const TransactionDetailsBottomSheet(this.transaction, {Key key})
      : super(key: key);
  final Transaction transaction;

  @override
  _TransactionDetailsBottomSheetState createState() =>
      _TransactionDetailsBottomSheetState();
}

class _TransactionDetailsBottomSheetState
    extends State<TransactionDetailsBottomSheet> {
  double totalAmount;
  var isButtonDisabled = true;
  String cardRef;
  bool saveCard = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      decoration: BoxDecoration(
          color: AppColors.accentDark,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      height: 500.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            widget.transaction.beneficiary.name,
            style: TextStyle(
                fontSize: 20,
                color: AppColors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          AppHorizontalLine(color: AppColors.mainBlack.withOpacity(0.9),),
          SizedBox(
            height: 10.h,
          ),
          Text("TRANSACTION DETAILS", style: TextStyle(color: AppColors.borderGrey,fontSize: 15, fontWeight: FontWeight.bold),),
          Table(
            columnWidths: {
              0: FlexColumnWidth(1)
            },


            children: [
              TableRow(children: [ SizedBox(height: 5.h,), SizedBox(height: 5.h,)]),
              TableRow(children: [
                Text(
                  "Reference",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.accentLighter,
                    fontSize: 14,
                  ),
                ),
                Text(widget.transaction.reference,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),

              ]),
              TableRow(children: [ SizedBox(height: 5.h,) , SizedBox(height: 5.h,)]),
              TableRow(children: [
                Text(
                  "Amount",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.accentLighter,
                    fontSize: 14,
                  ),
                ),
                Text(
                  NumberFormat.currency(name: "N ")
                      .format(widget.transaction.amount )
                      .toString(),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),

              ]),
              TableRow(children: [ SizedBox(height: 5.h,) , SizedBox(height: 5.h,)]),
              TableRow(children: [
                Text(
                  "Status",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.accentLighter,
                    fontSize: 14,
                  ),
                ),
                Text(widget.transaction.status,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),

              ]),
              TableRow(children: [ SizedBox(height: 10.h,) , SizedBox(height: 10.h,)]),
              TableRow(children: [
                Text(
                  "Date/Time",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.accentLighter,
                    fontSize: 14,
                  ),
                ),
                Text( widget.transaction.createdOn  ,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),

              ]),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          AppHorizontalLine(color: AppColors.mainBlack.withOpacity(0.9),),
          SizedBox(
            height: 10.h,
          ),
          Text("BANK DETAILS", style: TextStyle(color: AppColors.borderGrey,fontSize: 15, fontWeight: FontWeight.bold),),
          Table(
            columnWidths: {
              0: FlexColumnWidth(1)
            },

            children: [
              TableRow(children: [ SizedBox(height: 5.h,), SizedBox(height: 5.h,)]),
              TableRow(children: [
                Text(
                  "Account Name",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.accentLighter,
                    fontSize: 14,
                  ),
                ),
                Text(widget.transaction.beneficiary.name,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),

              ]),
              TableRow(children: [ SizedBox(height: 5.h,) , SizedBox(height: 5.h,)]),
              TableRow(children: [
                Text(
                  "Account Number",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.accentLighter,
                    fontSize: 14,
                  ),
                ),
                Text(widget.transaction.beneficiary.accountNumber,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),

              ]),
              TableRow(children: [ SizedBox(height: 5.h,) , SizedBox(height: 5.h,)]),
              TableRow(children: [
                Text(
                  "Bank Name",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.accentLighter,
                    fontSize: 14,
                  ),
                ),
                Text( widget.transaction.beneficiary.bank.name,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),

              ])
            ],
          ),
          SizedBox(
            height: 20.h,
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
    );
  }
}
