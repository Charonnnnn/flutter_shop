import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  
  int page = 1;
  List<Map> hotGoodsList = [];


  @override
  bool get wantKeepAlive => true;
  
  String homePageContent = '正在获取数据';

  @override
  void initState() {
    // getHomePageContent().then((val){
    //   setState(() {
    //     homePageContent = val.toString();
    //   });
    // });

    // _getHotGoods();
    print('1111111');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var formData = {'lon':'115.02932', 'lat':'35.76189'};
    
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: request('homePageContent',formData:formData),
        builder: (context,snapshot){
          if(snapshot.hasData){
            // 数据处理
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();  // 外面是list 里面是map
            List<Map> navigatorList = (data['data']['category'] as List).cast();  // 外面是list 里面是map
            String adPic = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderPic = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List<Map> recList = (data['data']['recommend'] as List).cast();
            String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor1Content = (data['data']['floor1'] as List).cast();
            List<Map> floor2Content = (data['data']['floor2'] as List).cast();
            List<Map> floor3Content = (data['data']['floor3'] as List).cast();

            return EasyRefresh(
              footer: ClassicalFooter(
                bgColor: Colors.white,
                textColor: Colors.pink,
                infoColor: Colors.pink,
                showInfo: true,
                noMoreText: '',
                infoText: '加载中',
                loadReadyText: '上拉加载中' 
              ),

              child: ListView(
                children: <Widget>[
                  SwiperDIY(swiperDataList:swiper),
                  TopNavigator(navigatorList: navigatorList,),
                  AdBanner(adPicture: adPic,),
                  LeaderPhone(leaderImage:leaderPic,leaderPhone:leaderPhone),
                  Recommend(recommendList:recList),
                  FloorTitle(pic_addr: floor1Title,),
                  FloorContent(floorGoodsList: floor1Content,),
                  FloorTitle(pic_addr: floor2Title,),
                  FloorContent(floorGoodsList: floor2Content,),
                  FloorTitle(pic_addr: floor3Title,),
                  FloorContent(floorGoodsList: floor3Content,),
                  _hotGoods(),
                ],
              ),
              onLoad: ()async{
                print('开始加载更多');
                var formData = {'page':page};
                await request('homePageBelowConten',formData: formData).then((val){
                  var data = json.decode(val.toString());
                  List<Map> newGoodsList = (data['data'] as List).cast();
                  setState(() {
                    hotGoodsList.addAll(newGoodsList);
                    page++;
                  });
                });
              }
            );
          }else{
            return Center(
              child: Text('加载中'),
            );
          }
        },
      ),
    );
  }

  // void _getHotGoods(){
  //   var formData = {'page':page};
  //   request('homePageBelowConten',formData: formData).then((val){
  //     var data = json.decode(val.toString());
  //     List<Map> newGoodsList = (data['data'] as List).cast();
  //     setState(() {
  //       hotGoodsList.addAll(newGoodsList);
  //       page++;
  //     });
  //   });
  // }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    padding: EdgeInsets.all(5.0),
    child: Text('热卖专区'),
  );

  Widget _wrapList(){
    if(hotGoodsList.length != 0){
      List<Widget> listWidget = hotGoodsList.map((val){
        return InkWell(
          onTap: (){},
          child: Container(
            width: ScreenUtil().setWidth(372.0),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(val['image'],width:ScreenUtil().setWidth(370)),
                Text(val['name'],maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(26.0)),),
                Row(children: <Widget>[
                  Text('\$${val['mallPrice']}\t\t\t'),
                  Text('\$${val['price']}',style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough),),
                ],)
              ],
            ),
          ),
        );
      }).toList();

      return Wrap( // 流式布局
        spacing: 2,
        children: listWidget,
      );
    }else{
      return Text('');
    }
  }

  Widget _hotGoods(){
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
      ),
    );
  }

}

class SwiperDIY extends StatelessWidget {

