#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"
#import "TDUtilities.h"

@interface BackupViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIView *bannerView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIView *backupView;
@property (nonatomic, retain) UIImageView *backupImage;
@property (nonatomic, retain) UILabel *backupLabel;
@property (nonatomic, retain) UIView *resetView;
@property (nonatomic, retain) UIImageView *resetImage;
@property (nonatomic, retain) UILabel *resetLabel;
@property (nonatomic, retain) UIColor *tintColour;

@end
