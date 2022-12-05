#import "Headers.h"

static NSString *BID = @"com.TitanD3v.LuvPrefs";
static BOOL toggleLuv;
static BOOL showNotification;
static BOOL toggleHaptic;
static NSUInteger floatingButtonSize;
static NSUInteger floatingButtonStyles;
static NSUInteger hapticType;
static NSUInteger floatingIconStyle;
static NSString *luvAppearance;
static BOOL toggleColour;
static bool isInCollectionLast;
static NSString *songNameFull;
static NSString *lastNotifTitle;
static TopWindow *topWindow = nil;
static FloatingView *floatingView;
static UIImageView *iconImage;
static UIVisualEffectView *blurEffectView;
static BBServer *bbServerSPL;
static SPTNowPlayingAnimatedLikeButton *collectionBtn;
static float buttonSize;
static float buttonCornerRadius;
static float iconSize;


static BOOL isSpotifyPlaying(){
  
  NSString *nowPlayingID = [[[%c(SBMediaController) sharedInstance] nowPlayingApplication] bundleIdentifier];
  
  if ([nowPlayingID length] !=0 && [nowPlayingID rangeOfString:@"com.spotify.client"].location != NSNotFound)
  {
    return 1;
  }
  else{
    return 0;
  }
  
}


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


static void SPTLNotification(NSString *msg) {
  
  BBBulletin* bulletin = [[%c(BBBulletin) alloc] init];
  
  bulletin.title = @"Luv";
  bulletin.message = msg;
  bulletin.sectionID = @"com.spotify.client";
  bulletin.bulletinID = [[NSProcessInfo processInfo] globallyUniqueString];
  bulletin.recordID = [[NSProcessInfo processInfo] globallyUniqueString];
  bulletin.publisherBulletinID = [[NSProcessInfo processInfo] globallyUniqueString];
  bulletin.date = [NSDate date];
  bulletin.defaultAction = [%c(BBAction) actionWithLaunchBundleID:@"com.spotify.client" callblock:nil];
  bulletin.clearable = YES;
  bulletin.showsMessagePreview = YES;
  bulletin.publicationDate = [NSDate date];
  bulletin.lastInterruptDate = [NSDate date];
  
  if ([bbServerSPL respondsToSelector:@selector(publishBulletin:destinations:)]) {
    dispatch_sync(getBBServerQueue(), ^{
      [bbServerSPL publishBulletin:bulletin destinations:15];
    });
  }
  
}


%group LuvHooks
%hook BBServer

- (id)initWithQueue:(id)arg1 {
  
  bbServerSPL = %orig;
  return bbServerSPL;
  
}

- (id)initWithQueue:(id)arg1 dataProviderManager:(id)arg2 syncService:(id)arg3 dismissalSyncCache:(id)arg4 observerListener:(id)arg5 utilitiesListener:(id)arg6 conduitListener:(id)arg7 systemStateListener:(id)arg8 settingsListener:(id)arg9 {
  
  bbServerSPL = %orig;
  return bbServerSPL;
  
}

- (void)dealloc {
  
  if (bbServerSPL == self) bbServerSPL = nil;
  %orig;
  
}

%end


%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
  
  %orig;
  if(isSpotifyPlaying()){
    [self layoutWindow];
  }
  
  [[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"com.TitanD3v.SpotiLove/showWindow" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
    [self layoutWindow];
  }];
  
}


