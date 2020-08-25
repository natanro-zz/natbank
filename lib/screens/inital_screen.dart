import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:natbank/screens/dashboard/dashboard.dart';
import 'package:natbank/services/session.dart';

import 'login/login.dart';

class InitialScreen extends StatefulWidget {
  BuildContext context;

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.blue[800],
    ));
    startApp();
  }

  // TODO: a quem pertence esta sessão?
  Future<void> startApp() {
    final session = Session();
    Future.delayed(
      Duration(seconds: 2),
      () {
        session.isUserAuthenticated().then((value) {
          if (value) {
            Navigator.of(widget.context).pushReplacement(
                MaterialPageRoute(builder: (context) => Dashboard()));
          } else {
            Navigator.of(widget.context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()));
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.context = context;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              'images/natbank_logo.png',
            ),
          ),
        ),
      ),
    );
  }
}
