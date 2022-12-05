#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "SettingManager.h"

//extern const NSNotificationName DidSelectMemoji;

@interface AvatarManager : NSObject

+ (void)prepareMemojiRuntime;
+ (BOOL)deviceSupportsMemoji;

@end
