import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{  // 不用管理听众, 谁都可以获得这个类的值
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List<BxMallSubDto> list){
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';

    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners(); // 有变化后通知听众, 局部刷新
  }
}