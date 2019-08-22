import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{  // 不用管理听众, 谁都可以获得这个类的值
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; // 子类高亮索引
  String categoryId = '4'; // 默认大类ID
  String subId = ''; // 小类ID, 默认为空
  int page = 1; // 页数, 默认为1
  String noMoreText = '';

  getChildCategory(List<BxMallSubDto> list, String id){
    childIndex = 0;  // 点击大类切换道第一索引
    categoryId = id;
    page = 1; // 切换大类 切换到第一页
    noMoreText = '';

    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';

    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners(); // 有变化后通知听众, 局部刷新
  }

  // 改变子类索引
  changeChildIndex(index, String id){
    page = 1; // 切换小类 切换到第一页
    noMoreText = '';

    subId = id;
    childIndex = index;
    notifyListeners();
  }

  // 增加页数
  addPage(){
    page++;
    // notifyListeners();
  }
  changeNoMoreText(String text){
    noMoreText = text;
    notifyListeners();
  }

}