import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cartInfo.dart';
import './cart_count.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartItem extends StatelessWidget {  
  final CartInfoModel item;
  CartItem(this.item);

  Widget _itemButton(context, item){
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val){
          item.isCheck = val;
          Provide.value<CartProvide>(context).changeCheckState(item);
        },
      ),
    ); 
  }

  Widget _itemImage(){
    return Container(
      width: ScreenUtil().setWidth(150.0),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.black12),
      ),
      child: Image.network(item.images),
    );
  }

  Widget _itemName(){
    return Container(
      width: ScreenUtil().setWidth(300.0),
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          CartCount(item),
        ],
      ),
    );
  }

  Widget _itemPrice(context, item){
    return Container(
      width: ScreenUtil().setWidth(150.0),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('\$${item.price}'),
          Container(
            child: InkWell(
              onTap: (){
                Provide.value<CartProvide>(context).deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(item);
    return Container(
      width: ScreenUtil().setWidth(750.0),
      margin: EdgeInsets.fromLTRB(5.0,2.0,5.0,2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black12)
        ),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          _itemButton(context, item),
          _itemImage(),
          _itemName(),
          _itemPrice(context, item),
        ],
      ),
    );
  }
}