import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740.0),
    );
  }

  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(740.0),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(35.0),
        ),
      ),
    );
  }

  Widget _goodsNumber(num) {
    return Container(
      width: ScreenUtil().setWidth(730.0),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '编号: ${num}',
        style: TextStyle(
          color: Colors.black12,
          fontSize: ScreenUtil().setSp(25.0),
        ),
      ),
    );
  }

  Widget _goodsPrice(pprice, oprice) {
    return Container(
        width: ScreenUtil().setWidth(730.0),
        padding: EdgeInsets.only(left: 15.0),
        margin: EdgeInsets.only(top: 8.0),
        child: Row(
          children: <Widget>[
            Text(
              '\$ ${pprice}',
              style: TextStyle(
                color: Colors.red,
                fontSize: ScreenUtil().setSp(27.0),
              ),
            ),
            Text(
              '\t\t\t\t市场价:\$ ${oprice}',
              style: TextStyle(
                color: Colors.black26,
                fontSize: ScreenUtil().setSp(27.0),
                decoration: TextDecoration.lineThrough
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        var goodsInfo =
            Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;

        if (goodsInfo != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNumber(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice),
              ],
            ),
          );
        } else {
          return Text('正在加载中');
        }
      },
    );
  }
}
