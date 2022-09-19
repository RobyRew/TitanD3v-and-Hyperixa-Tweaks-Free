#import "ParadiseSettingViewController.h"
#import <spawn.h>

@interface NSBundle(priv)
- (instancetype)initWithURL:(NSURL *)url;
@end

@implementation ParadiseSettingViewController

- (NSArray *)specifiers {
	if (!_specifiers) {
		NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/ParadisePrefs.bundle/Assets/ExtSettings/"];
		_specifiers = [self loadSpecifiersFromPlistName:@"ExtPrimrary" target:self bundle:bundle];
	}

	return _specifiers;
}


- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = @"Settings";

	UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC)];
	self.navigationItem.leftBarButtonItem = closeButton;

	UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(respringSpringBoard)];
	self.navigationItem.rightBarButtonItem = applyButton;

	[[TDPrefsManager sharedInstance] enableExternalCellInset:YES];

	UITableView *tableView = self.view.subviews[0];

	UIView *header = [[UIView alloc] init];
	header.frame = CGRectMake(0, 0, tableView.bounds.size.width, 175);
	header.backgroundColor = UIColor.clearColor;
	tableView.tableHeaderView = header;


	self.iconImage = [[UIImageView alloc] init];
	self.iconImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Paradise.bundle/Settings/banner-icon.png"];
	self.iconImage.layer.cornerRadius = 15;
	self.iconImage.clipsToBounds = true;
	[header addSubview:self.iconImage];

	self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
	[self.iconImage.heightAnchor constraintEqualToConstant:70].active = YES;
	[self.iconImage.widthAnchor constraintEqualToConstant:70].active = YES;
	[self.iconImage.topAnchor constraintEqualToAnchor:header.topAnchor constant:20].active = YES;
	[[self.iconImage centerXAnchor] constraintEqualToAnchor:header.centerXAnchor].active = true;


	self.titleLabel = [[UILabel alloc] init];
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.titleLabel.textColor = UIColor.whiteColor;
	self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
	self.titleLabel.text = @"PARADISE";
	[header addSubview:self.titleLabel];

	[self.titleLabel x:header.centerXAnchor];
	[self.titleLabel top:self.iconImage.bottomAnchor padding:15];

	[tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

}


-(void)respringSpringBoard {
	[self dismissViewControllerAnimated:YES completion:nil];
	[[TDUtilities sharedInstance] respring];
}



-(void)dismissVC {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end


@implementation ParadiseAppearanceController

- (NSArray *)specifiers {
	if (!_specifiers) {
		NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/ParadisePrefs.bundle/"];
		_specifiers = [self loadSpecifiersFromPlistName:@"Appearance" target:self bundle:bundle];
	}

	return _specifiers;
}


- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = @"Appearance";

	[[TDPrefsManager sharedInstance] enableExternalCellInset:YES];

	UITableView *tableView = self.view.subviews[0];
	[tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

}

@end


@implementation ParadiseColourController

- (NSArray *)specifiers {
	if (!_specifiers) {
		NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/ParadisePrefs.bundle/"];
		_specifiers = [self loadSpecifiersFromPlistName:@"Colour" target:self bundle:bundle];
	}

	return _specifiers;
}


- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = @"Colour";

	[[TDPrefsManager sharedInstance] enableExternalCellInset:YES];

	UITableView *tableView = self.view.subviews[0];
	[tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

}

@end


@implementation ParadiseMiscellaneousController

- (NSArray *)specifiers {
	if (!_specifiers) {
		NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/ParadisePrefs.bundle/"];
		_specifiers = [self loadSpecifiersFromPlistName:@"Miscellaneous" target:self bundle:bundle];
	}

	return _specifiers;
}


- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = @"Miscellaneous";

	[[TDPrefsManager sharedInstance] enableExternalCellInset:YES];

	UITableView *tableView = self.view.subviews[0];
	[tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

}

@end
