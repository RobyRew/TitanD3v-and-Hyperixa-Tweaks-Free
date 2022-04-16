#include "NOVPrimraryListController.h"


@implementation NOVPrimraryListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Primrary" target:self];
	}

	return _specifiers;
}


- (void)viewDidLoad {
	[super viewDidLoad];

	[[TDPrefsManager sharedInstance] initWithBundleID:@"com.TitanD3v.NovaPrefs" tweakName:@"Nova" prefsBundle:@"NovaPrefs.bundle"];

	[[TDPrefsManager sharedInstance] bannerTitle:@"Nova" subtitle:@"Coded with 🤍" devName:@"TitanD3v" coverImagePath:@"/Assets/Banner/cover-image.png" showCoverImage:YES iconPath:@"/Assets/Banner/banner-icon.png" iconTint:NO];

	[[TDPrefsManager sharedInstance] changelogPlistPath:@"/Assets/Changelog/changelog.plist" currentVersion:@"Version 1.3"];

	[[TDPrefsManager sharedInstance] useAssetsFromLibrary:YES];

}


-(void)presentTutorialVC {

	[[TDUtilities sharedInstance] haptic:0];

	onboardingController = [[OBWelcomeController alloc] initWithTitle:@"User Guide" detailText:@"A walk through tutorial how to use Nova" icon:[[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/NovaPrefs.bundle/Assets/Banner/banner-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

	[onboardingController addBulletedListItemWithTitle:@"Your time" description:@"Please take a few minutes of your time to read through to get started." image:[UIImage systemImageNamed:@"timer"]];

	[onboardingController addBulletedListItemWithTitle:@"Main page" description:@"On the main page, there's menu icon on the navigation bar it will present the drawer when tapped. You will find the social media details, changelog, backup/restore, themes, tweak list, profile and crew list." image:[UIImage systemImageNamed:@"square.stack.fill"]];

    [onboardingController addBulletedListItemWithTitle:@"Purchase" description:@"Once you activate the 2 day free trial or purchase Nova then you will need to respring, after that you can enable Nova" image:[UIImage systemImageNamed:@"dollarsign.circle.fill"]];

	[onboardingController addBulletedListItemWithTitle:@"Compose" description:@"You can change your chat bubble avatar image and name from Compose Settings otherwise it will use the default settings" image:[UIImage systemImageNamed:@"pencil.circle.fill"]];

	[onboardingController addBulletedListItemWithTitle:@"Colour" description:@"You can change the colour of Nova user interface if you don’t want it to adapt your system appearance for light or dark mode from the Colour section" image:[UIImage systemImageNamed:@"eyedropper.full"]];

	[onboardingController addBulletedListItemWithTitle:@"Miscellaneous" description:@"You can configure some settings such as the floating button alignment, haptic feedback, etc from the Miscellaneous section" image:[UIImage systemImageNamed:@"gear"]];

	[onboardingController addBulletedListItemWithTitle:@"Review" description:@"Please make sure to write a review for Nova, we would love to hear your feedback about Nova so we can improve it for its users." image:[UIImage systemImageNamed:@"star.circle.fill"]];
	
	[onboardingController addBulletedListItemWithTitle:@"Report a bug" description:@"If you are experiencing a bug or any other issues, you can report a bug from this page below the close button, it will bring up the Bug Report page. You can select the categories, write description about a bug, attach a .txt file, photo, provide URL link for the pastebin or any pasteboard website also you can attach all of them if you want. Once you submit a bug report and our team will be in touch with you within 48 hours. If you haven't heard anything from us and please don't hesitate to get in touch with us through social media." image:[UIImage systemImageNamed:@"ant.circle.fill"]];
	
	OBBoldTrayButton* dismissButton = [OBBoldTrayButton buttonWithType:1];
	[dismissButton addTarget:self action:@selector(dismissTutorialVC) forControlEvents:UIControlEventTouchUpInside];
	[dismissButton setTitle:@"Close" forState:UIControlStateNormal];
	[dismissButton setClipsToBounds:YES];
	[dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[dismissButton.layer setCornerRadius:15];
	[onboardingController.buttonTray addButton:dismissButton];

	onboardingController.buttonTray.effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

	UIVisualEffectView *tutorialVisualEffectView = [[UIVisualEffectView alloc] initWithFrame:onboardingController.viewIfLoaded.bounds];

	tutorialVisualEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

	[onboardingController.viewIfLoaded insertSubview:tutorialVisualEffectView atIndex:0];
	onboardingController.viewIfLoaded.backgroundColor = UIColor.clearColor;

	[onboardingController.buttonTray addCaptionText:@"Thank you for installing Nova"];

	onboardingController.modalPresentationStyle = UIModalPresentationPageSheet;
	onboardingController.modalInPresentation = YES;
	[self presentViewController:onboardingController animated:YES completion:nil];

	UIView *reportView = [[UIView alloc] init];
	reportView.backgroundColor = UIColor.clearColor;
	[onboardingController.buttonTray addSubview:reportView];

	reportView.translatesAutoresizingMaskIntoConstraints = NO;
	[reportView.topAnchor constraintEqualToAnchor:dismissButton.bottomAnchor constant:10].active = YES;
	[[reportView centerXAnchor] constraintEqualToAnchor:onboardingController.buttonTray.centerXAnchor].active = true;
	[reportView.widthAnchor constraintEqualToConstant:140].active = YES;
	[reportView.heightAnchor constraintEqualToConstant:40].active = YES;


	UIImageView *bugImage = [[UIImageView alloc] init];
	bugImage.image = [[UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Cells/bug.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	bugImage.tintColor = [[TDAppearance sharedInstance] tintColour];
	[reportView addSubview:bugImage];

	bugImage.translatesAutoresizingMaskIntoConstraints = NO;
	[bugImage.leadingAnchor constraintEqualToAnchor:reportView.leadingAnchor constant:10].active = YES;
	[[bugImage centerYAnchor] constraintEqualToAnchor:reportView.centerYAnchor].active = true;
	[bugImage.widthAnchor constraintEqualToConstant:30].active = YES;
	[bugImage.heightAnchor constraintEqualToConstant:30].active = YES;


	UILabel *reportLabel = [[UILabel alloc] init];
	reportLabel.text = @"Report a bug";
	reportLabel.textColor = [[TDAppearance sharedInstance] tintColour];
	reportLabel.textAlignment = NSTextAlignmentLeft;
	[reportView addSubview:reportLabel];

	reportLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[reportLabel.leadingAnchor constraintEqualToAnchor:bugImage.trailingAnchor constant:5].active = YES;
	[[reportLabel centerYAnchor] constraintEqualToAnchor:reportView.centerYAnchor].active = true;

	[reportView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentReportBugVC)]];

}


-(void)dismissTutorialVC {
	[[TDUtilities sharedInstance] haptic:0];
	[onboardingController dismissViewControllerAnimated:YES completion:nil];
}


-(void)presentReportBugVC {
	[[TDUtilities sharedInstance] haptic:0];
	[onboardingController dismissViewControllerAnimated:YES completion:nil];

	TDReportBugViewController *bugVC = [[TDReportBugViewController alloc] init];
	bugVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
	[self presentViewController:bugVC animated:YES completion:nil];
}

@end
