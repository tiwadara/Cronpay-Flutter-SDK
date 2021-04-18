

import 'package:flutter/services.dart';

class MethodChannelConstants {
  static const MethodChannel CHANNEL = const MethodChannel('plugins.wilburt/flutter_paystack');
  static const String METHOD_DIRECT_DEPOSIT = "dp";
  static const String METHOD_CARD = "card";
  static const String METHOD_INITIALIZE = "initialize";
  static const String METHOD_SEND_SUCCESS_CALLBACK= "send_success_call_back";
  static const String METHOD_SEND_CLOSE_CALLBACK= "send_close_call_back";
}