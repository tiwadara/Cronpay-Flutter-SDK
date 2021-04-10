import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/events/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarExample extends StatelessWidget {
  final CalendarController calendarController;
  final AnimationController animationController;
  final List<Event> events;
  final onDaySelected;
  final calendarEvents;
  final onVisibleDaysChanged;
  final onCalendarCreated;

  TableCalendarExample(
      {this.calendarController,
      this.onDaySelected,
      this.animationController,
      this.calendarEvents,
      this.onCalendarCreated,
      this.onVisibleDaysChanged,
      this.events});
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: calendarController,
      locale: 'en_US',
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.horizontalSwipe,
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextBuilder: (date, locale) {
          return DateFormat.E(locale).format(date).substring(0, 1);
        },
        weekdayStyle: TextStyle(color: AppColors.textColor),
        weekendStyle: TextStyle(color: AppColors.textColor),
      ),
      headerVisible: false,
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(animationController),
            child: Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 3.0,
                        offset: Offset(0, 1)),
                  ]),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${date.day}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold)
                          .copyWith(fontSize: 12.0),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${(DateFormat('E').format(date)).toUpperCase()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.white)
                          .copyWith(fontSize: 8.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return SizedBox(
            child: Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: AppColors.primaryDark),
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textColor)
                      .copyWith(fontSize: 15.0),
                ),
              ),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                left: 1,
                bottom: 8,
                child: _buildEventsMarker(date, events),
              ),
            );
          }
          return children;
        },
      ),
      events: calendarEvents,
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: AppColors.primaryDark),
        outsideStyle: TextStyle(color: Colors.grey.shade900),
        unavailableStyle: TextStyle(color: Colors.grey.shade900),
        outsideWeekendStyle: TextStyle(color: Colors.grey.shade900),
      ),
      onDaySelected: onDaySelected,
      onVisibleDaysChanged: onVisibleDaysChanged,
      onCalendarCreated: onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: calendarController.isSelected(date)
            ? Colors.transparent
            : calendarController.isToday(date)
                ? AppColors.white
                : AppColors.primaryDark,
      ),
      width: 5.0,
      height: 5.0,
    );
  }
}
