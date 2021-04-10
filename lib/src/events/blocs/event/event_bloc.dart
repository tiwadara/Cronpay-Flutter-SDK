import 'dart:async';

import 'package:cron_pay/src/commons/models/api_response.dart';
import 'package:cron_pay/src/events/models/event.dart';
import 'package:cron_pay/src/events/models/event_date.dart';
import 'package:cron_pay/src/events/models/page.dart';
import 'package:cron_pay/src/events/services/event_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends HydratedBloc<EventEvent, EventState> {
  final EventService eventService;

  EventBloc(this.eventService) : super(InitialEventState());

  EventState get initialState => InitialEventState();

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    if (event is SaveEvent) {
      yield SavingEvent();
      var response = await eventService.saveEvent(event.paymentEvent);
      if (response is SuccessResponse) {
        yield EventSaved(response.responseBody.message);
      } else if (response is ErrorResponse) {
        yield ErrorWithMessageState(response.message);
      }
    } else if (event is GetEvents) {
      if (state is InitialEventState) {
        yield GettingEvents();
      }
      var response =
          await eventService.getEvents(event.pageKey, event.pageSize);
      if (response is SuccessResponse) {
        List data = response.responseBody.data["data"];
        Page page = Page.fromJson(response.responseBody.data["page"]);
        yield EventsReturned(
            data.map((e) => Event.fromJson(e)).toList(), event.pageKey, page);
      } else if (response is ErrorResponse) {
        yield ErrorWithMessageState(response.message);
      }
    } else if (event is GetEventDates) {
      yield GettingEvents();
      var response =
          await eventService.getEventDates(event.pageKey, event.pageSize);
      if (response is SuccessResponse) {
        List data = response.responseBody.data["data"];
        Page page = Page.fromJson(response.responseBody.data["page"]);
        yield EventDatesReturned(
            data.map((e) => EventDate.fromJson(e)).toList(),
            event.pageKey,
            page);
      } else if (response is ErrorResponse) {
        yield ErrorWithMessageState(response.message);
      }
    } else if (event is GetEventsForMonth) {
      yield GettingEvents();
      yield EventsInSelectedMonth(event.month);
    }
  }

  @override
  EventState fromJson(Map<String, dynamic> json) {
    try {
      final events = (json as List).map((e) => Event.fromJson(e)).toList();
      Page page = Page.fromJson(json["page"]);
      int pageKey = json["pageKey"];
      return EventsReturned(events, pageKey, page);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(EventState state) {
    if (state is EventsReturned) {
      return {
        'events': state.events,
        'pageKey': state.pageKey,
        'page': state.page,
      };
    }
    return null;
  }
}
