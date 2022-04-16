#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"
#import "CrewCell.h"

@interface CrewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
  NSString *crewString;
}

@property (nonatomic, retain) UIView *bannerView;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *crewArray;
@property (nonatomic, retain) UIColor *tintColour;
@end
