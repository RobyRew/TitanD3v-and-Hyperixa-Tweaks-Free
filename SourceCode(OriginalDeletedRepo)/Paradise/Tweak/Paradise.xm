#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "AppLibraryViewController.h"
#import "WidgetViewController.h"
#import "DataViewController.h"
#import "GlobalPreferences.h"
#import "ParadiseManager.h"
#import "Headers.h"


%group Paradise

%hook SBClockApplicationIconImageView

%new
-(void)presentAppDataVC:(UITapGestureRecognizer*)sender{

  SBIconImageView *iconImageView = (SBIconImageView*)sender.view;

  DataViewController *dvc = [[DataViewController alloc] initWithIconView:iconImageView.iconView imgTitle:@"Clock" iconID:@"com.apple.mobiletimer"];
  dvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
  [[%c(SBIconController) sharedInstance] presentViewController:dvc animated:YES completion:nil];
}
%end

%hook SBIconImageView

- (SBIconImageView *)initWithFrame:(CGRect)arg1 {

  SBIconImageView *r = %orig;

  UISwipeGestureRecognizer *sortGesture = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(presentAppDataVC:)];
  sortGesture.direction = UISwipeGestureRecognizerDirectionUp;
  [self addGestureRecognizer:sortGesture];

  r.userInteractionEnabled = YES;

  return r;
}

%new
-(void)presentAppDataVC:(UITapGestureRecognizer*)sender {

  if (toggleAppdataHaptic) {

    if (appdataHapticStrength == 0) {
      [[TDUtilities sharedInstance] haptic:0];
    } else if (appdataHapticStrength == 1) {
      [[TDUtilities sharedInstance] haptic:1];
    } else if (appdataHapticStrength == 2) {
      [[TDUtilities sharedInstance] haptic:2];
    }

  }

  SBIconImageView *iconImageView = (SBIconImageView*)sender.view;
  SBIcon *icon  = iconImageView.iconView.icon;

  NSString *title = self.iconView._labelImageParameters.text;
  NSString *bid;

  bool isApp = NO;
  bool isClock = NO;
  bool isWidget = NO;

  if([iconImageView.iconView isKindOfClass:[%c(SBWidgetIcon) class]]){
    SBWidgetIcon *widgetIcon = (SBWidgetIcon*)icon;
    bid = widgetIcon.leafIdentifier;
    isWidget = YES;
  }
  else if([icon isKindOfClass:[%c(SBFolderIcon) class]]){
    SBFolderIcon *folderIcon = (SBFolderIcon*)icon;
    bid = folderIcon.nodeIdentifier;
  }
  else if([icon isKindOfClass:[%c(SBApplicationIcon) class]]){
    bid = icon.applicationBundleID;
    isApp = YES;
  }
  else if([icon isKindOfClass:[%c(SBHLibraryPodCategoryIcon) class]]){
    SBHLibraryPodCategoryIcon *libraryPodCategoryIcon = (SBHLibraryPodCategoryIcon*)icon;
    bid = libraryPodCategoryIcon.leafIdentifier;
  }
  else if([icon isKindOfClass:[%c(SBBookmarkIcon) class]]){
    SBBookmarkIcon *bookmarkIcon = (SBBookmarkIcon*)icon;
    bid = bookmarkIcon.leafIdentifier;
  }
  else if([icon isKindOfClass:[%c(SBClockApplicationIconImageView) class]]){
    isClock = YES;
  }

  if(isApp){

    DataViewController *dvc = [[DataViewController alloc] initWithIconView:iconImageView.iconView imgTitle:title iconID:bid];
    dvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [[%c(SBIconController) sharedInstance] presentViewController:dvc animated:YES completion:nil];

  }
  else if(isWidget){

    WidgetViewController *widVC = [[WidgetViewController alloc] initWithHash:bid imgTitle:title iconView:self.iconView];
    widVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [[%c(SBIconController) sharedInstance] presentViewController:widVC animated:YES completion:nil];

  }
  else if(!isClock){

    AppLibraryViewController *libVC = [[AppLibraryViewController alloc] initWithHash:bid imgTitle:title iconView:self.iconView];
    libVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [[%c(SBIconController) sharedInstance] presentViewController:libVC animated:YES completion:nil];

  }

}

