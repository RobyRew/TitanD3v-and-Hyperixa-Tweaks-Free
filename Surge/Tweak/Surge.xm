#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "./SURGE/BannerView.h"
#import "./SURGE/CapsuleView.h"
#import "./SURGE/Colour-Scheme.h"
#import "Headers.h"


static NSString *surgeInterfaceStyle;
static BOOL toggleQuickAction;
static NSInteger alertPercentage;

static UIWindow *lpmWindow = nil;
BannerView *bannerView;
CapsuleView *capsuleView;
UIViewController *lpmBaseVC;
UIButton *lpmButton;
UILabel *lpmLabel;
static float bannerSize;
static float bannerYOffset;


@interface LPMPopViewController : UIViewController <UIPopoverPresentationControllerDelegate>
@end

@implementation LPMPopViewController
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
traitCollection:(UITraitCollection *)traitCollection {
  return UIModalPresentationNone;
}
@end


%group RemoveDefaultAlert

%hook SBLowPowerAlertItem

+(unsigned)_thresholdForLevel:(unsigned)level {

  [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];

  if (!([[UIDevice currentDevice] batteryState] == UIDeviceBatteryStateCharging)) {

    NSInteger firstLowAlert = 20;

    if (level == firstLowAlert) {

      NSLog(@"Battery at 20 percent");

    } else if ([[UIDevice currentDevice] batteryState] == UIDeviceBatteryStateCharging) {

      NSLog(@"Battery is charging");

    }

    if ((level == firstLowAlert -1 || level == firstLowAlert +1)) {

      NSLog(@"Battery is below 20 percent");
    }

  }

  return 99;

}

%end
%end


%group Surge

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)arg1 {

  %orig;

  [self layoutDeviceSize];
  [self setupLPM];

  [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryLevelChanged) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDismissNotification:) name:@"DismissLPMAlert" object:nil];

}


%new
- (void)batteryLevelChanged {

  float batteryLevel = [UIDevice currentDevice].batteryLevel * 100;
  NSInteger batteryCurrentLevel = batteryLevel;

  if (batteryCurrentLevel == alertPercentage) {
    [self invokeLPMBanner];
  }

}


%new
- (void)receiveDismissNotification:(NSNotification *) notification {

  if ([[notification name] isEqualToString:@"DismissLPMAlert"]) {
    [self dismissAlert];
  }

}


%new
-(void)layoutDeviceSize {

  if (iPhone_6_8) {
    bannerSize = 100;
    bannerYOffset = 25;
  } else if (iPhone_6_8_Plus) {
    bannerSize = 110;
    bannerYOffset = 25;
  } else if (iPhone_X_XS_11Pro) {
    bannerSize = 110;
    bannerYOffset = 40;
  } else if (iPhone_XR_XS_11Pro) {
    bannerSize = 120;
    bannerYOffset = 40;
  } else if (iPhone_12_Pro) {
    bannerSize = 110;
    bannerYOffset = 40;
  } else if (iPhone_12_mini) {
    bannerSize = 110;
    bannerYOffset = 25;
  } else if (iPhone_12_Pro_Max) {
    bannerSize = 120;
    bannerYOffset = 40;
  }

}


%new
-(void)setupLPM {

  if (!lpmWindow) {

    lpmWindow = [[UIWindow alloc] initWithFrame: CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 160)];
    lpmWindow.backgroundColor = [UIColor clearColor];
    lpmWindow.hidden = YES;
    lpmWindow.windowLevel = UIWindowLevelStatusBar + 100;
    [lpmWindow setUserInteractionEnabled:YES];

    if([surgeInterfaceStyle isEqualToString:@"surgeBanner"]) {

      bannerView = [[BannerView alloc] initWithFrame:CGRectMake(10, -150, MAIN_SCREEN_WIDTH -20, bannerSize)];
      [lpmWindow addSubview:bannerView];

    } else if([surgeInterfaceStyle isEqualToString:@"surgeCapsule"]) {

      capsuleView = [[CapsuleView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH /2 -135, -150, 270, 60)];
      [lpmWindow addSubview:capsuleView];

    }

  }

}


