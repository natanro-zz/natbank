import 'package:flutter/material.dart';

import 'card_title.dart';

class CreditCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CardTitle(
                          icon: Icons.credit_card,
                          title: 'Cartão de crédito',
                        ),
                        CreditCardContent(),
                      ],
                    ),
                  ),
                  CreditCardLateralBar(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.shopping_cart, color: Colors.grey[600],),
                    SizedBox(width: 16,),
                    Text(
                      'Sem compras recentes',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CreditCardContent extends StatelessWidget {
  const CreditCardContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'FATURA ATUAL',
              style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text.rich(
              TextSpan(
                text: 'R\$',
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.cyan,
                    fontWeight: FontWeight.normal),
                children: [
                  TextSpan(
                    text: ' 0',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.cyan),
                  ),
                  TextSpan(
                    text: ',00',
                    style: TextStyle(
                        color: Colors.cyan, fontStyle: FontStyle.normal),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text.rich(
              TextSpan(
                text: 'Limite disponível',
                style: TextStyle(fontSize: 16),
                children: [
                  TextSpan(
                      text: '  R\$ 0,00',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreditCardLateralBar extends StatelessWidget {
  const CreditCardLateralBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          width: 7,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.orange,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
