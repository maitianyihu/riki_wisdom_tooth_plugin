//
//  RikiWisdomToothEvent.m
//  riki_wisdom_tooth_plugin
//
//  Created by 王帅宇 on 2021/4/26.
//
#import <Foundation/Foundation.h>
#import "RikiWisdomToothEvent.h"
#import <objc/runtime.h>

@implementation RikiWisdomToothEvent
@dynamic eventSink;

- (FlutterEventSink)eventSink{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEventSink:(FlutterEventSink)eventSink{
    objc_setAssociatedObject(self, @selector(eventSink), eventSink, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FlutterEventChannel *)eventChannel{
     return objc_getAssociatedObject(self, _cmd);
}

-(void)setEventChannel:(FlutterEventChannel *)eventChannel{
    objc_setAssociatedObject(self, @selector(eventChannel), eventChannel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - FlutterStreamHandler
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events{
    self.eventSink = events;
    return nil;
}
 

- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    self.eventSink = nil;
    return nil;

}
@end
