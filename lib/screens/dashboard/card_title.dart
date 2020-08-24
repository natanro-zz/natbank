import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const CardTitle({
    Key key,
    @required this.title,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.grey[600],
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
        ],
      ),
    );
  }
}
