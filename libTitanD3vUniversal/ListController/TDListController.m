#import "TDListController.h"

@implementation TDListController

- (void)viewDidLoad {
	[super viewDidLoad];

}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

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

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	PSTableCell *cell = (PSTableCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
	cell.backgroundColor = self.cellsColour;
	cell.titleLabel.textColor = self.labelColour;
	return cell;
}

@end
