import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class JPushPage extends StatefulWidget {
  @override
  _JPushPageState createState() => _JPushPageState();
}

class _JPushPageState extends State<JPushPage> {
  String debugLable = 'Unknown'; //错误信息
  final JPush jpush = new JPush(); //初始化极光插件

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      //监听响应方法的编写
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print(">>>>>>>>>>>>>>>>>flutter 接收到推送: $message");
        setState(() {
          debugLable = "接收到推送: $message";
        });
      });
    } on PlatformException {
      platformVersion = '平台版本获取失败，请检查！';
    }

    if (!mounted) return;

    setState(() {
      debugLable = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('JPushPage'),
          elevation: 0.0,
        ),
        body: new Center(
          child: new Column(children: [
            new Text('结果: $debugLable\n'),
            new FlatButton(
                // child: new Text('发送推送消息\n'),
                child: new Icon(Icons.send),
                onPressed: () {
                  // 三秒后出发本地推送
                  var fireDate = DateTime.fromMillisecondsSinceEpoch(
                      DateTime.now().millisecondsSinceEpoch + 3000);
                  var localNotification = LocalNotification(
                    id: 234,
                    title: 'Charon的飞鸽传说',
                    buildId: 1,
                    content: '看到了说明已经成功了',
                    fireTime: fireDate,
                    subtitle: '一个测试',
                  );
                  jpush.sendLocalNotification(localNotification).then((res) {
                    setState(() {
                      debugLable = res;
                    });
                  });
                }),
          ]),
        ));
  }
}

/*
Android: #
在 /android/app/build.gradle 中添加下列代码：

android: {
  ....
  defaultConfig {
    applicationId "替换成自己应用 ID"
    ...
    ndk {
	//选择要添加的对应 cpu 类型的 .so 库。
	abiFilters 'armeabi', 'armeabi-v7a', 'x86', 'x86_64', 'mips', 'mips64', 'arm64-v8a',        
    }

    manifestPlaceholders = [
        JPUSH_PKGNAME : applicationId,
        JPUSH_APPKEY : "appkey", // NOTE: JPush 上注册的包名对应的 Appkey.
        JPUSH_CHANNEL : "developer-default", //暂时填写默认值即可.
    ]
  }    
}
*/

/*

IOS
https://www.jianshu.com/p/ff93d9d6b3ff
https://community.jiguang.cn/t/jpush-ios-sdk/4247

*/
