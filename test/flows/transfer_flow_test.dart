import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:natbank/main.dart';
import 'package:natbank/models/contact.dart';
import 'package:natbank/widgets/response_dialog.dart';
import 'package:natbank/models/transaction.dart';
import 'package:natbank/widgets/transaction_auth_dialog.dart';
import 'package:natbank/screens/contact_list.dart';
import 'package:natbank/screens/dashboard.dart';
import 'package:natbank/screens/transaction_form.dart';

import '../events/events.dart';
import '../matchers/matchers.dart';
import '../mocks/mocks.dart';

void main() {
  testWidgets('Should transfer to a contact', (tester) async {
    final MockContactDAO mockContactDAO = MockContactDAO();
    final MockTransactionWebClient mockTransactionWebClient =
        MockTransactionWebClient();

    await tester.pumpWidget(NatBankApp(
      contactDAO: mockContactDAO,
      transactionsWebClient: mockTransactionWebClient,
    ));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    var natanContact = Contact(0, 'Natan', 1000);
    when(mockContactDAO.findAll())
        .thenAnswer((realInvocation) async => [natanContact]);

    await clickOnTransferFeatureItem(tester);
    await tester.pumpAndSettle();
    final contactList = find.byType(ContactList);
    expect(contactList, findsOneWidget);

    verify(mockContactDAO.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget) =>
        widget is ContactItem &&
        widget.contact.name == 'Natan' &&
        widget.contact.accountNumber == 1000);
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final contactName = find.text('Natan');
    expect(contactName, findsOneWidget);
    final contactAccountNumber = find.text('1000');
    expect(contactAccountNumber, findsOneWidget);

    final textFieldValue =
        find.byWidgetPredicate((widget) => textFieldMatcher(widget, 'Valor'));
    expect(textFieldValue, findsOneWidget);
    await tester.enterText(textFieldValue, '10');

    final transferButton = find.widgetWithText(RaisedButton, 'Transferir');
    expect(transferButton, findsOneWidget);
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);
    final textFieldPassword = find.byKey(transactionAuthDialogTextFieldKey);
    expect(textFieldPassword, findsOneWidget);
    await tester.enterText(textFieldPassword, '1000');

    final cancelButton = find.widgetWithText(FlatButton, 'Cancelar');
    expect(cancelButton, findsOneWidget);
    final confirmButton = find.widgetWithText(FlatButton, 'Confirmar');
    expect(confirmButton, findsOneWidget);

    when(mockTransactionWebClient.save(
            Transaction(null, 10, natanContact), '1000'))
        .thenAnswer((_) async => Transaction(null, 10, natanContact));

    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final okButton = find.widgetWithText(FlatButton, 'Ok');
    expect(okButton, findsOneWidget);
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    final contactListBack = find.byType(ContactList);
    expect(contactListBack, findsOneWidget);
  });
}