%new
-(void)invokeLPMBanner {


  [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];

  if (!([[UIDevice currentDevice] batteryState] == UIDeviceBatteryStateCharging)) {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"SurgePresented" object:self];

    lpmWindow.hidden = NO;

    [UIView animateWithDuration:0.3 animations:^{

      if([surgeInterfaceStyle isEqualToString:@"surgeBanner"]) {
        bannerView.frame = CGRectMake(10, bannerYOffset, MAIN_SCREEN_WIDTH -20, bannerSize);
      } else if([surgeInterfaceStyle isEqualToString:@"surgeCapsule"]) {
        capsuleView.frame = CGRectMake(MAIN_SCREEN_WIDTH /2 -135, 40, 270, 60);
      }

    }];

  }

}


%new
-(void)dismissAlert {

  [UIView animateWithDuration:0.3 animations:^{

    if([surgeInterfaceStyle isEqualToString:@"surgeBanner"]) {
      bannerView.frame = CGRectMake(10, -150, MAIN_SCREEN_WIDTH -20, bannerSize);
    } else if([surgeInterfaceStyle isEqualToString:@"surgeCapsule"]) {
      capsuleView.frame = CGRectMake(MAIN_SCREEN_WIDTH /2 -135, -150, 270, 60);
    }

  }];


  [self performSelector:@selector(dismissWindow) withObject:nil afterDelay:0.4];

}


%new
-(void)dismissWindow {

  lpmWindow.hidden = YES;
}

%end
%end


%group QuickAction
%hook _UIBatteryView

-(void)layoutSubviews {

  %orig;
  self.userInteractionEnabled = YES;
  [self addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(invokeLPMSheet)]];

}


