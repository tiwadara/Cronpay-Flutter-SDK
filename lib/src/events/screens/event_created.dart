import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/asset_constants.dart';
import 'package:cron_pay/src/events/blocs/event/event_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class EventCreated extends StatefulWidget {
  static const String routeName = '/eventCreated';
  final startDate;
  EventCreated(this.startDate);

  @override
  _EventCreatedState createState() => _EventCreatedState();
}

class _EventCreatedState extends State<EventCreated> {
  EventBloc _eventBloc;

  @override
  void initState() {
    _eventBloc = BlocProvider.of<EventBloc>(context);
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
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.accentDark,
                        AppColors.primaryMid,
                        AppColors.white
                      ])),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Center(
                  child: Image(
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
                image: AssetImage(Assets.successRocket),
              )),
            ),
            Positioned(
              left: 25,
              right: 25,
              bottom: 73.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Thank You",
                    style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor),
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text:
                            "Event created successful and would be \nexecuted on ",
                        style: TextStyle(
                            fontSize: 15.sp, color: AppColors.textColor),
                      ),
                      TextSpan(
                        text:
                            "${DateFormat("EEEE, MMM dd, yyyy").format(DateFormat("dd-MM-yyyy").parse(widget.startDate))}",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 66.h,
                  ),
                  SizedBox(
                    height: 29.h,
                  ),
                  InkWell(
                      onTap: () {
                        _eventBloc.add(GetEvents());
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "CLOSE",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
