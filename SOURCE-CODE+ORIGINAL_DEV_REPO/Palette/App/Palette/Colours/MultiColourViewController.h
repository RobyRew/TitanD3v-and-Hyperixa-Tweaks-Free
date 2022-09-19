#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"
#import "ColourCell.h"
#import "FCAlertView.h"
#import "AddCollectionViewController.h"

@interface MultiColourViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *colourArray;
@end

