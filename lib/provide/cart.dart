import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModel> cartList = [];
  double totalPrice = 0; // 商品总价格
  int totalGoodsCount = 0; // 商品总数量
  bool isAllselected = true; //是否全选

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null
        ? []
        : json.decode(
            cartString.toString()); //JSON.decode()仅返回一个Map<String, dynamic>
    List<Map> tempList = (temp as List).cast(); // 转换成List
    bool isHave = false;
    int ival = 0;
    tempList.forEach((item) {
      // 如果商品已在购物车就数量加1
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }
      ival++;
    });
    // 如果商品不在购物车, 就加到购物车
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
    }

    cartString = json.encode(tempList).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);

    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList = [];
    print('清空完成=========');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      totalPrice = 0;
      totalGoodsCount = 0;
      isAllselected = true;
      tempList.forEach((item) {
        cartList.add(CartInfoModel.fromJson(item));
        if (item['isCheck']) {
          totalPrice += (item['count'] * item['price']);
          totalGoodsCount += item['count'];
        }else{
          isAllselected = false;
        }
      });
      notifyListeners();
    }
  }

  //删除单个购物车商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList =
        (json.decode(cartString.toString()) as List).cast(); // 转换成List
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo(); // 刷新model列表
  }

  //改变选择状态
  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList =
        (json.decode(cartString.toString()) as List).cast(); // 转换成List
    int tempIndex = 0;
    int checkedIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        checkedIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[checkedIndex] = cartItem.toJson(); // 转成Map
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo(); // 刷新model列表
  }

  //改变全选状态
  changeSelectAll(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast(); // 转换成List
    List<Map> newList = [];
    for(var item in tempList){
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }

    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo(); // 刷新model列表
  }

  //商品数量加减
  addReduceAction(var cartItem, String todo)async{
SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast(); // 转换成List

    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if(todo == 'add'){
      cartItem.count++;
    }else if(cartItem.count > 1){
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson(); // 转成Map

    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo(); // 刷新model列表
  }
}
