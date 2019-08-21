import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  // @override
  // void initState() {
  //   getHomePageContent().then((val){
  //     setState(() {
  //       homePageContent = val.toString();
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();  // 外面是list 里面是map
            return Column(
              children: <Widget>[
                SwiperDIY(swiperDataList:swiper)
              ],
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
}

class SwiperDIY extends StatelessWidget {

  final List swiperDataList;
  SwiperDIY({Key key, this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    print('设备宽度:${ScreenUtil.screenWidth}'); //Device width
    print('设备高度:${ScreenUtil.screenHeight}'); //Device height
    print('设备的像素密度:${ScreenUtil.pixelRatio}'); //Device pixel density

    ScreenUtil.instance = ScreenUtil(width: 750.0, height: 1334.0)..init(context);
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

