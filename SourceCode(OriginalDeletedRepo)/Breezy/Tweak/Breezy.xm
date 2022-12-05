#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import <dlfcn.h>
#import "Headers.h"

static NSString *BID = @"com.TitanD3v.BreezyPrefs";
static BOOL toggleBreezy;
static NSString *breezyTitle;
static NSString *breezyMessage;
static BOOL toggleStatusbarGesture;
static BOOL toggleDockGesture;
static BOOL toggleVolumeUpGesture;
static BOOL toggleVolumeDownGesture;
static BOOL toggleShakeGesture;
static BBServer *bbServer = nil;


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


static void breezyFakeNotification() {

  NSArray *notificationBundleID = [[TDTweakManager sharedInstance] objectForKey:@"notificationBundleID" ID:@"com.TitanD3v.BreezyPrefs"];
  NSString *bundleID = [notificationBundleID objectAtIndex:0];

  BBBulletin* bulletin = [[%c(BBBulletin) alloc] init];

  bulletin.title = breezyTitle;
  bulletin.message = breezyMessage;
  bulletin.sectionID = bundleID;
  bulletin.bulletinID = [[NSProcessInfo processInfo] globallyUniqueString];
  bulletin.recordID = [[NSProcessInfo processInfo] globallyUniqueString];
  bulletin.publisherBulletinID = [[NSProcessInfo processInfo] globallyUniqueString];
  bulletin.date = [NSDate date];
  bulletin.defaultAction = [%c(BBAction) actionWithLaunchBundleID:bundleID callblock:nil];
  bulletin.clearable = YES;
  bulletin.showsMessagePreview = YES;
  bulletin.publicationDate = [NSDate date];
  bulletin.lastInterruptDate = [NSDate date];

  if ([bbServer respondsToSelector:@selector(publishBulletin:destinations:)]) {
    dispatch_sync(getBBServerQueue(), ^{
      [bbServer publishBulletin:bulletin destinations:15];
    });
  }
}


%group BreezyStatusbar
%hook _UIStatusBar

-(void)willMoveToSuperview:(UIView *)newSuperview {
  %orig(newSuperview);

  UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(invokeFakeNotification)];
  tapGesture1.numberOfTapsRequired = 2;
  [self addGestureRecognizer:tapGesture1];

}

%new
-(void)invokeFakeNotification {
  breezyFakeNotification();
  NSLog(@"BREEZY title: %@", breezyTitle);
}

%end
%end


%group BreezyVolumeUp
%hook SpringBoard
%property (nonatomic, assign) BOOL didPressed;

-(BOOL)_handlePhysicalButtonEvent:(UIPressesEvent *)arg1 {

  UIPress *touch = [arg1.allPresses anyObject];

  if (touch.type == 102) { // 102 up, 103 down

    if (touch.force == 1) {

      self.didPressed = YES;
      [self performSelector:@selector(monitorGesturePressed) withObject:nil afterDelay:0.25f];

    } else {

      self.didPressed = NO;
    }
  }

  return %orig;
}

%new
-(void)monitorGesturePressed {

  if (self.didPressed)
  [self performSelector:@selector(invokeFakeNotification)];
}

%new
-(void)invokeFakeNotification {
  breezyFakeNotification();
}

%end
%end


%group BreezyVolumeDown
%hook SpringBoard
%property (nonatomic, assign) BOOL didPressed;

-(BOOL)_handlePhysicalButtonEvent:(UIPressesEvent *)arg1 {

  UIPress *touch = [arg1.allPresses anyObject];

  if (touch.type == 103) { // 102 up, 103 down

    if (touch.force == 1) {

      self.didPressed = YES;
      [self performSelector:@selector(monitorGesturePressed) withObject:nil afterDelay:0.25f];

    } else {

      self.didPressed = NO;
    }
  }

  return %orig;
}

%new
-(void)monitorGesturePressed {

  if (self.didPressed)
  [self performSelector:@selector(invokeFakeNotification)];
}

%new
-(void)invokeFakeNotification {
  breezyFakeNotification();
}

%end
%end


%group BreezyDock
%hook SBDockView
-(void)layoutSubviews {
  %orig;

  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(invokeFakeNotification)];
  tapGesture.numberOfTapsRequired = 2;
  [self addGestureRecognizer:tapGesture];

}

%new
-(void)invokeFakeNotification {
  breezyFakeNotification();
}

%end
%end


%group BreezyShake
%hook UIWindow

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
  %orig;
  if(event.type == UIEventSubtypeMotionShake && self == [[UIApplication sharedApplication] keyWindow]) {
    breezyFakeNotification();
  }
}

%end
%end


%group BBServerHooks
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
%end


void SettingsChanged() {

  toggleBreezy = [[TDTweakManager sharedInstance] boolForKey:@"toggleBreezy" defaultValue:NO ID:BID];
  breezyTitle = [[TDTweakManager sharedInstance] objectForKey:@"breezyTitle" defaultValue:@"Hello" ID:BID];
  breezyMessage = [[TDTweakManager sharedInstance] objectForKey:@"breezyMessage" defaultValue:@"How are you?" ID:BID];
  toggleStatusbarGesture = [[TDTweakManager sharedInstance] boolForKey:@"toggleStatusbarGesture" defaultValue:YES ID:BID];
  toggleDockGesture = [[TDTweakManager sharedInstance] boolForKey:@"toggleDockGesture" defaultValue:NO ID:BID];
  toggleVolumeUpGesture = [[TDTweakManager sharedInstance] boolForKey:@"toggleVolumeUpGesture" defaultValue:NO ID:BID];
  toggleVolumeDownGesture = [[TDTweakManager sharedInstance] boolForKey:@"toggleVolumeDownGesture" defaultValue:NO ID:BID];
  toggleShakeGesture = [[TDTweakManager sharedInstance] boolForKey:@"toggleShakeGesture" defaultValue:NO ID:BID];

}

%ctor {

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)SettingsChanged, CFSTR("com.TitanD3v.BreezyPrefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    SettingsChanged();

    if (toggleBreezy) {

      if (toggleStatusbarGesture) {
        %init(BreezyStatusbar);
      }

      if (toggleVolumeUpGesture) {
        %init(BreezyVolumeUp);
      }

      if (toggleVolumeDownGesture) {
        %init(BreezyVolumeDown);
      }

      if (toggleDockGesture) {
        %init(BreezyDock);
      }

      if (toggleShakeGesture) {
        %init(BreezyShake);
      }

      %init(BBServerHooks);

    }

  }

