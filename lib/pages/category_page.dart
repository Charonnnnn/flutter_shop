import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import '../model/categorySubGoods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provide/child_category.dart';
import '../provide/category_goods_list.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'),),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            )
          ],
        ),
      ),
    );
  }

}

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    _getCategory();
    _getSubGoods();
    super.initState();
  }
  void _getCategory() async{
    await request('getCategory').then((val){
      var data = json.decode(val.toString());
      // print(data);
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto);

      // category.data.forEach((item)=> print(item.mallCategoryName));
    });
  }

  void _getSubGoods({String categoryId}) async{
    var data={
      'categoryId':categoryId==null? '4': categoryId,
      'CategorySubId':'',
      'page':1
    };

    await request('getMallGoods',formData: data).then((val){
      var data = json.decode(val.toString());
      // print(data);
      CategorySubGoodsModel categorySubGoods = CategorySubGoodsModel.fromJson(data);
      // setState(() {
      //   list = categorySubGoods.data;
      // });
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(categorySubGoods.data);

    });
  }

  Widget _leftInkWell(int index){
    bool isClick = false;
    isClick = (index == listIndex)? true : false;

    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
        _getSubGoods(categoryId:categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100.0),
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        decoration: BoxDecoration(
          color: isClick? Color.fromRGBO(236, 236, 236, 1.0): Colors.white,
          border: Border(bottom: BorderSide(width: 1.0,color: Colors.black12))
        ),
        child: Text(list[index].mallCategoryName, style: TextStyle(fontSize: ScreenUtil().setSp(28.0)),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180.0),
      decoration: BoxDecoration(border: Border(right: BorderSide(width: 1.0,color: Colors.black12))),
      child: ListView.builder(
        itemBuilder: (context,index){
          return _leftInkWell(index);
        },
        itemCount: list.length,
      ),
    );
  }
}


class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  
  // List list = ['名酒','二锅头','敬酒'];

  Widget _rightInkWell(BxMallSubDto item){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(item.mallSubName, style: TextStyle(fontSize: ScreenUtil().setSp(28.0)),),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context,child,childCategory){
        return Container(
          height: ScreenUtil().setHeight(80.0),
          width: ScreenUtil().setWidth(570.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.black12)
            )
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
              return _rightInkWell(childCategory.childCategoryList[index]);
            },
            itemCount: childCategory.childCategoryList.length,
          ),
        );
      },
    );
  }
}

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  // List list = [];

  @override
  void initState() {
    super.initState();
  }

  Widget _goodsImage(List newList, index){
    return Container(
      width: ScreenUtil().setWidth(200.0),
      child: Image.network(newList[index].image),
    );
  }
  Widget _goodsName(List newList, index){
    return Container(
      width: ScreenUtil().setWidth(370.0),
      padding: EdgeInsets.all(5.0),
      child: Text(
        newList[index].goodsName, 
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28.0)),
      ),
    );
  }
    Widget _goodsPrice(List newList, index){
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370.0),
      padding: EdgeInsets.all(5.0),
      child: Row(children: <Widget>[
        Text(
          '价格: \$${newList[index].presentPrice}', 
          style: TextStyle(fontSize: ScreenUtil().setSp(30.0),color: Colors.pink),
        ),
        Text(
          '\t\t\t\$${newList[index].oriPrice}', 
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: ScreenUtil().setSp(21.0),color: Colors.grey, decoration: TextDecoration.lineThrough),
        ),
      ],),
    );
  }

  Widget _listIteminkWell(List newList, int index){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(newList,index),
            Column(children: <Widget>[
              _goodsName(newList,index),
              _goodsPrice(newList,index),
            ],)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context,child,data){
        return Container(
          width: ScreenUtil().setWidth(570.0),
          height: ScreenUtil().setHeight(978.0),
          child: ListView.builder(
            itemCount: data.goodsList.length,
            itemBuilder: (context,index){
              return _listIteminkWell(data.goodsList,index);
            },
          ),
        );
      },
    );
  }
}


