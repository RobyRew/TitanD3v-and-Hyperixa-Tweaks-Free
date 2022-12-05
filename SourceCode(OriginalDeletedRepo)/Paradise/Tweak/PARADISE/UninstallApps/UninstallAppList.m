#import "UninstallAppList.h"

@interface _LSLazyPropertyList : NSObject
@property(readonly) NSDictionary *propertyList;
@end

@interface LSApplicationProxy : NSObject
@property(setter=_setLocalizedName:, nonatomic, copy) NSString *localizedName;
@property(nonatomic, readonly) NSString *bundleIdentifier;
@property(nonatomic, readonly) NSString *primaryIconName;
@property(nonatomic, readonly) NSDictionary *iconsDictionary;
@property(nonatomic, readonly) NSArray *appTags;
@property(setter=_setInfoDictionary:, nonatomic, copy)
_LSLazyPropertyList *_infoDictionary;
- (NSArray *)_boundIconFileNames;
- (NSArray *)boundIconFileNames;
@end

@interface LSApplicationWorkspace
+ (id)defaultWorkspace;
- (id)allInstalledApplications;
- (id)allApplications;
- (id)applicationsOfType:(unsigned long long)arg1;
- (id)applicationsWithUIBackgroundModes;
@end

@interface UninstallAppList ()
+ (NSString *)nameForApp:(LSApplicationProxy *)app;
@end

@interface UIImage (Private)
+(id)_applicationIconImageForBundleIdentifier:(NSString*)displayIdentifier format:(int)form scale:(CGFloat)scale;
@end

@implementation UninstallAppList

int iOSVersion;
+ (NSMutableArray *)userApps {

  NSMutableArray *userApps = [NSMutableArray new];
  NSMutableArray *defaultWorkspaceApps =
  [[NSClassFromString(@"LSApplicationWorkspace") defaultWorkspace]
  applicationsOfType:0];

  for (LSApplicationProxy *app in defaultWorkspaceApps) {
    [userApps addObject:@{
      @"bundleID" : app.bundleIdentifier,
      @"name" : [self nameForApp:app]
    }];
  }
  return [self sortArray:userApps];
}

+ (NSMutableArray *)audioApps {

  NSMutableArray *audioApps = [NSMutableArray new];
  NSMutableArray *defaultWorkspaceApps =
  [[NSClassFromString(@"LSApplicationWorkspace") defaultWorkspace]
  applicationsWithUIBackgroundModes];

  for (LSApplicationProxy *app in defaultWorkspaceApps) {
    NSDictionary *info = app._infoDictionary.propertyList;
    NSArray *background = info[@"UIBackgroundModes"];
    if (background && [background containsObject:@"audio"]) {
      if ([self hasIconAndVisible:app.bundleIdentifier]) {
        [audioApps addObject:@{
          @"bundleID" : app.bundleIdentifier,
          @"name" : [self nameForApp:app]
        }];
      }
    }
  }
  return [self sortArray:audioApps];
}

+ (NSMutableArray *)systemApps {

  NSMutableArray *systemApps = [NSMutableArray new];
  NSMutableArray *defaultWorkspaceApps =
  [[NSClassFromString(@"LSApplicationWorkspace") defaultWorkspace]
  applicationsOfType:1];

  for (LSApplicationProxy *app in defaultWorkspaceApps) {
    if ([self hasIconAndVisible:app.bundleIdentifier]) {
      [systemApps addObject:@{
        @"bundleID" : app.bundleIdentifier,
        @"name" : [self nameForApp:app]
      }];
    }
  }

  return [self sortArray:systemApps];
}

+ (NSMutableArray *)allApps {

  NSMutableArray *allApps = [NSMutableArray new];
  NSMutableArray *defaultWorkspaceApps =
  [[NSClassFromString(@"LSApplicationWorkspace") defaultWorkspace]
  allApplications];
  for (LSApplicationProxy *app in defaultWorkspaceApps) {
    if ([self hasIconAndVisible:app.bundleIdentifier]) {
      [allApps addObject:@{
        @"bundleID" : app.bundleIdentifier,
        @"name" : [self nameForApp:app]
      }];
    }
  }
  return [self sortArray:allApps];
}

