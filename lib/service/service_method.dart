import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import '../config/service_url.dart';


Future request(url,{formData}) async{  // 加了{}就变成可选参数 
  try{
    print('开始获取数据.....');
      Response response;
      Dio dio = new Dio();

      dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded'); // ContentType在io包里
      
      if(FormData==null){
        response = await dio.post(servicePath[url]); 
      }else{
        response = await dio.post(servicePath[url],data: formData);
      }

      if(response.statusCode == 200){
        return response.data;
      }else{
        throw Exception('后端接口出现异常');
      }
  }catch(e){
    return print('ERROR: ==========>${e}');
  }
}

//获取首页主题内容
Future getHomePageContent() async{
  try{
    print('开始获取首页数据.....');
      Response response;
      Dio dio = new Dio();

      dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded'); // ContentType在io包里
      
      var formData = {'lon':'115.02932', 'lat':'35.76189'};
      response = await dio.post(servicePath['homePageContent'],data: formData);
      if(response.statusCode == 200){
        return response.data;
      }else{
        throw Exception('后端接口出现异常');
      }
  }catch(e){
    return print('ERROR: ==========>${e}');
  }
}

Future getHomePageBelowContent() async{
  try{
    print('开始获取热卖下拉数据.....');
      Response response;
      Dio dio = new Dio();

      dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded'); // ContentType在io包里
      
      int page = 1;
      response = await dio.post(servicePath['homePageBelowConten'],data: page);
      if(response.statusCode == 200){
        return response.data;
      }else{
        throw Exception('后端接口出现异常');
      }
  }catch(e){
    return print('ERROR: ==========>${e}');
  }
}

