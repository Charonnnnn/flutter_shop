import 'package:flutter/material.dart';
import '../model/categorySubGoods.dart';

class CategoryGoodsListProvide with ChangeNotifier{  // 不用管理听众, 谁都可以获得这个类的值
  List<CategorySubGoodsData> goodsList = [];

  getGoodsList(List<CategorySubGoodsData> list){
    goodsList = list;
    notifyListeners(); // 有变化后通知听众, 局部刷新
  }

  getMoreList(List<CategorySubGoodsData> list){
    goodsList.addAll(list);
    notifyListeners(); // 有变化后通知听众, 局部刷新
  }
}