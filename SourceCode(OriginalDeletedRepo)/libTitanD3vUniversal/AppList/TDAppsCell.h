#import <UIKit/UIKit.h>
#import "TDAppearance.h"

@interface TDAppsCell : UITableViewCell

@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIImageView *appImage;
@property (nonatomic, retain) UILabel *appnameLabel;
@property (nonatomic, retain) UILabel *appBIDLabel;
@property (nonatomic, retain) UIColor *cellsColour;
@property (nonatomic, retain) UIColor *labelColour;

@end
