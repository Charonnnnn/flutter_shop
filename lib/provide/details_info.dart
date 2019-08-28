import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier{

  DetailsModel goodsInfo = null;

  bool isLeft = true;
  bool isRight = false;

  //tabbar的切换
  changeLeftAndRight(String changeState){
    if(changeState == 'left'){
      isLeft = true;
      isRight = false;
    }else{
      isLeft = false;
      isRight = true; 
    }
    notifyListeners();
  }

  // 从后台获取数据
  getGoodsInfo(String id) async{
    var fromData = {'goodId':id};
    await request('getGoodDetailById',formData: fromData).then((val){
      var responseData = json.decode(val.toString());  // 变成Map
      print(responseData);
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }


}