import 'dart:async';

import 'package:flutter/services.dart';

class UssdAdvanced2 {
  static const _channel = MethodChannel('com.example.baca');

  static Future<void> teste() async {
    await _channel.invokeMethod('showtoast');
  }
}
