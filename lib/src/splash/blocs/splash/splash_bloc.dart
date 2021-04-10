import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cron_pay/src/commons/constants/storage_constants.dart';
import 'package:hive/hive.dart';

import 'bloc.dart';


class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(InitialSplashState());

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is LoadSplashEvent) {
      final onboardingBox = await Hive.openBox(StorageConstants.ONBOARDING_BOX);
      bool hasSeen =  await onboardingBox.get("has_seen", defaultValue: false);
      if (hasSeen) {
        yield OnboardingSeenState();
      } else {
        yield InitialAppLoad();
      }
    } else if (event is OnboardingSeenEvent) {
      final onboardingBox = await Hive.openBox(StorageConstants.ONBOARDING_BOX);
      onboardingBox.put("has_seen", true);
      yield OnboardingSeenState();
    }
  }
}
