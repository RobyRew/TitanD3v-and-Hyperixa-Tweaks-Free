#import "MemoryData.h"

@interface RamManager : NSObject
+ (nonnull instancetype)sharedManager;
@property (nonatomic, readonly, nullable) NSString *getTotalRam;
@property (nonatomic, readonly, nullable) NSString *getFreeRam;
@property (nonatomic, readonly, nullable) NSString *getUsedRam;
@end
