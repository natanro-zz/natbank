import 'package:flutter/material.dart';
import 'package:natbank/dao/contact_dao.dart';
import 'package:natbank/http/webclients/transactions_webclient.dart';
import 'package:natbank/screens/dashboard.dart';
import 'package:natbank/widgets/app_dependencies.dart';

void main() {
  runApp(NatBankApp(
    contactDAO: ContactDAO(),
    transactionsWebClient: TransactionsWebClient(),
  ));
}

class NatBankApp extends StatelessWidget {
  final ContactDAO contactDAO;
  final TransactionsWebClient transactionsWebClient;

  NatBankApp({
    @required this.contactDAO,
    @required this.transactionsWebClient,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDAO: contactDAO,
      transactionsWebClient: transactionsWebClient,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blue[800],
          accentColor: Colors.blue[900],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue[900],
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: Dashboard(),
      ),
    );
  }
}
