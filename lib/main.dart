import 'package:flutter/material.dart';
import 'package:natbank/dao/account_dao.dart';
import 'package:natbank/dao/contact_dao.dart';
import 'package:natbank/dao/user_dao.dart';
import 'package:natbank/http/webclients/account_webclient.dart';
import 'package:natbank/http/webclients/transactions_webclient.dart';
import 'package:natbank/screens/dashboard/dashboard.dart';
import 'package:natbank/screens/login.dart';
import 'package:natbank/services/auth_token.dart';
import 'package:natbank/widgets/app_dependencies.dart';

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
        ),
        home: Dashboard(),
//        home: FutureBuilder<Widget>(
//          future: homeWidget(),
//          initialData: InitalWidget(),
//          builder: (context, snapshot) {
//            if(snapshot.connectionState == ConnectionState.done) {
//              return snapshot.hasData ? snapshot.data : InitalWidget();
//            } else {
//              return InitalWidget();
//            }
//          },
      ),
    );
  }

  Future<Widget> homeWidget() async {
    final authToken = AuthenticationToken();
    if (await authToken.isUserAuthenticated())
      return Dashboard();
    else
      return Login();
  }
}

// TODO: user session

class InitalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              'images/natbank_lightBlue500.png',
            ),
          ),
        ),
      ),
    );
  }
}

