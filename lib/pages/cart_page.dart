import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provide/cart.dart';
import 'package:provide/provide.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {
  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List cartList = Provide.value<CartProvide>(context).cartList;

            return Stack(
              children: <Widget>[
                Provide<CartProvide>(
                  builder: (context, child, childCategory) {
                    cartList = Provide.value<CartProvide>(context).cartList;
                    return ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        // return ListTile(
                        //   title: Text(cartList[index].goodsName),
                        // );
                        return CartItem(cartList[index]);
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom(),
                )
              ],
            );
          } else {
            return Text('正在加载');
          }
        },
      ),
    );
  }
}

// ================== share preference test =========

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CartPage extends StatefulWidget {
//   @override
//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {

//   List<String> testList = [];

//   //增加
//   void _add() async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String temp = 'Charon1';
//     testList.add(temp);
//     prefs.setStringList('testInfo', testList);
//     _show();
//   }

//   //查询
//   void _show() async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if(prefs.getStringList('testInfo') != null){
//       setState(() {
//         testList = prefs.getStringList('testInfo');
//       });
//     }
//   }

//   //删除
//   void _delete() async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // prefs.clear(); // 全部删除
//     prefs.remove('testInfo');
//     setState(() {
//       testList = [];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     _show();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('购物车'),
//         elevation: 0.0,
//       ),
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Container(
//               height: 500,
//               child: ListView.builder(
//                 itemCount: testList.length,
//                 itemBuilder: (context, index){
//                   return ListTile(
//                     title: Text(testList[index]),
//                   );
//                 },
//               ),
//             ),
//             RaisedButton(
//               onPressed: (){
//                 _add();
//               },
//               child: Text('增加'),
//             ),
//             RaisedButton(
//               onPressed: (){
//                 _delete();
//               },
//               child: Text('情空'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ================== Provide test =========
// import 'package:flutter/material.dart';
// import 'package:provide/provide.dart';
// import '../provide/counter.dart';

// class CartPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('HomePage'),
//           elevation: 0.0,
//         ),
//         body: Center(
//           child: Column(
//             children: <Widget>[
//               Number(),
//               MyButton(),
//             ],
//           ),
//         ));
//   }
// }

// class Number extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.only(top: 200.0),
//         child: Provide<Counter>(
//           builder: (context, child, counter) {
//             return Text(
//               '${counter.value}',
//               style: TextStyle(fontSize: 100.0),
//             );
//           },
//         ));
//   }
// }

// class MyButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 200.0),
//       child: RaisedButton(
//         onPressed: () {
//           Provide.value<Counter>(context).increment();
//         },
//         child: Text('ADD'),
//       ),
//     );
//   }
// }
