#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"

@protocol PreferencesTableCustomView
- (id)initWithSpecifier:(PSSpecifier *)specifier;
- (CGFloat)preferredHeightForWidth:(CGFloat)width;
@end

@interface TDHeaderCell : PSTableCell <PreferencesTableCustomView> {
  float inset;
}
@property (nonatomic, retain) UILabel *headerLabel;
@end
