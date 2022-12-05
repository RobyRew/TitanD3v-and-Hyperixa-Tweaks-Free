#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"
#import "TDDatePickerVC.h"
#import "TDUtilities.h"

@interface TDDatePickerCell : PSTableCell <UIGestureRecognizerDelegate> {
  TDDatePickerVC *datePickerVC;
  NSDate *pickedDate;
  NSDateFormatter *pickedDateFormat;
  NSString *pickedDateString;
  float inset;
}

@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UIView *baseView;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) UIButton *doneButton;
@property (nonatomic, retain) UIColor *tintColour;
@property (nonatomic, retain) UIColor *containerColour;
@property (nonatomic, retain) UIColor *labelColour;
@property (nonatomic, retain) UIColor *borderColour;

@end
