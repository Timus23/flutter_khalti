import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_khalti/common/custom_exception.dart';
import 'package:flutter_khalti/common/khalti_error.dart';
import 'package:flutter_khalti/common/khalti_payment.dart';
import 'package:flutter_khalti/common/khalti_result.dart';

class FlutterKhalti {
  static const MethodChannel _channel = const MethodChannel('flutter_khalti');

  static Future<String?> makePayment({required KhaltiPayment payment}) async {
    try {
      _registerKhaltiCallback(payment);
      await _channel.invokeMethod('initKhaltiPayment', payment.toJson());
    } catch (e) {
      throw KhaltiException(e.toString());
    }
  }

  static Future<String> get testPublicKey async {
    try {
      final res = await _channel.invokeMethod('testPublicKey');
      return res.toString();
    } catch (e) {
      throw KhaltiException(e.toString());
    }
  }

  static _registerKhaltiCallback(KhaltiPayment payment) {
    _channel.setMethodCallHandler((call) {
      switch (call.method) {
        case "khalti_success":
          {
            Map<String, dynamic> _successMessage =
                Map<String, dynamic>.from(call.arguments);
            payment.onSuceess(KhaltiResult.fromJson(_successMessage));
            break;
          }
        case "khalti_error":
          {
            Map<String, dynamic> _errorMessage =
                Map<String, dynamic>.from(call.arguments);
            payment.onError(KhaltiError.fromJson(_errorMessage));
            break;
          }
      }
      return Future.value({});
    });
  }
}
