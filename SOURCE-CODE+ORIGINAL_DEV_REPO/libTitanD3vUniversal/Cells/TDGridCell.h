#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"

@interface GridButton : UIButton
@property (nonatomic, retain) NSString *identifier;
@end

@protocol GridTableView
- (id)initWithSpecifier:(PSSpecifier *)specifier;
- (CGFloat)preferredHeightForWidth:(CGFloat)width;
@end

@interface TDGridCell : PSTableCell <GridTableView> {
  UIImage *leftIconImage;
  UIImage *middleIconImage;
  UIImage *rightIconImage;
  NSString *leftIconPathString;
  NSString *middleIconPathString;
  NSString *rightIconPathString;
  float inset;
}

@property (nonatomic, retain) UIColor *tintColour;
@end
