#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"
#import "ChangelogCell.h"

@interface ChangelogViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIView *bannerView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *versionLabel;
@property (nonatomic, retain) UIColor *tintColour;
@property (nonatomic, retain) NSArray *changelogArray;

@end
