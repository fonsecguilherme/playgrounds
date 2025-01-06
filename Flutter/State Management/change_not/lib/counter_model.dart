import 'dart:developer';

import 'package:flutter/material.dart';

class CounterModel extends ChangeNotifier {
  int _count = 27;
  void increment() {
    _count++;
    log(_count.toString());
    notifyListeners();
  }

  int get count => _count;
}
