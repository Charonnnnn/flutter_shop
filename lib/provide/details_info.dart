import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier{

  DetailsModel goodsInfo = null;

  // 从后台获取数据
  getGoodsInfo(String id){
    var fromData = {'goodId':id};
    request('getGoodDetailById',formData: fromData).then((val){
      var responseData = json.decode(val.toString());  // 变成Map
      print(responseData);
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }


}