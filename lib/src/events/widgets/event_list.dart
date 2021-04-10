import 'package:collection/collection.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/events/blocs/event/event_bloc.dart';
import 'package:cron_pay/src/events/models/event.dart';
import 'package:cron_pay/src/events/widgets/evenl_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class EventList extends StatefulWidget {
  const EventList({
    Key key,
    @required this.events,
    this.forMonthsView = true,
  }) : super(key: key);

  final List<Event> events;
  final bool forMonthsView;

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  static const _pageSize = 10;
  EventBloc _eventBloc;
  final PagingController<int, Event> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  Widget build(BuildContext context) {
    return widget.forMonthsView
        ? Column(children: monthlyChildren(widget.events))
        : CustomScrollView(
            shrinkWrap: true,
            physics:  ScrollPhysics(),
            slivers: listChildren());

    return widget.forMonthsView
        ? Column(children: monthlyChildren(widget.events))
        : BlocListener<EventBloc, EventState>(
            listener: (context, state) {
              if (state is EventsReturned) {
                try {
                  final newItems = state.events;
                  // final isLastPage = newItems.length < _pageSize;
                  print("dfdf" + state.page.toJson().toString());
                  final isLastPage = state.page.totalPages - 1 == state.pageKey;
                  if (isLastPage) {
                    _pagingController.appendLastPage(newItems);
                  } else {
                    final nextPageKey = state.pageKey + 1;
                    _pagingController.appendPage(newItems, nextPageKey);
                  }
                } catch (error) {
                  _pagingController.error = error;
                }
              }
            },
            child: PagedListView<int, Event>(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Event>(
                itemBuilder: (context, item, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat.yMMMM().format(DateFormat('d-MM-yyyy')
                                  .parse(item.nextRunDate)),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${index} Payments ",
                              style: TextStyle(color: AppColors.grey),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Text(item.nextRunDate.toString() +
                            "   " +
                            item.beneficiary.name.toString()),
                      ),
                      Text(
                        "${item.name} Payments ",
                        style: TextStyle(color: AppColors.grey),
                      )
                    ],
                  );
                },
              ),
            ),
          );
  }

  List<Widget> listChildren() {
    List<Widget> a = [];

    final groupByMonth =
        groupBy(widget.events, (Event e) => e.nextRunDate.substring(3, 10));

    groupByMonth.forEach((date, list) {
      a.add(SliverStickyHeader(
        header: Container(
          color: AppColors.borderGrey,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat.yMMMM().format(DateFormat('M-yyyy').parse(date)),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${list.length} Payments ",
                      style: TextStyle(color: AppColors.grey),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        sliver: new SliverList(
          delegate: new SliverChildBuilderDelegate((context, i) {
            return Padding(
              padding: const EdgeInsets.only(top:15.0, bottom: 15.0),
              child: Column(
                children: monthlyChildren(list),
              ),
            );
          }, childCount: 1),
        ),
      ));
    });

    return a;
  }

  List<Widget> monthlyChildren(_events) {
    List<Widget> a = [];

    final groupByMonth = groupBy(_events, (Event e) {
      return DateFormat("dd-MM-yyyy").parse(e.nextRunDate);
    });

    groupByMonth.forEach((date, list) {
      var isOdd = list.length.isOdd;
      a.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: Column(
              children: [
                Text(
                  DateFormat('E').format(date).toUpperCase(),
                  style: TextStyle(fontSize: 9, color: AppColors.textColor),
                ),
                Text(
                  date.day.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.textColor),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, position) {
                return EventListItem(
                  isLastOdd: isOdd,
                  icon: Icons.add_circle_outline,
                  event: list[position],
                  color: Colors.white,
                  position: position,
                  onPressed: () {},
                );
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ));
    });
    return a;
  }

  @override
  void initState() {
    _eventBloc = BlocProvider.of<EventBloc>(context);
    _pagingController.addPageRequestListener((pageKey) {
      print("request new page" + pageKey.toString());
      _eventBloc.add(GetEvents(pageKey: pageKey, pageSize: _pageSize));
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Widget monthItem(String date, List<Event> list) {
    return Container(
      color: AppColors.primaryDark,
      height: 30,
    );
  }
}
