#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "GlobalPreferences.h"

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
-(void)presentTutorialVC;
@end 


OBWelcomeController *tutorialController;


%group Tutorial
%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
 %orig;

 loadPrefs();

if ((toggleParadise) && (showSBTutorial)) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		[self presentTutorialVC];
    });
}
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTutorialNotification:) name:@"ShowTutorialNotification" object:nil];
}


%new 
- (void)receiveTutorialNotification:(NSNotification *) notification {

    if ([[notification name] isEqualToString:@"ShowTutorialNotification"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		[self presentTutorialVC];
    });
    }
}


%new
-(void)presentTutorialVC {

	[[TDUtilities sharedInstance] haptic:0];

	tutorialController = [[OBWelcomeController alloc] initWithTitle:@"Paradise" detailText:@"Tutorial" icon:[[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/ParadisePrefs.bundle/Assets/Banner/banner-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
	tutorialController.view.tintColor = [UIColor colorWithRed: 0.98 green: 0.41 blue: 0.17 alpha: 1.00];

	[tutorialController addBulletedListItemWithTitle:@"App Icons" description:@"Just swipe up on any app icons and it will open paradise, if you have 3D Touch menu enabled from Paradise’s settings then long press on an app icon and click “Edit With Paradise” then you can rename the app label, change the label colour or the background. Copy an app’s information, open the app container or bundle in Filza, offload the app to optimise your storage space and keep app data. You can uninstall multiple apps, just select which apps you want to uninstall then press the “Uninstall” button to uninstall all of them in one go. If you want to edit the icons then click “Icon Editor” it will open the Paradise App and you can start designing some icons, make sure you selected your preferred theme folder for it to save your icon to that folder and apply it with any theme engine. " image:[UIImage systemImageNamed:@"square.fill"]];

    [tutorialController addBulletedListItemWithTitle:@"Widgets" description:@"Long press on any widgets and the 3D Touch menu will appear, click “Edit With Paradise” and you can rename the widget name, change the  label colour or the labels background colour and reset 3 of them." image:[UIImage systemImageNamed:@"rectangle.3.offgrid.fill"]];

	[tutorialController addBulletedListItemWithTitle:@"Folders" description:@"Just swipe up any folders and it will open paradise and you can rename the folders name, change the label colour or the labels background colour and reset 3 of them." image:[UIImage systemImageNamed:@"folder.fill"]];

	[tutorialController addBulletedListItemWithTitle:@"Bookmark" description:@"Just swipe up on any bookmark icons and it will open paradise and you can rename the bookmark’s name, change the labels colour or the label background colour and reset 3 of them." image:[UIImage systemImageNamed:@"bookmark.circle"]];

	[tutorialController addBulletedListItemWithTitle:@"App Library" description:@"Just double tap on any folders from the App Library, make sure you double tap the folders near the edges and it will open Paradise. You can rename the App Library name, change the labels colour or the labels background colour and reset 3 of them." image:[UIImage systemImageNamed:@"square.grid.2x2.fill"]];


	OBBoldTrayButton* dismissButton = [OBBoldTrayButton buttonWithType:1];
	[dismissButton addTarget:self action:@selector(dismissUpdateVC) forControlEvents:UIControlEventTouchUpInside];
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

	[tutorialController.buttonTray addCaptionText:@"Thank you for installing Paradise"];

	tutorialController.modalPresentationStyle = UIModalPresentationPageSheet;
	tutorialController.modalInPresentation = YES;
    [[%c(SBIconController) sharedInstance] presentViewController:tutorialController animated:YES completion:nil];

}

%new
-(void)dismissUpdateVC {
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
