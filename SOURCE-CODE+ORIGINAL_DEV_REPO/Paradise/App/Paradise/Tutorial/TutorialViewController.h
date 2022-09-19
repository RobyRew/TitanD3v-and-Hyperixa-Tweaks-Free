#import <UIKit/UIKit.h>
#import "ConstraintExtension.h"
#import "TutorialCell.h"
#import "AppManager.h"
#import "Preferences.h"

@interface TutorialViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIButton *closeButton;
@property (nonatomic, retain) NSArray *descriptionArray;
@property (nonatomic, retain) NSArray *imageArray;
@end

