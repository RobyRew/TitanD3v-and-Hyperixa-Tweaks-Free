#import "Headers.h"
#import "SettingViewController.h"

static BOOL toggleNova;
static BOOL toggleHideFloatingButton;
static NSInteger floatingButtonAlignment;

static NSMutableArray *todaysSchedules;
static NSMutableArray *futureSchedules;

static SSender *sender;
static PCSimpleTimer *lastTimer;

ScheduleManager *SMSharedInstance;
FloatingBlurView *scheduleButton;

static BBServer *bbServer;
static bool shouldIgnoreAirplaneMode = NO;


static UIWindow *settingWindow = nil;


@implementation SSender
- (id)init {
    if (self = [super init]) {
      self.messagingCenter = [CPDistributedMessagingCenter centerNamed:@"com.TitanD3v.SMSScheuler"];
      rocketbootstrap_distributedmessagingcenter_apply(self.messagingCenter);
    }
    return self;
}

- (BOOL)sendText:(NSString *)msg toPhn:(NSString *)toPhn withAttachments:(NSArray*)files{
    NSDictionary* args = [NSDictionary new];
    if([files count]==0)
      args = @{@"Message": msg, @"Phone": toPhn};
    else
      args = @{@"Message": msg, @"Phone": toPhn, @"Attachment" : files};

    return [self.messagingCenter sendMessageName:@"SMSScheuler" userInfo:args];
}
@end

@interface CKConversationListCollectionViewController : UIViewController <UIScrollViewDelegate>
@end


static dispatch_queue_t getBBServerQueue() {

  static dispatch_queue_t queue;
  static dispatch_once_t predicate;

  dispatch_once(&predicate, ^{
    void* handle = dlopen(NULL, RTLD_GLOBAL);
    if (handle) {
      dispatch_queue_t __weak *pointer = (__weak dispatch_queue_t *) dlsym(handle, "__BBServerQueue");
      if (pointer) queue = *pointer;
      dlclose(handle);
    }
  });

  return queue;

}


static void NovaNotification(NSString *msg) {
  BBBulletin* bulletin = [[%c(BBBulletin) alloc] init];

  bulletin.title = @"Nova";
  bulletin.message = msg;
  bulletin.sectionID = @"com.apple.MobileSMS";
  bulletin.bulletinID = [[NSProcessInfo processInfo] globallyUniqueString];
  bulletin.recordID = [[NSProcessInfo processInfo] globallyUniqueString];
  bulletin.publisherBulletinID = [[NSProcessInfo processInfo] globallyUniqueString];
  bulletin.date = [NSDate date];
  bulletin.defaultAction = [%c(BBAction) actionWithLaunchBundleID:@"com.apple.MobileSMS" callblock:nil];
  bulletin.clearable = YES;
  bulletin.showsMessagePreview = YES;
  bulletin.publicationDate = [NSDate date];
  bulletin.lastInterruptDate = [NSDate date];

  if ([bbServer respondsToSelector:@selector(publishBulletin:destinations:)]) {
    dispatch_sync(getBBServerQueue(), ^{
      NSLog(@"scheduleMsg will send NovaNotification :-%@.bulletin:-%@", bbServer, bulletin);
      [bbServer publishBulletin:bulletin destinations:15];
    });
  }
}

%group Nova

%hook BBServer

- (id)initWithQueue:(id)arg1 {
  bbServer = %orig;
  return bbServer;
}

- (id)initWithQueue:(id)arg1 dataProviderManager:(id)arg2 syncService:(id)arg3 dismissalSyncCache:(id)arg4 observerListener:(id)arg5 utilitiesListener:(id)arg6 conduitListener:(id)arg7 systemStateListener:(id)arg8 settingsListener:(id)arg9 {
  bbServer = %orig;
  return bbServer;
}

- (void)dealloc {
  if (bbServer == self) bbServer = nil;
  %orig;
}

%end

%hook CKConversationListCollectionViewController
- (void)viewWillAppear:(BOOL)animated {
  %orig;
  loadPrefs();

  scheduleButton = [[FloatingBlurView alloc] init];
  scheduleButton.layer.cornerRadius = 30;
  scheduleButton.alpha = 1;
  [self.view addSubview:scheduleButton];

  if (floatingButtonAlignment == 1) {
    [scheduleButton size:CGSizeMake(60, 60)];
    [scheduleButton leading:self.view.leadingAnchor padding:20];
    [scheduleButton bottom:self.view.bottomAnchor padding:-20];
  } else if (floatingButtonAlignment == 2) {
    [scheduleButton size:CGSizeMake(60, 60)];
    [scheduleButton x:self.view.centerXAnchor];
    [scheduleButton bottom:self.view.bottomAnchor padding:-20];
  } else if (floatingButtonAlignment == 3) {
    [scheduleButton size:CGSizeMake(60, 60)];
    [scheduleButton trailing:self.view.trailingAnchor padding:-20];
    [scheduleButton bottom:self.view.bottomAnchor padding:-20];
  }

  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scheduleActionTriggered)];
  [scheduleButton addGestureRecognizer:tap];

}


