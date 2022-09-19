#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"
#import "TDHeaderView.h"
#import "SocialCell.h"
#import "SwitchCell.h"

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) TDHeaderView *headerView;
@property (nonatomic, retain) UITableView *tableView;
@end
