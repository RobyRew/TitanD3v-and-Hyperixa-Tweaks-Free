#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"
#import "TDAlertViewController.h"
#import "TDUtilities.h"

@interface TDStepperCell : PSControlTableCell {
  NSString *title;
  BOOL showTips;
  NSInteger tipsImageStyle;
  float inset;
}

@property (nonatomic, assign) BOOL showPercentage;
@property (nonatomic, retain) UIStepper *control;
@property (nonatomic, retain) UILabel *valueLabel;
@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;
@property (nonatomic, retain) UIButton *tipsButton;
@property (nonatomic, retain) UIColor *tintColour;
@property (nonatomic, retain) UIColor *containerColour;
@property (nonatomic, retain) UIColor *labelColour;

@end
