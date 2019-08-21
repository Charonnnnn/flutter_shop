import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




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
      // category.data.forEach((item)=> print(item.mallCategoryName));
    });
  }

  Widget _leftInkWell(int index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(100.0),
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
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
