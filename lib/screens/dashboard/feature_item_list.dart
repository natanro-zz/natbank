import 'package:flutter/material.dart';

import 'feature_item.dart';

class FeatureItemList extends StatelessWidget {
  final double height;
  final bool showMenu;

  const FeatureItemList({Key key, @required this.height, this.showMenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom,
      left: 0,
      right: 0,
      height: height,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: showMenu ? 0.0 : 1.0,
        child: Container(
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: showMenu ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
            children: <Widget>[
              FeatureItem(icon: Icons.monetization_on, name: 'Transferir',),
              FeatureItem(icon: Icons.attach_money, name: 'Cobrar',),
              FeatureItem(icon: Icons.money_off, name: 'Pagar',),
              FeatureItem(icon: Icons.info_outline, name: 'Me ajuda'),
              FeatureItem(icon: Icons.money_off, name: 'Dividir valor'),
              FeatureItem(icon: Icons.reorder, name: 'Organizar atalhos'),
            ],
          ),
        ),
      ),
    );
  }
}