%new
-(void)scheduleActionTriggered {

  if (toggleHaptic) {

    if (hapticStrength == 0) {
      [[TDUtilities sharedInstance] haptic:0];
    } else if (hapticStrength == 1) {
      [[TDUtilities sharedInstance] haptic:1];
    } else if (hapticStrength == 2) {
      [[TDUtilities sharedInstance] haptic:2];
    }

  }


  ActiveScheduleVC *svc = [[ActiveScheduleVC alloc] init];
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:svc];
  [self presentViewController:navController animated:YES completion:nil];

}


- (void)viewWillDisappear:(BOOL)animated {
  %orig;
  scheduleButton.alpha = 0;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

  if (toggleHideFloatingButton) {
    if (scrollView.contentOffset.y < 0) {
      [UIView animateWithDuration:0.2 animations:^{
        scheduleButton.alpha = 1;
      }];

    } else if (scrollView.contentOffset.y >= 40) {
      [UIView animateWithDuration:0.2 animations:^{
        scheduleButton.alpha = 0;
      }];
    }
  }

  %orig;
}

%end

%hook SpringBoard

-(id)init{ 

  [[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"com.TitanD3v.Nova/deleteScheduleWithId" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
      NSString *withID = [[[notification userInfo] objectForKey:@"withID"] stringValue];
      NSLog(@"scheduleMsg got notif deleteScheduleWithId withID:-%@", withID);
      [SMSharedInstance deleteScheduleWithId:withID];
      
      [lastTimer invalidate];
      lastTimer = nil;
      [self loadSchedules];
  }];

  [[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"com.TitanD3v.Nova/addScheduleWithId" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
      NSDictionary *data = (NSDictionary*)[[notification userInfo] objectForKey:@"data"];
      NSString *withID = [[[notification userInfo] objectForKey:@"withID"] stringValue];
      [SMSharedInstance addScheduleWithId:withID data:data];

      [lastTimer invalidate];
      lastTimer = nil;
      [self loadSchedules];
      NSLog(@"scheduleMsg got notif addScheduleWithId withID:-%@, scheduleLabel:-%@", withID, data[@"scheduleLabel"]);
  }];

  [self loadSchedules];
  return %orig;
}

%new
-(void)loadSchedules{
  todaysSchedules = [SMSharedInstance getTodaysSchedules];
  futureSchedules = [SMSharedInstance getFutureSchedules];
  
  if([todaysSchedules count] !=0){
    for(int i=0;i<[todaysSchedules count];i++){
      dispatch_async(dispatch_get_main_queue(), ^{
        lastTimer = [[PCSimpleTimer alloc] initWithFireDate:(NSDate*)todaysSchedules[i][@"scheduleLabel"]
                        serviceIdentifier:@"com.TitanD3v.SMSScheuler.service"
                        target:self
                        selector:@selector(messageOperations:)
                        userInfo:todaysSchedules[i]];
        [lastTimer scheduleInRunLoop:[NSRunLoop mainRunLoop]];
      });
    }
  }

  if([futureSchedules count] !=0){
    for(int i=0;i<[futureSchedules count];i++){
      dispatch_async(dispatch_get_main_queue(), ^{
        lastTimer = [[PCSimpleTimer alloc] initWithFireDate:(NSDate*)futureSchedules[i][@"scheduleLabel"]
                        serviceIdentifier:@"com.TitanD3v.SMSScheuler.service"
                        target:self
                        selector:@selector(messageOperations:)
                        userInfo:futureSchedules[i]];
        [lastTimer scheduleInRunLoop:[NSRunLoop mainRunLoop]];
      });
    }
  }
}

