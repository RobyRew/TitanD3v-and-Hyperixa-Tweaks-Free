#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"
#import "TDUtilities.h"

@interface TDEditCell : PSTableCell <UITextFieldDelegate> {
  UIView *baseView;
  BOOL customIcon;
  float inset;
}

@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UIColor *tintColour;
@property (nonatomic, retain) UIColor *labelColour;

@end
