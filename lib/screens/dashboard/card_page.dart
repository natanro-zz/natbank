import 'package:flutter/material.dart';

import 'account_card.dart';
import 'credit_card.dart';
import 'dash_card.dart';

class CardPage extends StatelessWidget {
  final double top;
  final ValueChanged<int> onChanged;
  final bool showMenu;

  const CardPage({
    Key key,
    @required this.top,
    @required this.onChanged,
    @required this.showMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      top: top,
      height: MediaQuery.of(context).size.height * .53,
      left: 0,
      right: 0,
      child: PageView(
        physics:
            showMenu ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        onPageChanged: onChanged,
        children: <Widget>[
          AppCard(
            child: AccountCard(),
          ),
          AppCard(
            child: CreditCard(),
          ),
        ],
      ),
    );
  }
}
