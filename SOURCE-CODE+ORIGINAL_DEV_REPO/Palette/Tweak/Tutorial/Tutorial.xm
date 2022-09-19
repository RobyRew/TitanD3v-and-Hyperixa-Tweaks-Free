#import <TitanD3vUniversal/TitanD3vUniversal.h>

static NSString *BIDD = @"com.TitanD3v.PalettePrefs";
static BOOL togglePalettee;
static BOOL showSBTutorial;

@interface OBButtonTray : UIView
@property (nonatomic,retain) UIVisualEffectView * effectView;
- (void)addButton:(id)arg1;
- (void)addCaptionText:(id)arg1;
@end

@interface OBBoldTrayButton : UIButton
-(void)setTitle:(id)arg1 forState:(unsigned long long)arg2;
+(id)buttonWithType:(long long)arg1;
@end

@interface OBWelcomeController : UIViewController
@property (nonatomic,retain) UIView * viewIfLoaded;
@property (nonatomic,strong) UIColor * backgroundColor;
- (OBButtonTray *)buttonTray;
- (id)initWithTitle:(id)arg1 detailText:(id)arg2 icon:(id)arg3;
- (void)addBulletedListItemWithTitle:(id)arg1 description:(id)arg2 image:(id)arg3;
@end

@interface SpringBoard : UIView
-(void)presentPaletteTutorialVC;
@end


OBWelcomeController *tutorialController;


%group Tutorial
%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
  %orig;

  if ((togglePalettee) && (showSBTutorial)) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
      [self presentPaletteTutorialVC];
    });
  }
}

%new
-(void)presentPaletteTutorialVC {

  [[TDUtilities sharedInstance] haptic:0];

  tutorialController = [[OBWelcomeController alloc] initWithTitle:@"Palette" detailText:@"Tutorial" icon:[[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PalettePrefs.bundle/Assets/Banner/banner-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
  tutorialController.view.tintColor = [UIColor colorWithRed: 0.98 green: 0.41 blue: 0.17 alpha: 1.00];

  [tutorialController addBulletedListItemWithTitle:@"Gesture" description:@"Use your preferred gesture on the status bar to invoke Palette's colour picker." image:[UIImage systemImageNamed:@"hand.tap.fill"]];

  [tutorialController addBulletedListItemWithTitle:@"Warning!!!" description:@"When you finished selecting the colour or using the eyedrop tool then make sure you press on the close button then it will show more options afterwards so you can copy the colour code or add them to your collection. Don't swipe down to dismiss the colour picker unless you actually want to dismiss it. Otherwise press the close button." image:[UIImage systemImageNamed:@"exclamationmark.circle.fill"]];


  OBBoldTrayButton* dismissButton = [OBBoldTrayButton buttonWithType:1];
  [dismissButton addTarget:self action:@selector(dismissPaletteTutorialVC) forControlEvents:UIControlEventTouchUpInside];
  [dismissButton setTitle:@"Close" forState:UIControlStateNormal];
  [dismissButton setClipsToBounds:YES];
  [dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [dismissButton.layer setCornerRadius:15];
  [tutorialController.buttonTray addButton:dismissButton];

  tutorialController.buttonTray.effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

  UIVisualEffectView *tutorialVisualEffectView = [[UIVisualEffectView alloc] initWithFrame:tutorialController.viewIfLoaded.bounds];

  tutorialVisualEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

  [tutorialController.viewIfLoaded insertSubview:tutorialVisualEffectView atIndex:0];
  tutorialController.viewIfLoaded.backgroundColor = UIColor.clearColor;

  [tutorialController.buttonTray addCaptionText:@"Thank you for installing Palette"];

  tutorialController.modalPresentationStyle = UIModalPresentationPageSheet;
  tutorialController.modalInPresentation = YES;
  [[%c(SBIconController) sharedInstance] presentViewController:tutorialController animated:YES completion:nil];

}

%new
-(void)dismissPaletteTutorialVC {
  [[TDUtilities sharedInstance] haptic:0];
  [tutorialController dismissViewControllerAnimated:YES completion:nil];
  [[TDTweakManager sharedInstance] setBool:NO forKey:@"showSBTutorial" ID:BIDD];
}
%end
%end


void SettingsChanged2() {

  togglePalettee = [[TDTweakManager sharedInstance] boolForKey:@"togglePalette" defaultValue:YES ID:BIDD];
  showSBTutorial = [[TDTweakManager sharedInstance] boolForKey:@"showSBTutorial" defaultValue:YES ID:BIDD];

}

%ctor {
  NSString * path = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
  if ([path containsString:@"/Application"] || [path containsString:@"SpringBoard.app"]) {

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)SettingsChanged2, CFSTR("com.TitanD3v.PalettePrefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    SettingsChanged2();
    %init(Tutorial);
  }
}
