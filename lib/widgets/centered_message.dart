import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  final IconData icon;
  final String message;

  const CenteredMessage(
    this.message, {
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            child: Icon(
              icon,
            ),
            visible: icon != null,
          ),
          Text(message),
        ],
      ),
    );
  }
}
