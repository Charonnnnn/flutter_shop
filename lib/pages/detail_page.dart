import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  Future _getBackInfor(BuildContext context) async{
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    // print('加载完成....');
    return '完成加载';
  }

  @override
  Widget build(BuildContext context) {
    _getBackInfor(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('商品详细页'),
      ),
      body: FutureBuilder(
        future: _getBackInfor(context),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Container(
              child: Column(
                children: <Widget>[
                  Text('${goodsId}'),
                ],
              ),
            );
          }else{
            return Text('加载中...');
          }
        },
      ),
    );
  }
}