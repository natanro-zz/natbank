import 'package:flutter/material.dart';
import 'package:natbank/screens/dashboard.dart';

void main() {
  runApp(NatBankApp());
}

class NatBankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[800],
        accentColor: Colors.blue[900],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue[900],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Dashboard(),
    );
  }
}
