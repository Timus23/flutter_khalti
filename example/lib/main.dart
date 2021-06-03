import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:flutter_khalti/common/khalti_payment.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () async {
              final _key = await FlutterKhalti.testPublicKey;
              final payment = KhaltiPayment(
                onError: (error) {
                  print(error);
                },
                onSuceess: (res) {
                  print(res);
                },
                productAmount: 100,
                productID: "id",
                productName: "test product",
                publicKey: _key,
              );
              FlutterKhalti.makePayment(payment: payment);
            },
            child: Image.asset(
              "assets/khalti_logo.png",
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
