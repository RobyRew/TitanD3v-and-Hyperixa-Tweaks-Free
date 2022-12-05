#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "TDAppearance.h"
#import "ConstraintExtension.h"
#import "TDUtilities.h"
#import "./TermsandConditions/TDTermsAndConditionsVC.h"

@interface TDTermsAndConditionsCell : PSTableCell {
  float inset;
}

@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UIColor *tintColour;
@property (nonatomic, retain) UIVisualEffectView *blurEffectView;  
@property (nonatomic, retain) UITextField *reviewTextField;
@property (nonatomic, retain) UITextView *reviewTextView;
@property (nonatomic, retain) UILabel *placeholderLabel;

@end
