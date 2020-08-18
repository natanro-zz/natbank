import 'package:flutter/material.dart';

class DashboardAppBar extends StatelessWidget {
  final bool showMenu;
  final VoidCallback onTap;

  DashboardAppBar({@required this.showMenu, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        GestureDetector(
          onTap: this.onTap,
          child: Container(
            color: Theme.of(context).primaryColor,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/logo_letters.png',
                      scale: 11,
                    ),
                    Text(
                      'Natan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                Icon(
                  showMenu ? Icons.expand_less : Icons.expand_more,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
