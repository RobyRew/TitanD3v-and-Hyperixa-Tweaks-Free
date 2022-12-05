#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"
#import "TDAlertViewController.h"
#import "TDUtilities.h"

@interface TDSwitchCell : PSSwitchTableCell {
  BOOL showTips;
  NSInteger tipsImageStyle;
  float inset;
}

@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;
@property (nonatomic, retain) UIButton *tipsButton;
@property (nonatomic, retain) UIColor *tintColour;
@property (nonatomic, retain) UIColor *containerColour;
@property (nonatomic, retain) UIColor *labelColour;

@end
