import 'package:flutter/material.dart';
import 'package:natbank/dao/account_dao.dart';
import 'package:natbank/dao/contact_dao.dart';
import 'package:natbank/dao/user_dao.dart';
import 'package:natbank/http/webclients/account_webclient.dart';
import 'package:natbank/http/webclients/transactions_webclient.dart';
import 'package:natbank/widgets/app_dependencies.dart';

import 'screens/inital_screen.dart';

void main() {
  runApp(NatBankApp(
    contactDAO: ContactDAO(),
    transactionsWebClient: TransactionsWebClient(),
    userDAO: UserDAO(),
    accountWebClient: AccountWebClient(),
    accountDAO: AccountDAO(),
  ));
}

class NatBankApp extends StatelessWidget {
  final ContactDAO contactDAO;
  final TransactionsWebClient transactionsWebClient;
  final UserDAO userDAO;
  final AccountWebClient accountWebClient;
  final AccountDAO accountDAO;

  NatBankApp({
    @required this.contactDAO,
    @required this.transactionsWebClient,
    @required this.userDAO,
    @required this.accountWebClient,
    @required this.accountDAO,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDAO: contactDAO,
      transactionsWebClient: transactionsWebClient,
      userDAO: userDAO,
      accountWebClient: accountWebClient,
      accountDAO: accountDAO,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue[800],
          accentColor: Colors.white,
        ),
        home: InitialScreen(),
      ),
    );
  }
}
