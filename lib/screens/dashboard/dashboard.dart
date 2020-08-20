import 'package:flutter/material.dart';
import 'package:natbank/screens/contact_list.dart';
import 'package:natbank/screens/dashboard/card_page.dart';
import 'package:natbank/screens/dashboard/dash_menu.dart';
import 'package:natbank/screens/dashboard/page_dots.dart';
import 'package:natbank/screens/transactions_list.dart';

import 'app_bar.dart';
import 'feature_item_list.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _showMenu;
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _showMenu = false;
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor /*Colors.blue[300]*/,
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          DashboardAppBar(
            showMenu: _showMenu,
            onTap: () {
              setState(() {
                _showMenu = !_showMenu;
              });
            },
          ),
          Menu(
            showMenu: _showMenu,
            top: _screenHeight * 0.2,
          ),
          CardPage(
            top: _showMenu ? _screenHeight * 0.8 : _screenHeight * 0.2,
            onChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            showMenu: _showMenu,
          ),
          PageDots(
            currentIndex: _currentIndex,
            top: _screenHeight * 0.73,
            showMenu: _showMenu,
          ),
          FeatureItemList(
            height: _screenHeight * 0.15,
            showMenu: _showMenu,
          ),
        ],
      ),
    );
  }

  void _showContactsList(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ContactList()));
  }

  _showTransactionsList(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TransactionsList()));
  }
}
