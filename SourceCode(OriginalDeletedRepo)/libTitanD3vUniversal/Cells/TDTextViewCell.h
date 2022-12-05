#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"
#import "TDUtilities.h"

@interface TDTextViewCell : PSTableCell <UITextViewDelegate> {
  UIView *baseView;
  float inset;
}

@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UITextView *descriptionTextView;
@property (nonatomic, retain) UIColor *labelColour;

@property (nonatomic, retain) UIColor *tintColour;
@end
