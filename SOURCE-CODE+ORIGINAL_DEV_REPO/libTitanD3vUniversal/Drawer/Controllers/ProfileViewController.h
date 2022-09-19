#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "GlobalPrefs.h"
#import "TDAppearance.h"
#import "ProfileCell.h"
#import "TDAlertViewController.h"

@interface ProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, retain) UIView *bannerView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *tipsButton;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIColor *containerColour;
@property (nonatomic, retain) UIColor *labelColour;
@property (nonatomic, retain) UIColor *tintColour;
@end


