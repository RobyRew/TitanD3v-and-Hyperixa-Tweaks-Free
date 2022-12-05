#import <UIKit/UIKit.h>
#import "ColourCell.h"
#import "FCAlertView.h"
#import "ConstraintExtension.h"

@interface MyCollectionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;
@property (nonatomic, retain) UITableView *tableView;
@end

