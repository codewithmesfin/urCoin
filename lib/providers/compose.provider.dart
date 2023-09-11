import 'package:flutter/material.dart';

class ComposeProvider with ChangeNotifier {
  bool _isButtonExpanded = true;

  bool get isButtonExpanded => _isButtonExpanded;

  void updateButtonExpansion(bool newValue) {
    _isButtonExpanded = newValue;
    notifyListeners();
  }
}
