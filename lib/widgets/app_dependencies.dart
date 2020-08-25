import 'package:flutter/material.dart';
import 'package:natbank/database/dao/account_dao.dart';
import 'package:natbank/database/dao/contact_dao.dart';
import 'package:natbank/database/dao/user_dao.dart';
import 'package:natbank/http/webclients/account_webclient.dart';
import 'package:natbank/http/webclients/transactions_webclient.dart';

class AppDependencies extends InheritedWidget {
  final ContactDAO contactDAO;
  final TransactionsWebClient transactionsWebClient;
  final UserDAO userDAO;
  final AccountWebClient accountWebClient;
  final AccountDAO accountDAO;

  AppDependencies({
    @required this.contactDAO,
    @required this.transactionsWebClient,
    @required this.userDAO,
    @required this.accountWebClient,
    @required this.accountDAO,
    @required child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(AppDependencies oldWidget) =>
      contactDAO != oldWidget.contactDAO ||
      transactionsWebClient != oldWidget.transactionsWebClient ||
      userDAO != oldWidget.userDAO ||
      accountWebClient != oldWidget.accountWebClient ||
      accountDAO != oldWidget.accountDAO;

  static AppDependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>();
}
