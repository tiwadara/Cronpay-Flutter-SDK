import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Timeline extends StatelessWidget {
  final stage;
  const Timeline(
    this.stage, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            constraints: BoxConstraints(maxHeight: 50),
            child: TimelineTile(
              afterLineStyle: LineStyle(
                  thickness: 2,
                  color: stage == TimeLineStages().stageTwo ||
                          stage == TimeLineStages().stageThree
                      ? AppColors.primaryDark
                      : AppColors.borderGrey),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              isFirst: true,
              indicatorStyle: IndicatorStyle(
                  color: AppColors.primaryDark, height: 15, width: 15),
              endChild: Container(
                child: Text(
                  "Bank Details",
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 2,
            color: stage == TimeLineStages().stageTwo ||
                    stage == TimeLineStages().stageThree
                ? AppColors.primaryDark
                : AppColors.borderGrey,
          ),
        ),
        Expanded(
          child: Container(
            constraints: BoxConstraints(maxHeight: 50),
            child: TimelineTile(
              afterLineStyle: LineStyle(
                  thickness: 2,
                  color: stage == TimeLineStages().stageThree
                      ? AppColors.primaryDark
                      : AppColors.borderGrey),
              beforeLineStyle: LineStyle(
                  thickness: 2,
                  color: stage == TimeLineStages().stageTwo ||
                          stage == TimeLineStages().stageThree
                      ? AppColors.primaryDark
                      : AppColors.borderGrey),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              indicatorStyle: IndicatorStyle(
                  color: stage == TimeLineStages().stageTwo ||
                          stage == TimeLineStages().stageThree
                      ? AppColors.primaryDark
                      : AppColors.accentDark,
                  height: 15,
                  width: 15),
              endChild: Container(
                child: Text(
                  "Authorization",
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 2,
            color:  stage == TimeLineStages().stageThree
                ? AppColors.primaryDark
                : AppColors.borderGrey,
          ),
        ),
        Expanded(
          child: Container(
            constraints: BoxConstraints(maxHeight: 50),
            child: TimelineTile(
              beforeLineStyle: LineStyle(
                  thickness: 2,
                  color: stage == TimeLineStages().stageThree
                      ? AppColors.primaryDark
                      : AppColors.borderGrey),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              isLast: true,
              indicatorStyle: IndicatorStyle(
                  color: stage == TimeLineStages().stageThree
                      ? AppColors.primaryDark
                      : AppColors.accentDark,
                  height: 15,
                  width: 15),
              endChild: Container(
                child: Text(
                  "Complete",
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TimeLineStages {
  var stageOne = 1;
  var stageTwo = 2;
  var stageThree = 3;
}
