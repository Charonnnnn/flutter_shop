import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';
import './detail_page/details_top_area.dart';
import './detail_page/details_explain.dart';
import './detail_page/details_tabbar.dart';
import './detail_page/details_web.dart';
import './detail_page/details_bottom.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  Future _getBackInfor(BuildContext context) async {
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('商品详细页'),
      ),
      body: FutureBuilder(
        future: _getBackInfor(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      // Text('${goodsId}'),
                      DetailsTopArea(),
                      DetailsExplain(),
                      DetailTabbar(),
                      DetailsWeb(),
                      
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailsBottom(),
                ),
              ],
            );
          } else {
            return Text('加载中...');
          }
        },
      ),
    );
  }
}