%end


static NSString *getAppName(NSString *BID){
  SBApplication *app = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:BID];
  return app.displayName;
}


%hook SBIconView
- (void)setApplicationShortcutItems:(NSArray *)arg1 {

  loadPrefs();

  NSMutableArray *newItems = [[NSMutableArray alloc] init];

  for (SBSApplicationShortcutItem *item in arg1) {
    [newItems addObject:item];
  }

  NSData *lightIcon = UIImagePNGRepresentation([[UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/paradise-menu-light.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]);
  NSData *darkIcon = UIImagePNGRepresentation([[UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Assets/Action Icons/paradise-menu-dark.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]);

  SBSApplicationShortcutItem *appItem;

  if (toggle3DMenu) {
    appItem = [%c(SBSApplicationShortcutItem) alloc];
    appItem.localizedTitle = @"Edit With Paradise";
    appItem.type = @"com.TitanD3v.Paradise.AppData";
  }

  SBSApplicationShortcutItem *widgetItem = [%c(SBSApplicationShortcutItem) alloc];
  widgetItem.localizedTitle = @"Edit With Paradise";
  widgetItem.type = @"com.TitanD3v.Paradise.PushWidgetsView";

  SBSApplicationShortcutCustomImageIcon *paradiseLightIcon = [[SBSApplicationShortcutCustomImageIcon alloc] initWithImagePNGData:lightIcon];
  SBSApplicationShortcutCustomImageIcon *paradiseDarkIcon = [[SBSApplicationShortcutCustomImageIcon alloc] initWithImagePNGData:darkIcon];

  if (self.icon.isWidgetIcon) {

    if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
      [widgetItem setIcon:paradiseDarkIcon];
    } else if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleLight) {
      [widgetItem setIcon:paradiseLightIcon];
    }

    [newItems addObject:widgetItem];

  } else if(!self.folderIcon) {

    if (toggle3DMenu) {

      if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
        [appItem setIcon:paradiseDarkIcon];
      } else if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleLight) {
        [appItem setIcon:paradiseLightIcon];
      }

      [newItems addObject:appItem];
    }

  }

  %orig(newItems);
}

+ (void)activateShortcut:(SBSApplicationShortcutItem *)item withBundleIdentifier:(NSString *)bundleID forIconView:(SBIconView *)iconView {

  NSLog(@"AJSGAJS activateShortcut iconView:-%@", iconView);


  if ([[item type] isEqualToString:@"com.TitanD3v.Paradise.AppData"]) {

    SBIcon *icon  = iconView.icon;

    NSLog(@"AJSGAJS iconImageView:-%@, icon:-%@", iconView.icon, icon);

    NSString *title = iconView._labelImageParameters.text;
    NSString *bid = icon.applicationBundleID;

    DataViewController *dvc = [[DataViewController alloc] initWithIconView:iconView imgTitle:title iconID:bid];
    dvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [[%c(SBIconController) sharedInstance] presentViewController:dvc animated:YES completion:nil];

  } else if ([[item type] isEqualToString:@"com.TitanD3v.Paradise.PushWidgetsView"]) {

    NSString *title = iconView._labelImageParameters.text;
    SBWidgetIcon *widgetIcon = (SBWidgetIcon*)iconView.icon;
    NSString *bid = widgetIcon.leafIdentifier;

    WidgetViewController *widVC = [[WidgetViewController alloc] initWithHash:bid imgTitle:title iconView:iconView];
    widVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [[%c(SBIconController) sharedInstance] presentViewController:widVC animated:YES completion:nil];

  } else {

    %orig;

  }
}


