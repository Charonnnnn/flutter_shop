import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provide/provide.dart';

class CartBottom extends StatelessWidget {
  Widget _selectAllButton(context) {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: Provide.value<CartProvide>(context).isAllselected,
            activeColor: Colors.pink,
            onChanged: (bool val) {
              Provide.value<CartProvide>(context).changeSelectAll(val);
            },
          ),
          Text('Select All')
        ],
      ),
    );
  }

  Widget _allPriceCenter(context) {
    return Container(
      width: ScreenUtil().setWidth(360),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(160),
                child: Text(
                  'Total: ',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36.0),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(200),
                child: Text(
                  '\$ ${Provide.value<CartProvide>(context).totalPrice}',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36.0),
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(360),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费, 预购免配送费',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(22.0),
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sumPrice(context) {
    return Container(
        width: ScreenUtil().setWidth(160),
        padding: EdgeInsets.only(left: 10.0),
        child: InkWell(
          onTap: () {
            
          },
          child: Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Text(
              '结算(${Provide.value<CartProvide>(context).totalGoodsCount})',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(750.0),
        padding: EdgeInsets.all(5.0),
        color: Colors.white,
        child: Provide<CartProvide>(
          builder: (context, child, val) {
            return Row(
              children: <Widget>[
                _selectAllButton(context),
                _allPriceCenter(context),
                _sumPrice(context),
              ],
            );
          },
        ));
  }
}
