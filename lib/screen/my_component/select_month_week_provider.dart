import 'package:flutter/material.dart';
class MonthWeekProvider extends ChangeNotifier {
  String _selectedMonthWeek = "month"; // default value is month

  String get selectedMonthWeek => _selectedMonthWeek;

  void updateSelectedMonthWeek(String newMonthWeek) {
    _selectedMonthWeek = newMonthWeek;
    notifyListeners();
  }
}