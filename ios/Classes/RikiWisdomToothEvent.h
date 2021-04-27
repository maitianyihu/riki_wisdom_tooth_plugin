//
//  RikiWisdomToothEvent.h
//  riki_wisdom_tooth_plugin
//
//  Created by 王帅宇 on 2021/4/26.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
NS_ASSUME_NONNULL_BEGIN

@interface RikiWisdomToothEvent : NSObject<FlutterStreamHandler>
@property(nonatomic,strong)FlutterEventSink eventSink;
@property(nonatomic,strong)FlutterEventChannel *eventChannel;
@end

NS_ASSUME_NONNULL_END
