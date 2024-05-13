import 'package:flutter/material.dart';

class StandardDate with ChangeNotifier {
  DateTime _standardDate = DateTime.now();
  DateTime get standardDate => _standardDate;

  void changeDate(DateTime newDate) {
    _standardDate = newDate;
    notifyListeners();
  }
}
