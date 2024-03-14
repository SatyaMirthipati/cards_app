import 'package:flutter/material.dart';

class MainBloc with ChangeNotifier {
  int index = 0;
  int tab = 0;

  int _selectedIndex = 1;
  bool customTabSwitch = false;
  late TabController tabController;

  void updateIndex(int value) {
    index = value;
    notifyListeners();
  }

  void updateTab(int index) {
    tab = index;
    notifyListeners();
  }

  set selectedIndex(int value) {
    _selectedIndex = value;
    tabController.animateTo(value - 1);
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;

  void resetIndex() {
    _selectedIndex = 1;
  }
}
