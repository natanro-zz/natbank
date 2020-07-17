import 'package:flutter/material.dart';
import 'package:natbank/dao/contact_dao.dart';
import 'package:natbank/http/webclients/transactions_webclient.dart';

class AppDependencies extends InheritedWidget {
  final ContactDAO contactDAO;
  final TransactionsWebClient transactionsWebClient;

  AppDependencies({
    @required this.contactDAO,
    @required this.transactionsWebClient,
    @required child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(AppDependencies oldWidget) =>
      contactDAO != oldWidget.contactDAO ||
      transactionsWebClient != oldWidget.transactionsWebClient;

  static AppDependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>();
}
