#import <TitanD3vUniversal/TitanD3vUniversal.h>

NSString *plistStorage = @"/tmp/EMPStorageUsageInfo.plist";
NSString *plistDevices = @"/tmp/EMPGetDevices.plist";


@interface ACAccount
@end

@interface AAURLSession : NSObject
+(id)sharedSigningSession;
+(id)sharedSession;
-(void)URLSession:(id)arg1 dataTask:(id)arg2 didReceiveData:(id)arg3;
-(void)URLSession:(id)arg1 didBecomeInvalidWithError:(id)arg2;
@end

@interface AAQuotaInfoRequest
+(Class)responseClass;
-(id)urlString;
-(id)urlRequest;
-(id)account;
-(id)initWithAccount:(id)arg1 ;
-(id)initDetailedRequestWithAccount:(id)arg1 ;
@end

@interface AAResponse
@property (nonatomic,readonly) long long statusCode;
@property (nonatomic,readonly) NSData * data;
@end

@interface AARequester : NSObject{
  AAResponse* _response;
}
-(void)start;
-(void)_callHandler;
-(id)initWithRequest:(id)arg1 handler:(id)arg2 ;
@end

@interface PLAccountStore : NSObject
+(id)pl_sharedAccountStore;
-(ACAccount *)cachedPrimaryAppleAccount;
@end


@interface MBStateInfo : NSObject
@property (assign,nonatomic) int state;
@property (assign,nonatomic) BOOL isBackground;
@property (assign,nonatomic) BOOL isCloud;
@property (assign,nonatomic) float progress;
@property (assign,nonatomic) unsigned long long estimatedTimeRemaining;
@property (nonatomic,retain) NSDate * date;
@property (nonatomic,retain) NSError * error;
@property (nonatomic,retain) NSMutableArray * errors;
@end


static ACAccount *acc;


%hook AARequester

-(void)connection:(NSURLConnection*)arg1 didReceiveData:(id)arg2{
  %orig;
  NSLog(@"DDDDDDD isKindOfClass:-%d, didReceiveData:-%@", [arg1 isKindOfClass:[NSURLConnection class]], arg1);

  if([arg1 isKindOfClass:[NSURLConnection class]]){
    NSMutableURLRequest *currentRequest = (NSMutableURLRequest*)arg1.currentRequest;
    NSString *last = [currentRequest.URL lastPathComponent];
    NSLog(@"DDDDDDD last:-%@", last);

    if([last isEqual:@"storageUsageInfo"])
    [arg2 writeToFile:plistStorage atomically:YES];
    if([last isEqual:@"getDevices"])
    [arg2 writeToFile:plistDevices atomically:YES];
  }
}
%end


//This will load listDevice and iCloudStorage when user will open Settings app
%hook PSUIPrefsListController
-(void)viewWillAppear:(BOOL)arg1{

  //   [[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"com.TitanD3v.Empire/refreshiCloudStorage" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
  //     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
  //       acc = [[%c(PLAccountStore) pl_sharedAccountStore] cachedPrimaryAppleAccount];
  //       AAQuotaInfoRequest *aqReq = [[%c(AAQuotaInfoRequest) alloc] initDetailedRequestWithAccount:acc];
  //       AARequester *aaReq = [[%c(AARequester) alloc] initWithRequest:aqReq handler:^{}];
  //       [aaReq start];
  //     });
  //   }];

  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    acc = [[%c(PLAccountStore) pl_sharedAccountStore] cachedPrimaryAppleAccount];
    AAQuotaInfoRequest *aqReq = [[%c(AAQuotaInfoRequest) alloc] initDetailedRequestWithAccount:acc];
    AARequester *aaReq = [[%c(AARequester) alloc] initWithRequest:aqReq handler:^{}];
    [aaReq start];

    AADeviceListRequest *myPic = [[%c(AADeviceListRequest) alloc] initWithAccount:acc];
    aaReq = [[%c(AARequester) alloc] initWithRequest:myPic handler:^{}];

    [aaReq start];

  });

  %orig;
}
%end


//Save last scuessful backup date to plist
%hook MBStateInfo
-(int)state {
  int state = %orig;

  NSLog(@"DDDDDDD state:-%ld, lastBackUpDate:-%@", (long)state, [self date]);

  if(state == 4){
    //[[TDTweakManager sharedInstance] setObject:[self date] forKey:@"lastBackUpDate" ID:@"com.TitanD3v.iDevicesPrefs"];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d MMM yy HH:mm"];
    [[TDTweakManager sharedInstance] setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"lastiCloudBackUpDate" ID:@"com.TitanD3v.iDevicesPrefs"];
  }

  return state;
}
%end

%ctor{
  NSBundle *appleAccountBundle = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/AppleAccount.framework/"];
  [appleAccountBundle load];

  NSBundle *AccountSettingsBundle = [NSBundle bundleWithPath:@"/System/Library/PreferenceBundles/AccountSettings/AppleAccountSettings.bundle/"];
  [AccountSettingsBundle load];
}
