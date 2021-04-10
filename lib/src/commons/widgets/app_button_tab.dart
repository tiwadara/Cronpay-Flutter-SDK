import 'package:cron_pay/src/commons/widgets/app_selectable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class ButtonTab extends StatefulWidget {
  final Function(int value) groupValue;

  ButtonTab(this.groupValue);
  @override
  _ButtonTabState createState() => _ButtonTabState();
}

class _ButtonTabState extends State<ButtonTab> {
  bool buttonOne = true;
  bool buttonTwo = false;

  @override
  void setState(fn) {
    super.setState(fn);
  }

  void _pushFinalValue() {
    setState(() {
      if (buttonOne) {
        widget.groupValue(1);
      } else if (buttonTwo) {
        widget.groupValue(2);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 80,
              child: SelectableCard(
                value: buttonOne,
                onChange: (bool value) {
                  setState(() {
                    buttonOne = true;
                    buttonTwo = false;
                    _pushFinalValue();
                  });
                }, icon: Boxicons.bxs_bank, title: 'Direct Bank Deposit',
              ),
            ),
          ),
          SizedBox(width: 15,),
          Expanded(
            child: SizedBox(
              height: 80,
              child: SelectableCard(
                value: buttonTwo,
                onChange: (bool value) {
                  setState(() {
                    buttonTwo = true;
                    buttonOne = false;
                    _pushFinalValue();
                  });
                }, icon: Boxicons.bx_credit_card, title: 'Debit Card',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
