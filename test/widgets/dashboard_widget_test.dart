import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:natbank/screens/dashboard/dashboard.dart';

import '../matchers/matchers.dart';

void main() {
  group('When dashboard is opened', () {
    testWidgets("Should display the main image", (tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      final mainImage = find.byType(Image);
      expect(mainImage, findsOneWidget);
    });

    testWidgets("Should display Transferir feature", (tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      final transferFeature = find.byWidgetPredicate((widget) =>
          featureItemMatcher(widget, 'Transferir', Icons.monetization_on));
      expect(transferFeature, findsOneWidget);
    });

    testWidgets("Should display Pagar feature", (tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      final pagarFeature = find.byWidgetPredicate(
          (widget) => featureItemMatcher(widget, 'Pagar', Icons.payment));
      expect(pagarFeature, findsOneWidget);
    });
  });
}
