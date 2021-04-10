import 'package:collection/collection.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/asset_constants.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/widgets/app_header.dart';
import 'package:cron_pay/src/commons/widgets/app_widget_transition.dart';
import 'package:cron_pay/src/events/blocs/event/event_bloc.dart';
import 'package:cron_pay/src/events/models/event.dart';
import 'package:cron_pay/src/events/widgets/calendar_four.dart';
import 'package:cron_pay/src/events/widgets/event_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Events extends StatefulWidget {
  static const String routeName = '/events';
  Events();

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> with TickerProviderStateMixin {
  final attributeValueTextController = TextEditingController();
  var _calendarController = CalendarController();
  ScrollController _scrollController = ScrollController();
  AnimationController _animationController;
  AnimationController expandController;
  AnimationController rotationController;
  Animation<double> animation;
  EventBloc _eventBloc;
  List<Event> _events = [];
  Map<DateTime, List> _calendarEvents = Map<DateTime, List>();
  DateTime _selectedMonth = DateTime.now();

  @override
  void initState() {
    _eventBloc = BlocProvider.of<EventBloc>(context);
    _eventBloc.add(GetEvents());
    prepareExpandAnimations();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    rotationController.forward();
    _animationController.forward();
    expandController.forward();
    super.initState();
  }

  void prepareExpandAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Header(
              previous: Container(
                child: InkWell(
                  onTap: () {
                    if (expandController.value == 0.0) {
                      expandController.forward();
                      rotationController.forward();
                    } else {
                      expandController.reverse();
                      rotationController.reverse();
                    }
                  },
                  child: SizedBox(
                    width: 170.w,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Row(
                            children: [
                              Text(
                                  "${DateFormat.MMM().format(_selectedMonth).toUpperCase()}    ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 24)),
                              Text("${_selectedMonth.year}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                      fontSize: 24)),
                            ],
                          )),
                          SizedBox(
                            width: 10.w,
                          ),
                          Center(
                              child: RotationTransition(
                            turns: Tween(begin: 0.0, end: 0.5)
                                .animate(rotationController),
                            child: Icon(FeatherIcons.chevronDown,
                                color: AppColors.white),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              title: "",
              next: IconButton(
                  onPressed: () {
                    _calendarController.setSelectedDay(
                      DateTime.now(),
                      runCallback: true,
                    );
                    _scrollController.animateTo(0.0,
                        curve: Curves.decelerate,
                        duration: Duration(milliseconds: 400));
                  },
                  icon: Icon(
                    FeatherIcons.calendar,
                    color: AppColors.white,
                  )),
            ),
            Expanded(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image(
                        width: 15,
                        fit: BoxFit.cover,
                        image: AssetImage(Assets.lines),
                      ),
                      SizedBox(
                        height: 150,
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 15),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        controller: _scrollController,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 12.h,
                              ),
                              SizeTransition(
                                sizeFactor: animation,
                                child: BlocBuilder<EventBloc, EventState>(
                                  buildWhen: (previous, current) => current is EventsReturned ,
                                  builder: (context, state) {
                                    return TableCalendarExample(
                                        calendarController: _calendarController,
                                        onDaySelected: (date, events, holidays) {
                                          _onDaySelected(date, events, holidays);
                                          _animationController.forward(from: 0.0);
                                        },
                                        calendarEvents: _calendarEvents,
                                        animationController: _animationController,
                                        onVisibleDaysChanged: _onVisibleDaysChanged,
                                        onCalendarCreated: _onCalendarCreated,
                                        events: _events);
                                  }
                                ),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "THIS MONTH",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.allEvent);
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "All Events ",
                                          style: TextStyle(color: AppColors.grey),
                                        ),
                                        Icon(
                                          FeatherIcons.chevronRight,
                                          size: 12,
                                          color: AppColors.grey,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              BlocBuilder<EventBloc, EventState>(
                                  buildWhen: (previous, current) =>
                                  current is EventsReturned ||
                                      current is EventsInSelectedMonth,
                                  builder: (context, state) {
                                    if (state is EventsReturned) {
                                      _events = state.events.toList();
                                      var groupedEvents = groupEventsForCurrentMonth(_events);
                                      if (_events.isEmpty || groupedEvents.isEmpty) {
                                        return buildEmptyEventContainer(context);
                                      } else {
                                        return ShowUp(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(top: 15.0),
                                            child:
                                            EventList(events: groupedEvents),
                                          ),
                                        );
                                      }
                                    }
                                    if (state is EventsInSelectedMonth) {
                                      // _events = state.events.toList();
                                      var groupedEvents =
                                      groupEvents(_events, state.month);
                                      if (_events.isEmpty ||
                                          groupedEvents.isEmpty) {
                                        return buildEmptyEventContainer(context);
                                      } else {
                                        return ShowUp(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(top: 15.0),
                                            child:
                                            EventList(events: groupedEvents),
                                          ),
                                        );
                                      }
                                    } else if (state is GettingEvents) {}
                                    return buildEmptyEventContainer(context);
                                  }),
                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
    expandController.dispose();
    _animationController.dispose();
    _calendarController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected' + events.toString());
    setState(() {
      // _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    setState(() {
      _selectedMonth = first;
    });
    _eventBloc.add(GetEventsForMonth(first));
    print('CALLBACK: _onVisibleDaysChanged' + first.month.toString());
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  List<Event> groupEventsForCurrentMonth(List<Event> events) {
    final groups = groupBy(events, (Event e) {
      return e.nextRunDate.substring(3, 10);
    });

    for (var i = 0; i < _events.length; i++) {
      var d = DateFormat('dd-MM-yyyy')
          .parse(_events[i].nextRunDate)
          .toIso8601String();
      _calendarEvents.putIfAbsent(DateTime.parse(d.toString()), () => _events);
    }

    var formattedDate = DateFormat("MM-yyyy").format(DateTime.now());
    groups.removeWhere((key, value) => key != formattedDate);
    try {
      return groups.values.single;
    } catch (e) {
      return [];
    }
  }

  List<Event> groupEvents(List<Event> events, DateTime month) {
    final groups = groupBy(events, (Event e) {
      return e.nextRunDate.substring(3, 10);
    });
    var formattedDate = DateFormat("MM-yyyy").format(month);
    groups.removeWhere((key, value) => key != formattedDate);
    try {
      return groups.values.single;
    } catch (e) {
      return [];
    }
  }
}
