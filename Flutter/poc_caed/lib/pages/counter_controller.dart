import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CounterController extends ChangeNotifier {
  int _count = 0;
  int get getCount => _count;

  void increment() {
    if (_count >= 0) {
      _count++;
    }
    notifyListeners();
  }

  void decrease() {
    if (_count > 0) {
      _count--;
    }
    notifyListeners();
  }
}