-(id)_labelImageParameters{

  SBMutableIconLabelImageParameters *param = %orig;
  NSString *bid;

  if([self.icon isKindOfClass:[%c(SBWidgetIcon) class]]){
    SBWidgetIcon *widgetIcon = (SBWidgetIcon*)self.icon;
    bid = widgetIcon.leafIdentifier;
  }
  else if([self.icon isKindOfClass:[%c(SBFolderIcon) class]]){
    SBFolderIcon *folderIcon = (SBFolderIcon*)self.icon;
    bid = folderIcon.nodeIdentifier;
  }
  else if([self.icon isKindOfClass:[%c(SBApplicationIcon) class]]){
    bid = self.icon.applicationBundleID;
  }
  else if([self.icon isKindOfClass:[%c(SBHLibraryPodCategoryIcon) class]]){
    SBHLibraryPodCategoryIcon *libraryPodCategoryIcon = (SBHLibraryPodCategoryIcon*)self.icon;
    bid = libraryPodCategoryIcon.leafIdentifier;
  }
  else if([self.icon isKindOfClass:[%c(SBBookmarkIcon) class]]){
    SBBookmarkIcon *bookmarkIcon = (SBBookmarkIcon*)self.icon;
    bid = bookmarkIcon.leafIdentifier;
  }

  NSString *keyT = [NSString stringWithFormat:@"%@-Title", bid];
  NSString *keyC = [NSString stringWithFormat:@"%@-Color", bid];
  NSString *keyBG = [NSString stringWithFormat:@"%@-BGColor", bid];

  NSString *newTitle = [[TDTweakManager sharedInstance] objectForKey:keyT defaultValue:@"" ID:@"com.TitanD3v.ParadisePrefs"];
  NSData *newColor = [[TDTweakManager sharedInstance] objectForKey:keyC defaultValue:@"" ID:@"com.TitanD3v.ParadisePrefs"];
  NSData *newBGColor = [[TDTweakManager sharedInstance] objectForKey:keyBG defaultValue:@"" ID:@"com.TitanD3v.ParadisePrefs"];

  if(newTitle.length !=0 )
  param.text = newTitle;

  if(newColor.length !=0 ){
    param.textColor = [NSKeyedUnarchiver unarchiveObjectWithData:newColor];
  }
  else{
    param.textColor = [UIColor whiteColor];
  }

  if(newBGColor.length !=0 ){
    param.focusHighlightColor = [NSKeyedUnarchiver unarchiveObjectWithData:newBGColor];
  }

  return param;
}
%end


%hook SBIconLegibilityLabelView

-(void)setIconView:(SBIconView *)arg1{

  %orig;

  if([self.iconView.icon isKindOfClass:[%c(SBHLibraryPodCategoryIcon) class]]){
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 2;
    [arg1 addGestureRecognizer:tapGesture];
  }

}

%new

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {

  NSString *title = self.imageParameters.text;
  SBHLibraryPodCategoryIcon *libraryPodCategoryIcon = (SBHLibraryPodCategoryIcon*)self.iconView.icon;
  NSString *bid = libraryPodCategoryIcon.leafIdentifier;

  if (sender.state == UIGestureRecognizerStateRecognized) {

    AppLibraryViewController *libVC = [[AppLibraryViewController alloc] initWithHash:bid imgTitle:title iconView:self.iconView];
    libVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [[%c(SBIconController) sharedInstance] presentViewController:libVC animated:YES completion:nil];

  }

}

%end
%end

void SettingsChanged() {
  toggleParadise = [[TDTweakManager sharedInstance] boolForKey:@"toggleParadise" defaultValue:NO ID:BID];
}


%ctor {

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)SettingsChanged, CFSTR("com.TitanD3v.ParadisePrefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    SettingsChanged();

      if (toggleParadise) {
        %init(Paradise);
      }
}
