#import <Foundation/Foundation.h>

@interface MemoryData : NSObject

+ (nullable NSString *)getTotalRam;
+ (nullable NSString *)getFreeRam;
+ (nullable NSString *)getUsedRam;

@end
