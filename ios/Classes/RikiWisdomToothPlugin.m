#import "RikiWisdomToothPlugin.h"
#import "RikiWisdomToothEvent.h"
#import <SobotKit/SobotKit.h>
@implementation RikiWisdomToothPlugin

RikiWisdomToothEvent *wisdomToothEvent;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    // 通道1
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"riki_wisdom_tooth_method"
                                     binaryMessenger:[registrar messenger]];
    RikiWisdomToothPlugin* instance = [[RikiWisdomToothPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    //事件监听通道
    wisdomToothEvent = [[RikiWisdomToothEvent alloc]init];
    
    wisdomToothEvent.eventChannel = [FlutterEventChannel eventChannelWithName:@"riki_wisdom_tooth_event" binaryMessenger:[registrar messenger]];
    [wisdomToothEvent.eventChannel setStreamHandler:wisdomToothEvent];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
    //初始化
    if ([@"initSobotSDK" isEqualToString:call.method]){
        //初始化
        NSString *appKey = call.arguments[@"appKey"];
        NSString *host = call.arguments[@"host"];
        if(host == nil){
            host = @"";
        }
        // 初始化是设置域名，如果不设置，默认SaaS域名
        [ZCSobotApi initSobotSDK:appKey host:@"https://www.soboten.com" result:^(id  _Nonnull object) {
            NSLog(@"初始化完成,结果:%@",object);
        }];
    }else if([@"openZCChat" isEqualToString:call.method]){
        // 配置UI相关信息如果需要的话可以加上一些配置属性
        ZCKitInfo *kitInfo = [[ZCKitInfo alloc]init];
        [ZCSobotApi openZCChat:kitInfo with:[RikiWisdomToothPlugin getCurrentWindowController] pageBlock:^(id  _Nonnull object, ZCPageBlockType type) {
            // 点击返回
            if(type==ZCPageBlockGoBack){
                //                    NSLog(@"点击了关闭按钮");
            }
            
            // 页面UI初始化完成，可以获取UIView，自定义UI
            if(type==ZCPageBlockLoadFinish){
                //                    NSLog(@"页面加载完成");
            }
        }];
    }else if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}



//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentWindowController {
    __block UIViewController *currentVC = nil;
    if ([NSThread isMainThread]) {
        @try {
            UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
            if (rootViewController != nil) {
                currentVC = [self getCurrentVCFrom:rootViewController isRoot:YES];
            }
        } @catch (NSException *exception) {
            //            SAError(@"%@ error: %@", self, exception);
        }
        return currentVC;
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            @try {
                UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
                if (rootViewController != nil) {
                    currentVC = [self getCurrentVCFrom:rootViewController isRoot:YES];
                }
            } @catch (NSException *exception) {
                //                SAError(@"%@ error: %@", self, exception);
            }
        });
        return currentVC;
    }
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC isRoot:(BOOL)isRoot{
    @try {
        UIViewController *currentVC;
        if ([rootVC presentedViewController]) {
            // 视图是被presented出来的
            rootVC = [self getCurrentVCFrom:rootVC.presentedViewController isRoot:NO];
        }
        
        if ([rootVC isKindOfClass:[UITabBarController class]]) {
            // 根视图为UITabBarController
            currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController] isRoot:NO];
        } else if ([rootVC isKindOfClass:[UINavigationController class]]){
            // 根视图为UINavigationController
            currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController] isRoot:NO];
        } else {
            // 根视图为非导航类
            if ([rootVC respondsToSelector:NSSelectorFromString(@"contentViewController")]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                UIViewController *tempViewController = [rootVC performSelector:NSSelectorFromString(@"contentViewController")];
#pragma clang diagnostic pop
                if (tempViewController) {
                    currentVC = [self getCurrentVCFrom:tempViewController isRoot:NO];
                }
            } else {
                if (rootVC.childViewControllers && rootVC.childViewControllers.count == 1 && isRoot) {
                    currentVC = [self getCurrentVCFrom:rootVC.childViewControllers[0] isRoot:NO];
                }
                else {
                    currentVC = rootVC;
                }
            }
        }
        
        return currentVC;
    } @catch (NSException *exception) {
        //        SAError(@"%@ error: %@", self, exception);
    }
}

@end
