part of 'event_bloc.dart';

@immutable
abstract class EventEvent extends Equatable {
  const EventEvent();
}

@immutable
class SaveEvent extends EventEvent {
  final Event paymentEvent;

  SaveEvent(this.paymentEvent);
  @override
  List<Object> get props => [paymentEvent];
}

@immutable
class GetEvents extends EventEvent {
  final int pageKey;
  final int pageSize;
  GetEvents({this.pageKey, this.pageSize});
  @override
  List<Object> get props => [pageKey, pageSize];
}

@immutable
class GetEventDates extends EventEvent {
  final int pageKey;
  final int pageSize;
  GetEventDates({this.pageKey, this.pageSize});
  @override
  List<Object> get props => [pageKey, pageSize];
}

@immutable
class GetEventsForMonth extends EventEvent {
  final DateTime month;
  GetEventsForMonth(this.month);
  @override
  List<Object> get props => [];
}
