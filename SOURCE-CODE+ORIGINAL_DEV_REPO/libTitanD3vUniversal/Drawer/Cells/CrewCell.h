#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TDAppearance.h"

@interface CrewCell : UITableViewCell

@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIImageView *bannerImage;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *roleLabel;
@property (nonatomic, retain) UILabel *followLabel;
@property (nonatomic, retain) UIColor *tintColour;
@end

