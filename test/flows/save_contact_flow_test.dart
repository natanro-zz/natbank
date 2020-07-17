import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:natbank/main.dart';
import 'package:natbank/screens/contact_form.dart';
import 'package:natbank/screens/contact_list.dart';
import 'package:natbank/screens/dashboard.dart';

import '../events/events.dart';
import '../matchers/matchers.dart';
import '../mocks/mocks.dart';

void main() {
  testWidgets('Should save a contact', (tester) async {
    final MockContactDAO mockContactDAO = MockContactDAO();
    final mockTransactionWebClient = MockTransactionWebClient();

    await tester.pumpWidget(NatBankApp(
      contactDAO: mockContactDAO,
      transactionsWebClient: mockTransactionWebClient,
    ));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clickOnTransferFeatureItem(tester);
    await tester.pumpAndSettle();
    final contactList = find.byType(ContactList);
    expect(contactList, findsOneWidget);

    verify(mockContactDAO.findAll()).called(1);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField =
        find.byWidgetPredicate((widget) => textFieldMatcher(widget, 'Nome'));
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, 'Natan');

    final accountNumberField = find.byWidgetPredicate(
        (widget) => textFieldMatcher(widget, 'Número da conta'));
    expect(accountNumberField, findsOneWidget);
    await tester.enterText(nameTextField, '1234');

    // verify(mockContactDAO.save(Contact(0, 'Natan', 1234)));

    final createButton = find.widgetWithText(RaisedButton, 'Salvar');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    final contactListBack = find.byType(ContactList);
    expect(contactListBack, findsOneWidget);

    verify(mockContactDAO.findAll()).called(1);
  });
}
