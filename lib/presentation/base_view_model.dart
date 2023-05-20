import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool isBusy = false;

  setBusy() {
    isBusy = true;
    notifyListeners();
  }

  setIdle() {
    isBusy = false;
    notifyListeners();
  }
}
