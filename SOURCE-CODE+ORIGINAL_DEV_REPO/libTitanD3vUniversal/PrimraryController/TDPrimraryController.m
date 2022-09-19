#import "TDPrimraryController.h"
#import <Foundation/Foundation.h>

#define MAIN_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAIN_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation TDPrimraryController

- (void)viewDidLoad {
	[super viewDidLoad];
	
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	
	UIButton *drawerButton = [[UIButton alloc] init];
	drawerButton.backgroundColor = UIColor.clearColor;
	UIImage *drawerImage = [[UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/drawer-menu.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	[drawerButton setImage:drawerImage forState:UIControlStateNormal];
	[drawerButton addTarget:self action:@selector(openDrawer) forControlEvents:UIControlEventTouchUpInside];
	drawerButton.tintColor = self.tintColour;
	
	[drawerButton.widthAnchor constraintEqualToConstant:25].active = YES;
	[drawerButton.heightAnchor constraintEqualToConstant:25].active = YES;
	
	UIBarButtonItem *drawerItem = [[UIBarButtonItem alloc] initWithCustomView:drawerButton];
	self.navigationItem.rightBarButtonItems = @[drawerItem];
	
	
	self.navigationBarColour = [[TDAppearance sharedInstance] navigationBarColour];
	self.tintColour = [[TDAppearance sharedInstance] tintColour];
	self.backgroundColour = [[TDAppearance sharedInstance] backgroundColour];
	self.cellsColour = [[TDAppearance sharedInstance] cellColour];
	self.labelColour = [[TDAppearance sharedInstance] labelColour];
	
	
	UINavigationBar *bar = self.navigationController.navigationController.navigationBar;
	bar.barTintColor = self.navigationBarColour;
	bar.tintColor = self.tintColour;
	[[UIButton appearance]setTintColor:self.tintColour];
	self.view.tintColor = self.tintColour;
	
	
	UITableView *tableView = self.view.subviews[0];
	tableView.backgroundColor = self.backgroundColour;
	[tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	
	[[UILabel appearance] setTextColor:self.labelColour];
	
	
	UIWindow *keyWindow = nil;
	NSArray *windows = [[UIApplication sharedApplication] windows];
	for (UIWindow *window in windows) {
		if (window.isKeyWindow) {
			keyWindow = window;
			break;
		}
	}
	
	keyWindow.tintColor = self.tintColour;
	
	
	UIView *navbarContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
	NSString *profileNameString = [[TDPrefsManager sharedInstance] objectForKey:@"profileName" defaultValue:@"UserName"];
	self.greetingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,150,50)];
	self.greetingLabel.font = [UIFont systemFontOfSize:10];
	self.greetingLabel.textColor = self.labelColour;
	self.greetingLabel.textAlignment = NSTextAlignmentCenter;
	self.greetingLabel.numberOfLines = 2;
	self.greetingLabel.alpha = 0;
	self.greetingLabel.text = [NSString stringWithFormat:@"%@ \n%@", [[TDUtilities sharedInstance] greeting], profileNameString];
	[navbarContainerView addSubview:self.greetingLabel];
	
	self.navigationItem.titleView = navbarContainerView;
	
	
	TDBannerView *header = [[TDBannerView alloc] init];
	header.frame = CGRectMake(0, 0, tableView.bounds.size.width, 250);
	tableView.tableHeaderView = header;
	
	
	self.licenceImage = [[UIImageView alloc] init];
	// if (self.licenceStatus == 0) {
	// 	self.licenceImage.image = nil;
	// } else if (self.licenceStatus == 1) {
	// 	self.licenceImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Licence/unowned.png"];
	// } else if (self.licenceStatus == 2) {
	// 	self.licenceImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Licence/trial.png"];
	// } else if (self.licenceStatus == 3) {
	// 	self.licenceImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Licence/owned.png"];
	// }
	[header.baseView addSubview:self.licenceImage];
	
	[self.licenceImage size:CGSizeMake(65, 65)];
	[self.licenceImage top:header.topAnchor padding:5];
	[self.licenceImage trailing:header.trailingAnchor padding:-5];
	
	
	self.blurEffectView = [[UIVisualEffectView alloc] init];
	self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
	self.blurEffectView.alpha = 0;
	[self.view addSubview:self.blurEffectView];
	
	self.blurEffectView.translatesAutoresizingMaskIntoConstraints = false;
	[self.blurEffectView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
	[self.blurEffectView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
	[self.blurEffectView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
	[self.blurEffectView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
	
	
	self.respringController = [[UIRefreshControl alloc] init];
	[self.respringController addTarget:self action:@selector(beginRespring:) forControlEvents:UIControlEventValueChanged];
	NSString *title = @"Respring";
	NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:self.tintColour forKey:NSForegroundColorAttributeName];
	NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
	self.respringController.attributedTitle = attributedTitle;
	self.respringController.tintColor = self.tintColour;
	[tableView addSubview:self.respringController];
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissDrawerNotification:) name:@"DismissDrawer" object:nil];
	
	
	self.tutorialView = [[TDBlurView alloc] initWithFrame:self.view.bounds style:Dark];
	self.tutorialView.clipsToBounds = true;
	self.tutorialView.layer.cornerRadius = 30;
	self.tutorialView.alpha = 0;
	[self.view addSubview:self.tutorialView];
	
	self.tutorialView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.tutorialView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-15].active = YES;
	[self.tutorialView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-15].active = YES;
	[self.tutorialView.widthAnchor constraintEqualToConstant:60].active = YES;
	[self.tutorialView.heightAnchor constraintEqualToConstant:60].active = YES;
	
	
	self.tutorialImage = [[UIImageView alloc] init];
	self.tutorialImage.image = [[UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Icons/tutorial.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	[self.tutorialView addSubview:self.tutorialImage];
	
	self.tutorialImage.translatesAutoresizingMaskIntoConstraints = NO;
	[self.tutorialImage.widthAnchor constraintEqualToConstant:45].active = YES;
	[self.tutorialImage.heightAnchor constraintEqualToConstant:45].active = YES;
	[[self.tutorialImage centerYAnchor] constraintEqualToAnchor:self.tutorialView.centerYAnchor].active = true;
	[[self.tutorialImage centerXAnchor] constraintEqualToAnchor:self.tutorialView.centerXAnchor].active = true;
	
	[self.tutorialView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(presentTutorialVC)]];
	
	
	[UIView animateWithDuration:1.0 animations:^{
		self.greetingLabel.alpha = 1;
		self.tutorialView.alpha = 1;
	}];
	
}


- (void)dismissDrawerNotification:(NSNotification *) notification {
	
	if ([[notification name] isEqualToString:@"DismissDrawer"]){
		[self dismissDrawerVC];
	}
}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	UIWindow *keyWindow = nil;
	NSArray *windows = [[UIApplication sharedApplication] windows];
	for (UIWindow *window in windows) {
		if (window.isKeyWindow) {
			keyWindow = window;
			break;
		}
	}
	
	keyWindow.tintColor = [[UINavigationBar appearance] tintColor];
	
	
	UINavigationBar *bar = self.navigationController.navigationController.navigationBar;
	bar.barTintColor = [[UINavigationBar appearance] barTintColor];
	bar.tintColor = [[UINavigationBar appearance] tintColor];
	
	self.view.tintColor = nil;
	[[UIButton appearance]setTintColor:nil];
	[[UILabel appearance] setTextColor:nil];
	
	[UIView animateWithDuration:0.4 animations:^{
		self.greetingLabel.alpha = 0;
		self.tutorialView.alpha = 0;
	}];
	
}


-(void)tableView:(UITableView*)tableView willDisplayCell:(PSTableCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
	
	UIBezierPath *maskPath;
	if ([self rowsForGroup:indexPath.section] == 1) {
		maskPath=[UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:[self cornerRadiiForSection:indexPath.section]];
	} else if (indexPath.row == 0) {
		maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerTopLeft| UIRectCornerTopRight cornerRadii:[self cornerRadiiForSection:indexPath.section]];
	} else if (indexPath.row == [self rowsForGroup:indexPath.section] - 1) {
		maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:[self cornerRadiiForSection:indexPath.section]];
	} else {
		maskPath = [UIBezierPath bezierPathWithRect:cell.bounds];
	}
	
	CAShapeLayer *maskLayer = [CAShapeLayer layer];
	maskLayer.frame = cell.bounds;
	maskLayer.path = maskPath.CGPath;
	cell.layer.mask = maskLayer;
	cell.layer.shadowPath = maskPath.CGPath;
	
	cell.backgroundColor = self.cellsColour;
}


