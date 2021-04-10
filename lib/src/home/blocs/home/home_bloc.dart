import 'dart:async';

import 'package:cron_pay/src/home/models/budget.dart';
import 'package:cron_pay/src/home/models/expense.dart';
import 'package:cron_pay/src/home/services/home_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeService homeService;

  HomeBloc(this.homeService) : super(InitialWalletState());

  HomeState get initialState => InitialWalletState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {

  }
}
