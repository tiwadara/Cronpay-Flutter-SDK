import 'package:cron_pay/src/beneficiaries/models/beneficiary.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class BeneficiaryListItem extends StatelessWidget {
  const BeneficiaryListItem(
      {Key key,
      @required this.icon,
      @required this.color,
      @required this.onPressed,
       this.onDelete,
      @required this.position,
      @required this.beneficiary})
      : super(key: key);

  final VoidCallback onPressed;
  final VoidCallback onDelete;
  final Color color;
  final Beneficiary beneficiary;
  final int position;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "beneficiary",
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${camelize(beneficiary.name)}  ${beneficiary.alias == null ? "" :  " - "  + "${beneficiary.alias}"}" ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor),
                      ),
                      Text(
                        beneficiary.name +  "  .  " + beneficiary.accountNumber  +  "  .  " + beneficiary.bank.name,
                        style: TextStyle(
                           fontSize: 10,
                            color: AppColors.textColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: onPressed,
                  icon: Icon(FeatherIcons.trash2),
                  color: AppColors.grey,
                ),
              ],
            ),
          ),
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: position.isEven ? AppColors.borderGrey : AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
