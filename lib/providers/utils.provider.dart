import 'package:flutter/material.dart';

class UtilsStateNotifier extends ChangeNotifier {
  int _activeTab = 0;
  int get activeTab => _activeTab;
  void changeTab(int tab) {
    _activeTab = tab;
    notifyListeners();
  }

  //Bottom toolbar state.
  late int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
