#include "BZYPrimraryListController.h"

static NSString *BID = @"com.TitanD3v.BreezyPrefs";
static NSString *tweakName = @"Breezy";

@implementation BZYPrimraryListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Primrary" target:self];
	}

	return _specifiers;
}


- (void)viewDidLoad {
	[super viewDidLoad];

	[[TDPrefsManager sharedInstance] initWithBundleID:@"com.TitanD3v.BreezyPrefs" tweakName:@"Breezy" prefsBundle:@"BreezyPrefs.bundle"];

	[[TDPrefsManager sharedInstance] bannerTitle:@"Breezy" subtitle:@"Coded with 🤍" devName:@"TitanD3v" coverImagePath:@"/Assets/Banner/cover-image.png" showCoverImage:YES iconPath:@"" iconTint:NO];

	[[TDPrefsManager sharedInstance] changelogPlistPath:@"/Assets/Changelog/changelog.plist" currentVersion:@"Version 1.0"];

	[[TDPrefsManager sharedInstance] useAssetsFromLibrary:YES];

}


-(void)presentTutorialVC {

	[[TDUtilities sharedInstance] haptic:0];

	onboardingController = [[OBWelcomeController alloc] initWithTitle:@"User Guide" detailText:@"A walk through tutorial how to use Breezy" icon:[[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/BreezyPrefs.bundle/Assets/Banner/banner-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];

	[onboardingController addBulletedListItemWithTitle:@"Your time" description:@"Please take a few minutes of your time to read through to get started." image:[UIImage systemImageNamed:@"timer"]];

	[onboardingController addBulletedListItemWithTitle:@"Main page" description:@"On the main page, there's menu icon on the navigation bar it will present the drawer when tapped. You will find the social media details, changelog, backup/restore, themes, tweak list, profile and crew list." image:[UIImage systemImageNamed:@"square.stack.fill"]];

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

	[onboardingController.buttonTray addCaptionText:@"Thank you for installing Breezy"];

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
