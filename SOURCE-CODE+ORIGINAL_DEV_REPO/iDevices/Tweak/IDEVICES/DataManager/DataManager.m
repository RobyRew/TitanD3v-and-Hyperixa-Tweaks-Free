#import "DataManager.h"

@implementation DataManager

+(instancetype)sharedInstance {
  static DataManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[DataManager alloc] init];
  });
  return sharedInstance;
}

-(id)init {
  return self;
}


-(NSString *)icloudFullName {
    return [[TDTweakManager sharedInstance] objectForKey:@"icloudName" defaultValue:@"Username" ID:BID];
}


-(UIImage *)icloudAvatar {
    NSData *profileAvatar = [[TDTweakManager sharedInstance] objectForKey:@"icloudAvatar" defaultValue:nil ID:BID];
    return [UIImage imageWithData:profileAvatar];
}


-(NSString *)lastLockedDevice {
    return [[TDTweakManager sharedInstance] objectForKey:@"lastTimeLocked" defaultValue:@"You haven't locked your device yet." ID:BID];
}


-(NSString *)lastUnlockedDevice {
    return [[TDTweakManager sharedInstance] objectForKey:@"lastTimeUnlocked" defaultValue:@"You haven't unlocked your device yet." ID:BID];
}


-(NSString *)lastRespringDevice {
    return [[TDTweakManager sharedInstance] objectForKey:@"lastTimeRespring" defaultValue:@"You haven't respring yet." ID:BID];
}


-(NSString *)lastOpenedApp {
    return [[TDTweakManager sharedInstance] objectForKey:@"lastOpenedApp" defaultValue:@"You haven't opened app yet." ID:BID];
}


-(NSString *)lastiCloudBackUpDate {
    return [[TDTweakManager sharedInstance] objectForKey:@"lastiCloudBackUpDate" defaultValue:@"You haven't backup yet." ID:BID];
}

@end
