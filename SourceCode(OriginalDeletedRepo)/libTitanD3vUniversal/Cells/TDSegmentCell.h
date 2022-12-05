#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"
#import "TDAlertViewController.h"
#import "TDUtilities.h"

@interface PSSegmentTableCell : PSControlTableCell
@end

@interface TDSegmentCell : PSSegmentTableCell {
  BOOL showTips;
  NSInteger tipsImageStyle;
  float inset;
}

@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UIButton *tipsButton;
@property (nonatomic, retain) UIColor *tintColour;
@property (nonatomic, retain) UIColor *containerColour;
@property (nonatomic, retain) UIColor *labelColour;

@end
