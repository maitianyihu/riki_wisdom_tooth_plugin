import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:riki_wisdom_tooth_plugin/riki_wisdom_tooth_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    String appkey ='b9b0f0f4457a45c088b457a96c17b540';

    //初始化sdk
    RikiWisdomToothPlugin.initSobotSDK(appkey);


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('智齿客服插件测试'),
        ),
        body: Center(
          child: GestureDetector(
              onTap: (){
                //启动页面
                RikiWisdomToothPlugin.openZCChat();
                // RikiWisdomToothPlugin.openZCChat();
              },
              child: Text('启动联调页面')),
        ),
      ),
    );
  }
}
