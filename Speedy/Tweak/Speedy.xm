#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "SpeedyUninstallAppsViewController.h"
#import "Headers.h"


%group Speedy
%hook SBIconView
- (void)setApplicationShortcutItems:(NSArray *)arg1 {

  NSMutableArray *newItems = [[NSMutableArray alloc] init];

  for (SBSApplicationShortcutItem *item in arg1) {
    [newItems addObject:item];
  }

  NSData *lightIcon = UIImagePNGRepresentation([[UIImage imageWithContentsOfFile:@"/Library/Application Support/Speedy.bundle/Assets/uninstall-light.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]);
  NSData *darkIcon = UIImagePNGRepresentation([[UIImage imageWithContentsOfFile:@"/Library/Application Support/Speedy.bundle/Assets/uninstall-dark.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]);


  SBSApplicationShortcutItem *appItem = [%c(SBSApplicationShortcutItem) alloc];
  appItem.localizedTitle = @"Batch Uninstall Apps";
  appItem.type = @"com.TitanD3v.Speedy.UninstallApps";


  SBSApplicationShortcutCustomImageIcon *speedyLightIcon = [[SBSApplicationShortcutCustomImageIcon alloc] initWithImagePNGData:lightIcon];
  SBSApplicationShortcutCustomImageIcon *speedyDarkIcon = [[SBSApplicationShortcutCustomImageIcon alloc] initWithImagePNGData:darkIcon];


  if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
    [appItem setIcon:speedyDarkIcon];
  } else if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleLight) {
    [appItem setIcon:speedyLightIcon];
  }

  [newItems addObject:appItem];

  %orig(newItems);
}

+ (void)activateShortcut:(SBSApplicationShortcutItem *)item withBundleIdentifier:(NSString *)bundleID forIconView:(SBIconView *)iconView {

  if ([[item type] isEqualToString:@"com.TitanD3v.Speedy.UninstallApps"]) {

    SpeedyUninstallAppsViewController *uVC = [[SpeedyUninstallAppsViewController alloc] init];
    uVC.modalInPresentation = YES;
    [[%c(SBIconController) sharedInstance] presentViewController:uVC animated:YES completion:nil];

  } else {

    %orig;

  }
}

%end
%end


%ctor {

  NSString * path = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
  if ([path containsString:@"/Application"] || [path containsString:@"SpringBoard.app"]) {
    %init(Speedy);
  }
}
