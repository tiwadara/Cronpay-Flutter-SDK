import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/events/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:intl/intl.dart';

class EventListItem extends StatelessWidget {
  const EventListItem(
      {Key key,
      @required this.icon,
      @required this.color,
      @required this.onPressed,
      @required this.position,
      @required this.event, this. isLastOdd})
      : super(key: key);

  final VoidCallback onPressed;
  final Color color;
  final Event event;
  final int position;
  final IconData icon;
  final bool isLastOdd;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2) ,
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(event.name, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor),),
                    Text(
                        "${NumberFormat.currency(name: "N").format(event.amount)}"),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Boxicons.bx_calendar_event, color: AppColors.grey,),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: position.isEven ? AppColors.borderGrey.withOpacity(0.2) : AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
