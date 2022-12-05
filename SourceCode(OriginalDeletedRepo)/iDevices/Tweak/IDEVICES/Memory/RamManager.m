#import "RamManager.h"

@implementation RamManager


+ (nonnull instancetype)sharedManager {
  static RamManager *sharedManagerServices = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedManagerServices = [[self alloc] init];
  });
  return sharedManagerServices;
}


- (nullable NSString *)getTotalRam {
  return [MemoryData getTotalRam];
}

- (nullable NSString *)getFreeRam {
  return [MemoryData getFreeRam];
}

- (nullable NSString *)getUsedRam {
  return [MemoryData getUsedRam];
}


@end
