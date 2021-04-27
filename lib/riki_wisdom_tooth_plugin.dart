import 'dart:async';

import 'package:flutter/services.dart';

class RikiWisdomToothPlugin {
  //通道
  static const MethodChannel _channel = const MethodChannel('riki_wisdom_tooth_method');
  //事件
  static const EventChannel _eventChannel = const EventChannel("riki_wisdom_tooth_event");
  //监听
  static StreamSubscription eventStreamSubscription(
      void onData(dynamic event), Function error) {
    return _eventChannel
        .receiveBroadcastStream()
        .listen(onData, onError: error);
  }
  /// 初始化SDK，appId 和 appKey方式登录
  /// @param appId
  /// @param appKey
  /// @param host  可以为空，默认阿里云服务；如果需要，请设置自己的域名
  static initSobotSDK(String appKey, {String host}) async {
     await _channel.invokeMethod('initSobotSDK',{"appKey":appKey});
  }

  /// 启动聊天页面，简单处理
  static  openZCChat() async {
     await _channel.invokeMethod('openZCChat');
  }


  // /// 初始化SDK，设置域名和认证token
  // /// @param token 认证token
  // /// @param host  可以为空，默认阿里云服务；如果需要，请设置自己的域名
  // static Future<void> initWithToken(String token,{String host}) async {
  //   return await _channel.invokeMethod('initWithToken',{"token":token,"host":host});
  // }
  // //指定加载的bundle名称，默认SobotOnline -- 暂不使用  需要时可自定义
  // static Future<void> setBundleName({String bundleName}) async {
  //   return await _channel.invokeMethod('setBundleName',{"bundleName":bundleName});
  // }
  // //指定加载的bundle名称，SobotColor -- 暂不使用  需要时可自定义
  // static Future<void> setColorTable({String colorTable}) async {
  //   return await _channel.invokeMethod('setColorTable',{"colorTable":colorTable});
  // }
  // /// 启动客服认证页面
  // /// @param account 客服账户(邮箱)
  // /// @param loginStatus 登录状态 2:忙碌，1:在线，0默认
  // static Future<void> startAuthWithAccount(String account,String status) async {
  //   return await _channel.invokeMethod('startAuthWithAccount',{"account":account,"status":status});
  // }
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

}
