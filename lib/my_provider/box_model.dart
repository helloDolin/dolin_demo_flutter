import 'package:flutter/material.dart';

class BoxModel extends ChangeNotifier {
  double _size = 100;
  double get size => _size;
  set size(double value) {
    _size = value;
    notifyListeners();
  }
}
