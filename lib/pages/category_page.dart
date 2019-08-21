import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import '../model/categorySubGoods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provide/child_category.dart';
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

  Widget _leftInkWell(int index){
    bool isClick = false;
    isClick = (index == listIndex)? true : false;

    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
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



// void _getSubGoods() async{
//   var data={
//     'categoryId':'4',
//     'CategorySubId':'',
//     'page':1
//   };

//   await request('getMallGoods',formData: data).then((val){
//     var data = json.decode(val.toString());
//     // print(data);
//     CategoryModel category = CategoryModel.fromJson(data);
//     setState(() {
//       list = category.data;
//     });
//     Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto);

//   });
// }