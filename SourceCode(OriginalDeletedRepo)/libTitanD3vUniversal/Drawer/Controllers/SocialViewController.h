#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"

@interface SocialViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
  NSString *avatarImageString;
  NSString *twitterName;
  NSString *socialString;
  NSString *twitterURL;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIView *bannerView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UIView *twitterView;
@property (nonatomic, retain) UIImageView *twitterImage;
@property (nonatomic, retain) UILabel *twitterLabel;
@property (nonatomic, retain) NSArray *socialArray;
@property (nonatomic, retain) UIColor *tintColour;
@end
