#import <Flutter/Flutter.h>

@interface RikiWisdomToothPlugin : NSObject<FlutterPlugin>
+ (UIViewController *)getCurrentWindowController;
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC isRoot:(BOOL)isRoot;
@end
