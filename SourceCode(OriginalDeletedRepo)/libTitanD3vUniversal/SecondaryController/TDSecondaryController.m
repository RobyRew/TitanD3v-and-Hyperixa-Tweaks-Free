#import "TDSecondaryController.h"

@implementation TDSecondaryController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	self.navigationBarColour = [[TDAppearance sharedInstance] navigationBarColour];
	self.tintColour = [[TDAppearance sharedInstance] tintColour];
	self.backgroundColour = [[TDAppearance sharedInstance] backgroundColour];
	self.cellsColour = [[TDAppearance sharedInstance] cellColour];
	self.labelColour = [[TDAppearance sharedInstance] labelColour];

	UIWindow *keyWindow = nil;
	NSArray *windows = [[UIApplication sharedApplication] windows];
	for (UIWindow *window in windows) {
		if (window.isKeyWindow) {
			keyWindow = window;
			break;
		}
	}

	keyWindow.tintColor = self.tintColour;


	UINavigationBar *bar = self.navigationController.navigationController.navigationBar;
	bar.barTintColor = self.navigationBarColour;
	bar.tintColor = self.tintColour;
	[[UIButton appearance]setTintColor:self.tintColour];
	self.view.tintColor = self.tintColour;

	UITableView *tableView = self.view.subviews[0];
	tableView.backgroundColor = self.backgroundColour;
	[tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

	[[UILabel appearance] setTextColor:self.labelColour];


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
	bar.tintColor = nil;
	bar.barTintColor = nil;
	self.view.tintColor = nil;
	[[UIButton appearance]setTintColor:nil];
	[[UILabel appearance] setTextColor:nil];

}


// - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

// 	PSTableCell *cell = (PSTableCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
// 	cell.backgroundColor = self.cellsColour;
// 	return cell;
// }


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

@end
