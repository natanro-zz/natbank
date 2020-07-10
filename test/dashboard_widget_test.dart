import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:natbank/screens/dashboard.dart';

void main() {
  testWidgets("Should display the main image when Dashbord is opened",
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets("Should display Transferir feature when Dashboard is Open",
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    // final iconTransferFeatureIcon = find.widgetWithIcon(FeatureItem, Icons.monetization_on);
    // expect(iconTransferFeatureIcon, findsOneWidget);
    // final nameTransferFeatureItem = find.widgetWithText(FeatureItem, "Transferir");
    // expect(nameTransferFeatureItem, findsOneWidget);
    final transferFeature = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transferir', Icons.monetization_on));
  });
}

// can be used to find others FeatureItems such as Pagar e Feed de Transferências
bool featureItemMatcher(Widget widget, String name, IconData icon) {
  return widget is FeatureItem && widget.icon == icon && widget.name == name;
}
