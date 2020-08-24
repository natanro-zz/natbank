import 'package:flutter/material.dart';

class LoginInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;

  LoginInputField({
    @required this.icon,
    @required this.hintText,
    this.controller,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.0),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Icon(
              this.icon,
              color: Colors.grey,
            ),
          ),
          Container(
            height: 30,
            width: 1,
            color: Colors.grey.withOpacity(0.5),
            margin: EdgeInsets.only(left: 10, right: 10),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: this.hintText,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              controller: this.controller,
              keyboardType: this.keyboardType,
              textCapitalization: this.textCapitalization,
              obscureText: this.obscureText,
            ),
          )
        ],
      ),
    );
  }
}