#import <Preferences/Preferences.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"

@interface PSTableCell (PrivateColourPicker)
- (UIViewController *)_viewControllerForAncestor;
@end

@interface TDSystemColourPickerCell : PSTableCell <UIColorPickerViewControllerDelegate> {
  float inset;
}

@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;
@property (nonatomic, retain) UIColor *borderColour;
@property (nonatomic, retain) UIColor *tintColour;

@end