%new
-(void)layoutWindow {
  
  if(isSpotifyPlaying()) {
    
    if (!topWindow) {
      
      topWindow = [[TopWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
      topWindow.hidden = NO;
      
      
      if (floatingButtonSize == 0) {
        
        buttonSize = 60;
        iconSize = 40;
        
        if (floatingButtonStyles == 0) {
          buttonCornerRadius = 30;
        } else {
          buttonCornerRadius = 8;
        }
        
      } else if (floatingButtonSize == 1) {
        
        buttonSize = 70;
        iconSize = 45;
        
        if (floatingButtonStyles == 0) {
          buttonCornerRadius = 35;
        } else {
          buttonCornerRadius = 10;
        }
        
      } else if (floatingButtonSize == 2) {
        
        buttonSize = 80;
        iconSize = 50;
        
        if (floatingButtonStyles == 0) {
          buttonCornerRadius = 40;
        } else {
          buttonCornerRadius = 10;
        }
        
      }
      
      
      floatingView = [[FloatingView alloc] initWithFrame:CGRectMake(5, 100, buttonSize, buttonSize)];
      floatingView.layer.cornerRadius = buttonCornerRadius;
      floatingView.clipsToBounds = true;
      [floatingView setDragEnable:YES];
      [floatingView setAdsorbEnable:YES];
      [topWindow addSubview:floatingView];
      
      
      blurEffectView = [[UIVisualEffectView alloc] initWithFrame:CGRectMake(0, 0, buttonSize, buttonSize)];
      [floatingView insertSubview:blurEffectView atIndex:0];
      
      
      if (!toggleColour) {
        if([luvAppearance isEqualToString:@"luvLight"]) {
          
          blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialLight];
          
        } else if([luvAppearance isEqualToString:@"luvDark"]) {
          
          blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
          
        } else if([luvAppearance isEqualToString:@"luvDynamic"]) {
          
          if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
            blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
          } else {
            blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialLight];
          }
          
        }
        
      } else {
        
        blurEffectView.alpha = 0;
        floatingView.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"luvBackgroundColour" defaultValue:@"FFFFFF" ID:BID];
        
      }
      
      
      iconImage = [[UIImageView alloc] init];
      iconImage.userInteractionEnabled = NO;
      if (floatingIconStyle == 0) {
        iconImage.image = [[UIImage systemImageNamed:@"heart.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
      } else {
        iconImage.image = [[UIImage systemImageNamed:@"heart"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
      }
      if (toggleColour) {
        iconImage.tintColor = [[TDTweakManager sharedInstance] colourForKey:@"luvLikeColour" defaultValue:@"FFFFFF" ID:BID];
      } else {
        iconImage.tintColor = UIColor.systemGreenColor;
      }
      iconImage.contentMode = UIViewContentModeScaleAspectFit;
      [floatingView addSubview:iconImage];
      
      [iconImage size:CGSizeMake(iconSize, iconSize)];
      [iconImage x:floatingView.centerXAnchor y:floatingView.centerYAnchor];
      
      [floatingView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(gestureTapped)]];
      
      UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
      gestureRecognizer.minimumPressDuration = 0.5;
      [gestureRecognizer addTarget:self action:@selector(longPressedFired:)];
      [floatingView addGestureRecognizer:gestureRecognizer];
      
    }
    
    [[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"com.TitanD3v.SpotiLove/isInCollection" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
      bool isInCollection = [[[notification userInfo] objectForKey:@"isInCollection"] boolValue];
      if(isInCollection){
        if (floatingIconStyle == 0) {
          iconImage.image = [[UIImage systemImageNamed:@"heart.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        } else {
          iconImage.image = [[UIImage systemImageNamed:@"heart"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        if (toggleColour) {
          iconImage.tintColor = [[TDTweakManager sharedInstance] colourForKey:@"luvLikeColour" defaultValue:@"FFFFFF" ID:BID];
        } else {
          iconImage.tintColor = UIColor.systemGreenColor;
        }
      }
      else{
        if (floatingIconStyle == 0) {
          iconImage.image = [[UIImage systemImageNamed:@"heart.slash.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        } else {
          iconImage.image = [[UIImage systemImageNamed:@"heart.slash"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        
        if (toggleColour) {
          iconImage.tintColor = [[TDTweakManager sharedInstance] colourForKey:@"luvDislikeColour" defaultValue:@"FFFFFF" ID:BID];
        } else {
          iconImage.tintColor = UIColor.systemRedColor;
        }
      }
    }];
    
    [[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"com.TitanD3v.SpotiLove/SPTLNotification" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
      
      if(showNotification){
        bool isInCollectionLast = [[[notification userInfo] objectForKey:@"isInCollectionLast"] boolValue];
        
        if(!isInCollectionLast){
          NSString *title = [NSString stringWithFormat:@"%@ added to liked collection", songNameFull];
          if(![lastNotifTitle isEqual:title]){
            SPTLNotification(title);
          }
          NSLog(@"SpotiLove isInCollectionLast NOO title:-%@ lastNotifTitle:-%@", title, lastNotifTitle);
          lastNotifTitle = title;
        }
        else{
          NSString *title = [NSString stringWithFormat:@"%@ removed from liked collection", songNameFull];
          if(![lastNotifTitle isEqual:title]){
            SPTLNotification(title);
          }
          NSLog(@"SpotiLove isInCollectionLast YESS title:-%@ lastNotifTitle:-%@", title, lastNotifTitle);
          lastNotifTitle = title;
        }
      }
      
    }];
    
  }
  
}


%new 
-(void)longPressedFired:(UILongPressGestureRecognizer*)sender {
  
  if (sender.state == UIGestureRecognizerStateBegan) {
    [UIView animateWithDuration:0.2 animations:^ {
      floatingView.alpha = 0;
    }];
  } else if (sender.state == UIGestureRecognizerStateChanged) {
    [UIView animateWithDuration:0.2 animations:^ {
      floatingView.alpha = 0;
    }];
  } else if (sender.state == UIGestureRecognizerStateEnded) {
    [UIView animateWithDuration:0.2 animations:^ {
      floatingView.alpha = 0;
    }];
  }
  
}


%new
-(void)gestureTapped {
  
  if (toggleHaptic) {
    [[TDUtilities sharedInstance] haptic:hapticType];
  }
  
  [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.SpotiLove/addToCollection" object:nil userInfo:nil deliverImmediately:YES];
}


- (void)traitCollectionDidChange:(UITraitCollection *) previousTraitCollection {
  
  %orig;
  
  if (!toggleColour) {
    if([luvAppearance isEqualToString:@"luvDynamic"]) {
      
      if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
        blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
      } else {
        blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialLight];
      }
      
    }
  }
  
}

%end


%hook UIWindow

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
  
  %orig;
  if(event.type == UIEventSubtypeMotionShake && self == [[UIApplication sharedApplication] keyWindow]) {
    
    if(isSpotifyPlaying()) {
      [UIView animateWithDuration:0.2 animations:^ {
        floatingView.alpha = 1;
      }];
    }
    
  }
}

%end


%hook SPTNowPlayingAuxiliaryActionsModel
- (bool)isInCollection{
  //this is where we check if song is already in collection or nahh
  bool isInCollection = %orig;
  
  if(isInCollection != isInCollectionLast){
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.SpotiLove/isInCollection" object:nil userInfo:@{@"isInCollection" : @(isInCollection)} deliverImmediately:YES];
  }
  
  return isInCollectionLast = %orig;
}
%end


%hook SPTNowPlayingHeartButtonViewController
-(id)initWithModel:(id)arg1 auxiliaryActionsHandler:(id)arg2 testManager:(id)arg3 {
  [[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"com.TitanD3v.SpotiLove/addToCollection" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
    
    [collectionBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.SpotiLove/SPTLNotification" object:nil userInfo:@{@"isInCollectionLast" : @(isInCollectionLast)} deliverImmediately:YES];
  }];
  
  return %orig;
  
}

%end

%hook SPTNowPlayingHeartButtonViewController
-(id)animatedLikeButton {
  collectionBtn = %orig;
  return %orig;
}
%end


%hook SBMediaController

-(void)setNowPlayingInfo:(id)arg1 {
  %orig;
  
  //here we get current playing songname
  MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {
    NSDictionary *dict = (__bridge NSDictionary *)information;
    if (dict) {
      NSString *songName = [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoAlbum];
      NSString *songArtist = [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtist];
      
      if(songArtist != nil && songName != nil)
      songNameFull = [NSString stringWithFormat:@"%@ by %@", songName, songArtist];
      
      else if(songArtist != nil)
      songNameFull = songName;
      
      else
      songNameFull = [NSString stringWithFormat:@"by %@", songArtist];
      
    }
  });
  
  
  //Here we hide/show our likke button
  if(isSpotifyPlaying()){
    
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.TitanD3v.SpotiLove/showWindow" object:nil userInfo:nil deliverImmediately:YES];
    
  } else {
    topWindow = nil;
  }
}
%end
%end


void SettingsChanged() {
  
  toggleLuv = [[TDTweakManager sharedInstance] boolForKey:@"toggleLuv" defaultValue:NO ID:BID];
  showNotification = [[TDTweakManager sharedInstance] boolForKey:@"showNotification" defaultValue:YES ID:BID];
  floatingButtonSize = [[TDTweakManager sharedInstance] intForKey:@"floatingButtonSize" defaultValue:0 ID:BID];
  floatingButtonStyles = [[TDTweakManager sharedInstance] intForKey:@"floatingButtonStyles" defaultValue:0 ID:BID];
  hapticType = [[TDTweakManager sharedInstance] intForKey:@"hapticType" defaultValue:0 ID:BID];
  toggleHaptic = [[TDTweakManager sharedInstance] boolForKey:@"toggleHaptic" defaultValue:YES ID:BID];
  luvAppearance = [[TDTweakManager sharedInstance] objectForKey:@"luvAppearance" defaultValue:@"luvDark" ID:BID];
  toggleColour = [[TDTweakManager sharedInstance] boolForKey:@"toggleColour" defaultValue:NO ID:BID];
  floatingIconStyle = [[TDTweakManager sharedInstance] intForKey:@"floatingIconStyle" defaultValue:0 ID:BID];
}

%ctor {
  
  NSString * path = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
  if ([path containsString:@"/Application"] || [path containsString:@"SpringBoard.app"]) {
    
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)SettingsChanged, CFSTR("com.TitanD3v.LuvPrefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    SettingsChanged();
    
    if (toggleLuv) {
      %init(LuvHooks);
    }
    
  }
}
