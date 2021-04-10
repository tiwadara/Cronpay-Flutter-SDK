part of 'event_bloc.dart';

@immutable
abstract class EventState extends Equatable {
  const EventState();
}

class InitialEventState extends EventState {
  @override
  List<Object> get props => [];
}

@immutable
class ErrorWithMessageState extends EventState {
  final String error;
  ErrorWithMessageState(this.error);
  @override
  List<Object> get props => [error];
}

@immutable
class RequestError extends EventState {
  final ErrorResponse errorResponse;
  RequestError(this.errorResponse);

  @override
  List<Object> get props => [errorResponse];
}

class LoadingState extends EventState {
  @override
  List<Object> get props => [];
}

@immutable
class SavingEvent extends EventState {
  @override
  List<Object> get props => [];
}

@immutable
class GettingEvents extends EventState {
  @override
  List<Object> get props => [];
}

@immutable
class EventSaved extends EventState {
  final String message;
  EventSaved(this.message);

  @override
  List<Object> get props => [message];
}

@immutable
class EventsReturned extends EventState {
  final List<Event> events;
  final int pageKey;
  final Page page;
  EventsReturned(this.events, this.pageKey, this.page);

  @override
  List<Object> get props => [events, pageKey, page];
}

@immutable
class EventDatesReturned extends EventState {
  final List<EventDate> eventDates;
  final int pageKey;
  final Page page;
  EventDatesReturned(this.eventDates, this.pageKey, this.page);

  @override
  List<Object> get props => [eventDates, pageKey];
}
@immutable
class EventsInSelectedMonth extends EventState {
  // final List<Event> events;
  final DateTime month;
  EventsInSelectedMonth(this.month);

  @override
  List<Object> get props => [month];
}
