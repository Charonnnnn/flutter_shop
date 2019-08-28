import 'package:flutter/material.dart'; 
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import 'package:fluro/fluro.dart';
import './routers/routes.dart';
import './routers/application.dart';
import './provide/details_info.dart';


void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var goodsList = CategoryGoodsListProvide();
  var goodsInfo = DetailsInfoProvide();
  
  var providers = Providers();

  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(goodsList))
    ..provide(Provider<DetailsInfoProvide>.value(goodsInfo));

  //ProviderNode封装了InheritWidget，并且提供了 一个providers容器用于放置状态
  runApp(ProviderNode(child:MyApp(),providers:providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final router = Router();
    Routes.configRoutes(router);
    Application.router = router;

    return MaterialApp(
      title: '测试电商平台',
      onGenerateRoute: Application.router.generator,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
      home: IndexPage(),
    );
  }
}

