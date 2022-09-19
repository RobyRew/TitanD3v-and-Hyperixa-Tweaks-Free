#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "TDAppearance.h"
#import "TDReviewViewController.h"
#import "ConstraintExtension.h"
#import "TDUtilities.h"

@interface TDReviewCell : PSTableCell <UITextFieldDelegate, UITextViewDelegate> {
  TDReviewViewController *vc;
  UIViewController *reviewVC;
  NSString *ratingString;
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
