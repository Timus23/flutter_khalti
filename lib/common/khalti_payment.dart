import 'package:flutter/foundation.dart';

class KhaltiPayment {
  String publicKey;
  String productID;
  String productName;
  double productAmount;
  ValueChanged<Map<String, dynamic>> onSuceess;
  ValueChanged<Map<String, dynamic>> onError;

  KhaltiPayment({
    required this.publicKey,
    required this.productID,
    required this.productAmount,
    required this.productName,
    required this.onError,
    required this.onSuceess,
  });

  Map<String, dynamic> toJson() {
    return {
      "publicKey": this.publicKey,
      "productName": this.productName,
      "productID": this.productID,
      "productAmount": this.productAmount,
    };
  }
}
