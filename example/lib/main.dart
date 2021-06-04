import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:flutter_khalti/common/khalti_payment.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
                  Fluttertoast.showToast(
                    msg: "Somethiing went wrong!!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                onSuceess: (res) {
                  Fluttertoast.showToast(
                    msg: res.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
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
