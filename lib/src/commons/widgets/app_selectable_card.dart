import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SelectableCard extends StatefulWidget {
  const SelectableCard({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.value,
    @required this.onChange,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final bool value;
  final Function(bool newState) onChange;

  @override
  _SelectableCardState createState() => _SelectableCardState();
}

class _SelectableCardState extends State<SelectableCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChange(widget.value);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: widget.value ?  Border.all(color: AppColors.primaryDark) : Border.all(color: AppColors.white) ,
          color: AppColors.white,
            boxShadow: widget.value ?  [
              new BoxShadow(
                color: Colors.black.withOpacity(0.16),
                offset: Offset(0, 3),
                blurRadius: 6.0,
              ),
            ] : []
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(widget.icon,size: 30,color: AppColors.accentDark,), Text(widget.title, style: TextStyle(fontSize: 14, color: AppColors.accentDark),)],
        ),
      ),
    );
  }
}
