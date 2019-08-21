import 'package:flutter/material.dart';


class Counter with ChangeNotifier{  // 不用管理听众, 谁都可以获得这个类的值
  int value = 0;

  increment(){
    value++;
    notifyListeners(); // 有变化后通知听众, 局部刷新
  }
}