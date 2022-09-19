#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"

@interface TDButtonCell : PSTableCell {
  float inset;
  NSString *customIconPath;
}  

@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *headerLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;
@property (nonatomic, retain) UIColor *tintColour;

@end
