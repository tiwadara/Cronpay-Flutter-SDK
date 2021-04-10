import 'package:collection/collection.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/events/blocs/event/event_bloc.dart';
import 'package:cron_pay/src/events/models/event.dart';
import 'package:cron_pay/src/transactions/models/transaction.dart';
import 'package:cron_pay/src/transactions/widgets/transaction_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({
    Key key,
    @required this.transactions,
    this.forMonthsView = true,
  }) : super(key: key);

  final List<Transaction> transactions;
  final bool forMonthsView;

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  static const _pageSize = 10;
  EventBloc _eventBloc;
  final PagingController<int, Event> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  Widget build(BuildContext context) {
    return widget.forMonthsView
        ? Column(children: monthlyChildren(widget.transactions))
        : CustomScrollView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            slivers: listChildren());
  }

  List<Widget> listChildren() {
    List<Widget> a = [];

    final groupByMonth = groupBy(
        widget.transactions, (Transaction e) => e.createdOn.substring(3, 10));

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
                      DateFormat.yMMMM()
                          .format(DateFormat('M-yyyy').parse(date)),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${list.length} Transactions ",
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
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
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

    final groupByMonth = groupBy(_events,
        (Transaction e) => DateFormat("dd-MM-yyyy").parse(e.createdOn));

    groupByMonth.forEach((date, list) {
      var isOdd = list.length.isOdd;
      a.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                return TransactionListItem(
                  isLastOdd: isOdd,
                  icon: Icons.add_circle_outline,
                  transaction: list[position],
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
