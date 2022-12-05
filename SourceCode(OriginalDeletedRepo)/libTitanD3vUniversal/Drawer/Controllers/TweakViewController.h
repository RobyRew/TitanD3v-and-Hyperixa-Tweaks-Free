#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"

@interface TweakViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSString *tweakString;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIView *bannerView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) NSArray *tweakArray;
@property (nonatomic, retain) UIColor *tintColour;
@end