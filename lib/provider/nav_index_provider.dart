import 'package:flutter/material.dart';

class NavIndexProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(index) {
    _selectedIndex = index;
    notifyListeners();
  } 
  
}