#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "GlobalPreferences.h"

@interface DataManager : NSObject

+(instancetype)sharedInstance;
-(id)init;
-(NSString *)icloudFullName;
-(UIImage *)icloudAvatar;
-(NSString *)lastLockedDevice;
-(NSString *)lastUnlockedDevice;
-(NSString *)lastRespringDevice;
-(NSString *)lastOpenedApp;
-(NSString *)lastiCloudBackUpDate;
@end
