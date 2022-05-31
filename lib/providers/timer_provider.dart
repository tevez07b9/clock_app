import 'package:flutter/cupertino.dart';

class TimerProvider with ChangeNotifier {
  int _timer = 0;
  List<int> _logs = [];

  int get timer => _timer;
  List<int> get logs => _logs;

  void increaseTimer(int val) {
    _timer = val;
    notifyListeners();
  }

  void insertLog(int val) {
    _logs.add(val);
    notifyListeners();
  }
}
