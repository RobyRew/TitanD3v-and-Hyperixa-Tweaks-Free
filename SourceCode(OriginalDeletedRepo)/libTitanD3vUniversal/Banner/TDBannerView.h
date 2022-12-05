#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"

@interface TDBannerView : UIView

@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIImageView *bannerImage;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;
@property (nonatomic, retain) UIColor *bannerColour;
@property (nonatomic, retain) UIColor *labelColour;
@property (nonatomic, retain) UIColor *tintColour;

@end