- (CGSize)cornerRadiiForSection:(NSInteger)section{
	return CGSizeMake(10, 10);
}


- (void)openController:(GridButton *)sender {
	
	invokeHapticFeedback();
	
	NSString *className = sender.identifier;
	PSListController *controller = [[NSClassFromString(className) alloc] init];
	[[self navigationController] pushViewController:controller animated:YES];
}


-(void)openDrawer {
	
	invokeHapticFeedback();
	
	self.drawerVC = [[DrawerViewController alloc] init];
	[self presentViewController:self.drawerVC animated:YES completion:nil];
}


-(void)dismissDrawerVC {
	
	[self.drawerVC dismissViewControllerAnimated:YES completion:nil];
}


-(void)beginRespring:(id)sender {
	
	[self.respringController endRefreshing];
	
	[UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		self.blurEffectView.alpha = 1;
	} completion:^(BOOL finished) {
		[[TDUtilities sharedInstance] respring];
	}];
	
}


- (id)readPreferenceValue:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:path];
	return (plist[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];
}


- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *plist = [NSMutableDictionary dictionaryWithContentsOfFile:path] ?: [NSMutableDictionary new];
	plist[specifier.properties[@"key"]] = value;
	[plist writeToFile:path atomically:true];
	CFStringRef notificationName = (__bridge CFStringRef)specifier.properties[@"PostNotification"];
	if (notificationName) {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), notificationName, NULL, NULL, true);
	}
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	if (scrollView.contentOffset.y < 0) {
		[UIView animateWithDuration:0.5 animations:^{
			self.greetingLabel.alpha = 1;
			self.tutorialView.alpha = 1;
		}];
		
	} else if (scrollView.contentOffset.y >= 20) {
		[UIView animateWithDuration:0.5 animations:^{
			self.greetingLabel.alpha = 0;
			self.tutorialView.alpha = 0;
		}];
	}
}


-(BOOL)prefersHomeIndicatorAutoHidden {
	return YES;
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}


- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	[UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
		cell.transform = CGAffineTransformMakeScale(0.97, 0.97);
		cell.alpha = 0.5;
	} completion:nil];
}


- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	[UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
		cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
		cell.alpha = 1;
	} completion:nil];
}


-(void)updateLicenceStatus {

	if (self.licenceStatus == 0) {
		self.licenceImage.image = nil;
	} else if (self.licenceStatus == 1) {
		self.licenceImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Licence/unowned.png"];
	} else if (self.licenceStatus == 2) {
		self.licenceImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Licence/trial.png"];
	} else if (self.licenceStatus == 3) {
		self.licenceImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Licence/owned.png"];
	}
}

@end