%new
-(void)invokeLPMSheet {


  BOOL isEnabled = [[NSProcessInfo processInfo] isLowPowerModeEnabled];


  UIViewController *lpmBaseVC = [[UIViewController alloc] init];
  lpmBaseVC.modalPresentationStyle = UIModalPresentationPopover;
  lpmBaseVC.preferredContentSize = CGSizeMake(170,65);


  lpmButton = [[UIButton alloc] init];
  lpmButton.layer.cornerRadius = 25;
  lpmButton.clipsToBounds = true;
  if (isEnabled) {
    UIImage *disableImage = [[UIImage imageWithContentsOfFile:@"/Library/Application Support/Surge.bundle/Assets/disable.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [lpmButton setImage:disableImage forState:UIControlStateNormal];
    lpmButton.backgroundColor = UIColor.systemRedColor;
    if (toggleColourScheme) {
      lpmButton.backgroundColor = [UIColor surgeDisableColor];
    }
  } else {
    UIImage *enableImage = [[UIImage imageWithContentsOfFile:@"/Library/Application Support/Surge.bundle/Assets/enable.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [lpmButton setImage:enableImage forState:UIControlStateNormal];
    lpmButton.backgroundColor = UIColor.systemGreenColor;
    if (toggleColourScheme) {
      lpmButton.backgroundColor = [UIColor surgeEnableColor];
    }
  }
  lpmButton.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
  [lpmButton addTarget:self action:@selector(lpmAction) forControlEvents:UIControlEventTouchUpInside];
  [lpmBaseVC.view addSubview:lpmButton];

  lpmButton.translatesAutoresizingMaskIntoConstraints = NO;
  [lpmButton.widthAnchor constraintEqualToConstant:50.0].active = YES;
  [lpmButton.heightAnchor constraintEqualToConstant:50.0].active = YES;
  [[lpmButton centerYAnchor] constraintEqualToAnchor:lpmBaseVC.view.centerYAnchor].active = true;
  [lpmButton.trailingAnchor constraintEqualToAnchor:lpmBaseVC.view.trailingAnchor constant:-10].active = YES;


  lpmLabel = [[UILabel alloc] init];
  if (@available(iOS 13, *)) {
    lpmLabel.textColor = UIColor.labelColor;
  } else {
    lpmLabel.textColor = UIColor.blackColor;
  }
  lpmLabel.font = [UIFont boldSystemFontOfSize:14];
  if (isEnabled) {
    lpmLabel.text = @"Disable LPM";
  } else {
    lpmLabel.text = @"Enable LPM";
  }
  lpmLabel.textAlignment = NSTextAlignmentLeft;
  [lpmBaseVC.view addSubview:lpmLabel];

  lpmLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [[lpmLabel centerYAnchor] constraintEqualToAnchor:lpmBaseVC.view.centerYAnchor].active = true;
  [lpmLabel.leadingAnchor constraintEqualToAnchor:lpmBaseVC.view.leadingAnchor constant:10].active = YES;


  UIPopoverPresentationController *lpmPopUp = lpmBaseVC.popoverPresentationController;
  LPMPopViewController *vc = [[LPMPopViewController alloc] init];
  lpmPopUp.delegate = vc;
  lpmPopUp.permittedArrowDirections = UIPopoverArrowDirectionUp;
  lpmPopUp.sourceView = self;

  [[%c(SBIconController) sharedInstance] presentViewController:lpmBaseVC animated:YES completion:nil];


  if (toggleColourScheme) {

    lpmPopUp.backgroundColor = [UIColor surgeBackgroundColor];
    lpmButton.tintColor = [UIColor surgeIconColor];
    lpmLabel.textColor = [UIColor surgeFontColor];

  } else {
    lpmButton.tintColor = UIColor.whiteColor;
  }

  [self invokeHapticFeedback];

}


%new
-(void)lpmAction {

  [self invokeHapticFeedback];
  BOOL isEnabled = [[NSProcessInfo processInfo] isLowPowerModeEnabled];
  [%c(PSLowPowerModeSettingsDetail) setEnabled:!isEnabled];
  [[%c(SBIconController) sharedInstance] dismissViewControllerAnimated:lpmBaseVC completion:nil];

}


%new
-(void)invokeHapticFeedback {

  if (toggleHaptic) {

    if (surgeHapticStrength == 0) {
      [[TDUtilities sharedInstance] haptic:0];
    } else if (surgeHapticStrength == 1) {
      [[TDUtilities sharedInstance] haptic:1];
    } else if (surgeHapticStrength == 2) {
      [[TDUtilities sharedInstance] haptic:2];
    }

  }
}

%end


%hook UIApplication
-(void)applicationWillSuspend {
  %orig;
  [[%c(SBIconController) sharedInstance] dismissViewControllerAnimated:lpmBaseVC completion:nil];
}
%end
%end


void SettingsChanged() {

  toggleSurge = [[TDTweakManager sharedInstance] boolForKey:@"toggleSurge" defaultValue:NO ID:BID];
  surgeInterfaceStyle = [[TDTweakManager sharedInstance] objectForKey:@"surgeInterfaceStyle" defaultValue:@"surgeBanner" ID:BID];
  toggleColourScheme = [[TDTweakManager sharedInstance] boolForKey:@"toggleColourScheme" defaultValue:NO ID:BID];
  toggleHaptic = [[TDTweakManager sharedInstance] boolForKey:@"toggleHaptic" defaultValue:YES ID:BID];
  toggleQuickAction = [[TDTweakManager sharedInstance] boolForKey:@"toggleQuickAction" defaultValue:YES ID:BID];
  surgeHapticStrength = [[TDTweakManager sharedInstance] intForKey:@"surgeHapticStrength" defaultValue:0 ID:BID];
  alertPercentage = [[TDTweakManager sharedInstance] intForKey:@"alertPercentage" defaultValue:20 ID:BID];

}

%ctor {

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)SettingsChanged, CFSTR("com.TitanD3v.SurgePrefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    SettingsChanged();

      if (toggleSurge) {
        %init(RemoveDefaultAlert);
        %init(Surge);

        if (toggleQuickAction) {
          %init(QuickAction);
        }

      }

}