  final List swiperDataList;
  SwiperDIY({Key key, this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    print('设备宽度:${ScreenUtil.screenWidth}'); //Device width
    print('设备高度:${ScreenUtil.screenHeight}'); //Device height
    print('设备的像素密度:${ScreenUtil.pixelRatio}'); //Device pixel density

    return Container(
      height: ScreenUtil().setHeight(333.0),
      width: ScreenUtil.getInstance().setWidth(750.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return Image.network('${swiperDataList[index]['image']}',fit: BoxFit.fill,);
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {

  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item){
    return InkWell(
      onTap: (){print('点击导航');},
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width: ScreenUtil.getInstance().setWidth(95),),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(this.navigatorList.length > 10){
      this.navigatorList.removeRange(10,this.navigatorList.length);
    }

    return Container(
      height: ScreenUtil.getInstance().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),  //取消其回弹效果
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({Key key, this.adPicture}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture)
    );
  }
}

class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({
    Key key,
    this.leaderImage,
    this.leaderPhone,
  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _luanchURL,
      child: Image.network(leaderImage),
    );
  }

  void _luanchURL() async{
    String url = 'https://google.com';
    // String url = 'tel:' + leaderPhone;
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw '${url} 不能进行访问, 异常';
    }
  }
}

class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}):super(key:key);

  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12)
        )
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  Widget _item(index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(330.0),
        width: ScreenUtil().setHeight(250.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1.0,color: Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('${recommendList[index]['mallPrice']}'),
            Text('${recommendList[index]['price']}', style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),),
          ],
        ),
      ),
    );
  }

  Widget _recommendList(){
    return Container(
      height: ScreenUtil().setHeight(330.0),
      margin: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context,index){
          return _item(index);
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(386),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList()
        ],
      ),
    );
  }
}

class FloorTitle extends StatelessWidget {
  final String pic_addr;
  FloorTitle({this.pic_addr});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(pic_addr),
    );
  }
}
class FloorContent extends StatelessWidget {
  final List floorGoodsList;
  FloorContent({this.floorGoodsList});

  Widget _goodsItem(Map goods){
    return Container(
      width: ScreenUtil().setWidth(375.0),
      child: InkWell(
        onTap: (){print('点击了楼层商品');},
        child: Image.network(goods['image']),
      ),
    );
  }

  Widget _firstRow(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _firstRow(),
        _otherGoods(),
      ],
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import '../config/httpHeaders.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     getHttp();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HomePage'),
//         elevation: 0.0,
//       ),
//       body:Center(child: Text('首页'),)
//     );
//   }

//   void getHttp() async{
//     try{
//       Response response;
//       response = await Dio().get('https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=beauity girl');
//       return print(response);
//     }catch(e){
//       return print(e);
//     }
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController typeController = TextEditingController();
//   String showText = 'Welcome!';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HomePage'),
//         elevation: 0.0,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//         child: Column(
//           children: <Widget>[
//             TextField(
//               controller: typeController,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.all(10.0),
//                 labelText: 'Category',
//                 helperText: 'type category'
//               ),
//               autofocus: false,
//             ),
//             RaisedButton(
//               onPressed: _choiceAction,
//               child: Text('choose'),
//             ),
//             Text(
//               showText,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 2,
//             )
//           ],
//         ),
//       ),
//       )
//     );
//   }

//   void _choiceAction(){
//     print('start chosing.....');
//     if(typeController.text.toString()==''){
//       showDialog(
//         context: context,
//         builder: (context)=>AlertDialog(title:Text('can not empty'))
//       );
//     }else{
//       getHttp(typeController.text.toString()).then((val){
//         setState(() {
//           showText = val['data']['name'];
//         });
//       });
//     }
//   }

//   Future getHttp(String TypeText) async{
//     try{
//       Response response;
//       var data = {'name':TypeText};
//       Dio dio = new Dio();
//       dio.options.headers = httpHeaders;
//       // res = await = dio.get('https://time.geekbang.org/serv/v1/column/topList');
//       response = await dio.get('https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
//         queryParameters: data
//       );
//       return response.data;
//     }catch(e){
//       return print(e);
//     }
//   }
// }

