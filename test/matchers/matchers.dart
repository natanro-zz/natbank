// can be used to find others FeatureItems such as Pagar e Feed de Transferências
import 'package:flutter/material.dart';
import 'package:natbank/screens/dashboard/feature_item.dart';

bool featureItemMatcher(Widget widget, String name, IconData icon) {
  return widget is FeatureItem && widget.icon == icon && widget.name == name;
}

bool textFieldMatcher(Widget widget, String labelText) {
  return widget is TextField && widget.decoration.labelText == labelText;
}
