import 'package:flutter/foundation.dart';
import 'package:flutter_khalti/common/khalti_error.dart';
import 'package:flutter_khalti/common/khalti_result.dart';

class KhaltiPayment {
  String publicKey;
  String productID;
  String productName;
  double productAmount;
  String urlSchemeIOS;
  ValueChanged<KhaltiResult> onSuceess;
  ValueChanged<KhaltiError> onError;

  KhaltiPayment({
    required this.publicKey,
    required this.productID,
    required this.productAmount,
    required this.productName,
    required this.onError,
    required this.onSuceess,
    this.urlSchemeIOS = "KhaltiPayExampleScheme",
  });

  Map<String, dynamic> toJson() {
    return {
      "publicKey": this.publicKey,
      "productName": this.productName,
      "productID": this.productID,
      "productAmount": this.productAmount,
      "urlSchemeIOS": this.urlSchemeIOS,
    };
  }
}
