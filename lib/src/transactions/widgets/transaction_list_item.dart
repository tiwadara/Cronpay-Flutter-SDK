import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/util/bottom_sheet.dart';
import 'package:cron_pay/src/transactions/models/transaction.dart';
import 'package:cron_pay/src/transactions/widgets/transaction_details_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem(
      {Key key,
      @required this.icon,
      @required this.color,
      @required this.onPressed,
      @required this.position,
      @required this.transaction,
      this.isLastOdd})
      : super(key: key);

  final VoidCallback onPressed;
  final Color color;
  final Transaction transaction;
  final int position;
  final IconData icon;
  final bool isLastOdd;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => displayBottomSheet(
          context, TransactionDetailsBottomSheet(transaction)),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 10),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                child: transaction.status == "SUCCESSFUL"
                    ? Icon(
                        FeatherIcons.check,
                        color: AppColors.primaryDark,
                        size: 12,
                      )
                    : Icon(
                        FeatherIcons.x,
                        color: AppColors.failedDark,
                        size: 12,
                      ),
                decoration: BoxDecoration(
                    color: transaction.status == "SUCCESSFUL"
                        ? AppColors.success
                        : AppColors.failed,
                    shape: BoxShape.circle),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transaction.beneficiary.name,
                      style:
                          TextStyle(fontSize: 12, color: AppColors.textColor),
                    ),
                    Row(
                      children: [Text(transaction.createdOn)],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                  "${NumberFormat.currency(name: "N ").format(transaction.amount)}"),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color:
              // position.isEven
              //     ? AppColors.borderGrey.withOpacity(0.2)
              //     :
              AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
