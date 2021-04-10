import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/widgets/app_header.dart';
import 'package:cron_pay/src/commons/widgets/app_widget_transition.dart';
import 'package:cron_pay/src/events/blocs/event/event_bloc.dart';
import 'package:cron_pay/src/events/models/event.dart';
import 'package:cron_pay/src/events/widgets/event_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllEvents extends StatefulWidget {
  static const String routeName = '/allEvents';
  AllEvents();

  @override
  _AllEventsState createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> with TickerProviderStateMixin {
  final attributeValueTextController = TextEditingController();
  var _scrollController = ScrollController();
  EventBloc _eventBloc;
  List<Event> _events = [];

  @override
  void initState() {
    _eventBloc = BlocProvider.of<EventBloc>(context);
    _eventBloc.add(GetEvents());
    _scrollController.addListener(() {});
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
              title: "Events",
            ),
            BlocBuilder<EventBloc, EventState>(
                buildWhen: (previous, current) => current is EventsReturned || current is GettingEvents ,
                builder: (context, state) {
                  if (state is EventsReturned) {
                    _events = state.events.toList();
                    if (_events.isEmpty) {
                      return buildEmptyEventContainer(context);
                    } else {
                      return Expanded(
                        child: ShowUp(
                          child: EventList(
                              forMonthsView: false, events: _events),
                        ),
                      );
                    }
                  } else if (state is GettingEvents) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(height: 40,width : 40,child: CircularProgressIndicator()),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