%new
-(void)messageOperations:(id)timer{

  NSDictionary* userInfo = [(PCSimpleTimer *)timer userInfo];
  NSMutableDictionary *allSchedules = [SMSharedInstance getAllSchedules];
  bool isInAirplaneMode = [[%c(SBAirplaneModeController) sharedInstance ]isInAirplaneMode];
  dispatch_async(dispatch_get_main_queue(), ^{
    if(shouldIgnoreAirplaneMode && isInAirplaneMode){
      [[%c(SBAirplaneModeController) sharedInstance ] setInAirplaneMode:NO];
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if(allSchedules[userInfo[@"id"]] && ![allSchedules[userInfo[@"id"]][@"isSent"] boolValue]){
          NSMutableArray *attachedImages = [SMSharedInstance arrangeAttachedWithId:userInfo[@"id"] attachedImages:userInfo[@"attachedImages"]];
          NSLog(@"scheduleMsg messageOperations attachedImages.count:-%ld", attachedImages.count);
          [sender sendText:userInfo[@"messageLabel"] toPhn:userInfo[@"phoneNumber"] withAttachments:attachedImages];
          [SMSharedInstance markMsgAsSentWithId:userInfo[@"id"] data:userInfo];
          NSString *msg = [NSString stringWithFormat:@"Scheduled message has been sent to %@", allSchedules[userInfo[@"id"]][@"recipientLabel"]];
          NovaNotification(msg);
          [[%c(SBAirplaneModeController) sharedInstance ] setInAirplaneMode:YES];
        }
      });
    }
    else{
      if(allSchedules[userInfo[@"id"]] && ![allSchedules[userInfo[@"id"]][@"isSent"] boolValue]){
        NSMutableArray *attachedImages = [SMSharedInstance arrangeAttachedWithId:userInfo[@"id"] attachedImages:userInfo[@"attachedImages"]];
        NSLog(@"scheduleMsg messageOperations attachedImages.count:-%ld", attachedImages.count);
        [sender sendText:userInfo[@"messageLabel"] toPhn:userInfo[@"phoneNumber"] withAttachments:attachedImages];
        [SMSharedInstance markMsgAsSentWithId:userInfo[@"id"] data:userInfo];
        NSString *msg = [NSString stringWithFormat:@"Scheduled message has been sent to %@", allSchedules[userInfo[@"id"]][@"recipientLabel"]];
        NovaNotification(msg);
      }
    }
  });
  [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.Nova/ActiveScheduleVCReload" object:nil userInfo:nil deliverImmediately:YES];
  NSLog(@"scheduleMsg messageOperations isInAirplaneMode:-%d, isSent :-%d, keyData:-%@", isInAirplaneMode, [allSchedules[userInfo[@"id"]][@"isSent"] boolValue], allSchedules[userInfo[@"id"]]);
}
%end


%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application {

 %orig;
[[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"com.TitanD3v.Nova/DisableTipsAlert" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
[[TDTweakManager sharedInstance] setBool:NO forKey:@"showComposeTips" ID:@"com.TitanD3v.NovaPrefs"];
}];


if (!settingWindow) {

settingWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
settingWindow.backgroundColor = [UIColor clearColor];
settingWindow.hidden = YES;
settingWindow.windowLevel = UIWindowLevelStatusBar;
settingWindow.tintColor = [UIColor colorWithRed: 0.95 green: 0.27 blue: 0.17 alpha: 1.00];
settingWindow.rootViewController = [UIViewController new];
[settingWindow setUserInteractionEnabled:YES];

}


[[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"com.TitanD3v.Nova/DismissSetting" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
settingWindow.hidden = YES;
settingWindow.tintColor = [UIColor colorWithRed: 0.95 green: 0.27 blue: 0.17 alpha: 1.00];
});
}];


[[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"com.TitanD3v.Nova/PresentSetting" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
  settingWindow.hidden = NO;
  settingWindow.tintColor = [UIColor colorWithRed: 0.95 green: 0.27 blue: 0.17 alpha: 1.00];
      
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    
  settingWindow.tintColor = [UIColor colorWithRed: 0.95 green: 0.27 blue: 0.17 alpha: 1.00];
	SettingViewController *svc = [[SettingViewController alloc] init];
  svc.modalInPresentation = YES;
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:svc];
	[settingWindow.rootViewController presentViewController:navController animated:YES completion:nil];

  });

}];


}

%end
%end 


void SettingsChanged() {

  toggleNova = [[TDTweakManager sharedInstance] boolForKey:@"toggleNova" defaultValue:NO ID:BID];
  toggleHideFloatingButton = [[TDTweakManager sharedInstance] boolForKey:@"toggleHideFloatingButton" defaultValue:YES ID:BID];
  floatingButtonAlignment = [[TDTweakManager sharedInstance] intForKey:@"floatingButtonAlignment" defaultValue:3 ID:BID];
}

%ctor {

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)SettingsChanged, CFSTR("com.TitanD3v.NovaPrefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    SettingsChanged();

      if (toggleNova) {
        %init(Nova);
        sender = [[%c(SSender) alloc] init];
        SMSharedInstance = [[ScheduleManager sharedInstance] init];
        sender = [[SSender alloc] init];
        [sender sendText:@"This is test msg by NOVA." toPhn:@"" withAttachments:nil];
        [lastTimer invalidate];
        lastTimer = nil;
      }

}
