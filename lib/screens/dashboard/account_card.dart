import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'card_title.dart';

class AccountCard extends StatefulWidget {
  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> with AutomaticKeepAliveClientMixin {
  bool _balanceVisibility;

  @override
  void initState() {
    super.initState();
    _balanceVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardTitle(
                        icon: Icons.account_balance_wallet,
                        title: 'Conta bancária',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _balanceVisibility = !_balanceVisibility;
                            });
                          },
                          child: SvgPicture.asset(
                            !_balanceVisibility
                                ? 'images/icons/visibility-24px.svg'
                                : 'images/icons/visibility_off-24px.svg',
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AccountCardContent(
                    balanceVisibility: _balanceVisibility,
                  ),
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
                    SvgPicture.asset(
                      'images/icons/bank-transfer-in.svg',
                      color: Colors.grey[600],
                    ),
                    SizedBox(
                      width: 16,
                    ),
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

  @override
  bool get wantKeepAlive => true;
}

class AccountCardContent extends StatelessWidget {
  final bool balanceVisibility;

  const AccountCardContent({Key key, @required this.balanceVisibility})
      : super(key: key);

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
              'Saldo disponível',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(
              height: 8,
            ),
            balanceVisibility
                ? Text(
                    'R\$ 0,00',
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
                  )
                : Container(
                    height: 40,
                    width: 160,
                    color: Colors.grey[300],
                  ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
