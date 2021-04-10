import 'dart:isolate';

import 'package:cron_pay/src/app.dart';
import 'package:cron_pay/src/auth/models/token.dart';
import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/bloc_observer.dart';
import 'package:cron_pay/src/commons/constants/network_constants.dart';
import 'package:cron_pay/src/commons/models/bank.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:path_provider/path_provider.dart';

import 'di_container.dart';
import 'src/home/models/budget.dart';
import 'src/home/models/expense.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHiveBox();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? null : await getApplicationDocumentsDirectory(),
  );

  final KiwiContainer kiwiContainer = KiwiContainer();
  final Dio dio = getDioInstance();
  kiwiContainer.registerInstance(dio);
  setupDI();

  Bloc.observer = MyBlocObserver();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(App());
  });
}

Future setupHiveBox() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(BudgetAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TokenAdapter());
  Hive.registerAdapter(BankAdapter());
}

Dio getDioInstance() {
  final BaseOptions _baseOptions = BaseOptions(
      contentType: 'application/json',
      connectTimeout: 30 * 1000,
      receiveTimeout: 15 * 1000,
      baseUrl: NetworkConstants.BASE_URL);
  final Dio _dio = Dio(_baseOptions);
  return _dio;
}
