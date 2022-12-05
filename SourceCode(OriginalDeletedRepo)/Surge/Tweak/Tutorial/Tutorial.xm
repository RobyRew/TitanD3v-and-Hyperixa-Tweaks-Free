#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Global-Preferences.h"

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
-(void)presentSurgeTutorialVC;
@end 


OBWelcomeController *tutorialController;


%group Tutorial
%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
 %orig;

 loadPrefs();

if ((toggleSurge) && (showSBTutorial)) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		[self presentSurgeTutorialVC];
    });
}
}

%new
-(void)presentSurgeTutorialVC {

	[[TDUtilities sharedInstance] haptic:0];

	tutorialController = [[OBWelcomeController alloc] initWithTitle:@"Surge" detailText:@"Tutorial" icon:[[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/SurgePrefs.bundle/Assets/Banner/banner-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
	tutorialController.view.tintColor = [UIColor colorWithRed: 0.98 green: 0.41 blue: 0.17 alpha: 1.00];

	[tutorialController addBulletedListItemWithTitle:@"LPM" description:@"Just tap on the battery icon from the statusbar to enable/disable LPM, you can only do that if your device isn't charging." image:[UIImage systemImageNamed:@"battery.100"]];


	OBBoldTrayButton* dismissButton = [OBBoldTrayButton buttonWithType:1];
	[dismissButton addTarget:self action:@selector(dismissSurgeTutorialVC) forControlEvents:UIControlEventTouchUpInside];
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

	[tutorialController.buttonTray addCaptionText:@"Thank you for installing Surge"];

	tutorialController.modalPresentationStyle = UIModalPresentationPageSheet;
	tutorialController.modalInPresentation = YES;
    [[%c(SBIconController) sharedInstance] presentViewController:tutorialController animated:YES completion:nil];

}

%new
-(void)dismissSurgeTutorialVC {
	[[TDUtilities sharedInstance] haptic:0];
	[tutorialController dismissViewControllerAnimated:YES completion:nil];
    [[TDTweakManager sharedInstance] setBool:NO forKey:@"showSBTutorial" ID:BID];
}
%end
%end


%ctor {
    loadPrefs();
	NSString * path = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
	if ([path containsString:@"/Application"] || [path containsString:@"SpringBoard.app"]) {
		%init(Tutorial);
	}
}