+ (BOOL)hasIconAndVisible:(NSString *)bundleIdentifier {
  NSArray *blacklist = [NSArray arrayWithObjects:@"com.apple.Magnifier",
  @"com.apple.InCallService",
  @"com.apple.RemoteiCloudQuotaUI",
  @"com.apple.PublicHealthRemoteUI",
  @"com.apple.CarPlaySplashScreen",
  @"com.apple.iMessageAppsViewService",
  @"com.apple.BarcodeScanner",
  @"com.apple.HealthENLauncher",
  @"com.apple.AXUIViewService",
  @"com.apple.AppSSOUIService",
  @"com.apple.CarPlaySettings",
  @"com.apple.mobilesms.compose",
  @"com.apple.BusinessChatViewService",
  @"com.apple.DiagnosticsService",
  @"com.apple.CTNotifyUIService",
  @"com.apple.HealthPrivacyService",
  @"com.apple.WebContentFilter.remoteUI.WebContentAnalysisUI",
  @"com.apple.ScreenshotServicesService",
  @"com.apple.FTMInternal",
  @"com.apple.carkit.DNDBuddy",
  @"com.apple.PreBoard",
  @"com.apple.datadetectors.DDActionsService",
  @"com.apple.DemoApp",
  @"com.apple.CoreAuthUI",
  @"com.apple.SubcredentialUIService",
  @"com.apple.MailCompositionService",
  @"com.apple.Diagnostics",
  @"com.apple.AuthKitUIService",
  @"com.apple.TVRemote",
  @"com.apple.gamecenter.GameCenterUIService",
  @"com.apple.PrintKit.Print-Center",
  @"com.apple.sidecar",
  @"com.apple.AccountAuthenticationDialog",
  @"com.apple.PassbookUIService",
  @"com.apple.siri",
  @"com.apple.CloudKit.ShareBear",
  @"com.apple.HealthENBuddy",
  @"com.apple.SafariViewService",
  @"com.apple.SIMSetupUIService",
  @"com.apple.CompassCalibrationViewService",
  @"com.apple.PhotosViewService",
  @"com.apple.MusicUIService",
  @"com.apple.TrustMe",
  @"com.apple.Home.HomeUIService",
  @"com.apple.CTCarrierSpaceAuth",
  @"com.apple.StoreDemoViewService",
  @"com.apple.susuiservice",
  @"com.apple.social.SLYahooAuth",
  @"com.apple.Spotlight",
  @"com.apple.fieldtest",
  @"com.apple.WebSheet",
  @"com.apple.iad.iAdOptOut",
  @"com.apple.dt.XcodePreviews",
  @"com.apple.appleseed.FeedbackAssistant",
  @"com.apple.FontInstallViewService",
  @"com.apple.ScreenSharingViewService",
  @"com.apple.SharedWebCredentialViewService",
  @"com.apple.CheckerBoard",
  @"com.apple.DataActivation",
  @"com.apple.TVAccessViewService",
  @"com.apple.VSViewService",
  @"com.apple.TVRemoteUIService",
  @"com.apple.SharingViewService",
  @"com.apple.ios.StoreKitUIService",
  @"com.apple.purplebuddy",
  @"com.apple.ScreenTimeUnlock",
  @"com.apple.webapp",
  @"com.apple.ActivityMessagesApp",
  @"com.apple.icloud.apps.messages.business",
  @"com.apple.ClipViewService",
  @"com.apple.CredentialSharingService",
  @"com.apple.ctkui",
  @"com.apple.FunCamera.EmojiStickers",
  @"com.apple.siri.parsec.HashtagImagesApp",
  @"com.apple.icq",
  @"com.apple.Jellyfish",
  @"com.apple.Animoji.StickersApp",
  @"com.apple.PassbookSecureUIService",
  @"com.apple.Photos.PhotosUIService",
  @"com.apple.shortcuts.runtime",
  @"com.apple.SleepLockScreen",
  @"com.apple.FunCamera.TextPicker",
  @"com.apple.FunCamera.ShapesPicker",
  @"com.apple.smsFilter",
  @"com.apple.AskPermissionUI", nil];
  UIImage *image = [UIImage _applicationIconImageForBundleIdentifier:bundleIdentifier format:2 scale:[UIScreen mainScreen].scale];
  NSData *imageData = UIImagePNGRepresentation(image);
  if(imageData.length == 9762 || [blacklist containsObject:bundleIdentifier])
  return NO;
  return YES;
}

+ (NSString *)nameForApp:(LSApplicationProxy *)app {
  return (app.localizedName ? app.localizedName : app.bundleIdentifier);
}

+(NSMutableArray*)sortArray:(NSMutableArray*)arrayToSort{
  NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
  return [[arrayToSort sortedArrayUsingDescriptors:@[sort]] mutableCopy];
}
@end
