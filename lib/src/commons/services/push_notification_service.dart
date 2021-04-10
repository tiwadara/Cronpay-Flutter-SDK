import 'dart:io';

import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:overlay_support/overlay_support.dart';

import 'navigation_service.dart';

class PushNotificationService {
  // final FirebaseMessaging _fcm = FirebaseMessaging();
  // final NavigationService _navigationService = KiwiContainer().resolve<NavigationService>();
  //
  // Future initialise() async {
  //   if (Platform.isIOS) {
  //     _fcm.requestNotificationPermissions(IosNotificationSettings(
  //       sound: true,
  //       badge: true,
  //       alert: true,
  //       provisional: true,
  //     ));
  //   }
  //   _fcm.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       debugPrint("onMessage: $message");
  //       _serialiseAndNavigate(message);
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       debugPrint("onLaunch: $message");
  //       _serialiseAndNavigate(message);
  //     },
  //     onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
  //     onResume: (Map<String, dynamic> message) async {
  //       debugPrint("onResume: $message");
  //       _serialiseAndNavigate(message);
  //     },
  //   );
  // }

  // Future<String> getToken() async {
  //   return await _fcm.getToken();
  // }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    var data = message['data'];
    var notification = message['notification'];

    showSimpleNotification(
      Container(
          child: Text(
        notification["title"].toString(),
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      subtitle: Container(child: Text(notification["body"].toString())),
      position: NotificationPosition.top,
      contentPadding: EdgeInsets.all(10),
      slideDismiss: true,
      duration: Duration(seconds: 5),
      background: AppColors.primary,
    );

    if (message.containsKey('data')) {
      final dynamic data = message['data'];
      print("data $data");
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      print("notification $notification");
    }
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
    print("data $data");
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print("notification $notification");
  }

  // Or do other work.
}
