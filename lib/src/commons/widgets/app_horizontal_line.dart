import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppHorizontalLine extends StatelessWidget {
  final Color color;

  AppHorizontalLine({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      width: double.infinity,
      color: color ?? AppColors.borderGrey,
    );
  }
}
