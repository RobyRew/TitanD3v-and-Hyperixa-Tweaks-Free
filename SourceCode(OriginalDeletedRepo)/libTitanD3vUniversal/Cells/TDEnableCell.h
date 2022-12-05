#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import "TDPrefsManager.h"
#import "TDAppearance.h"
#import "GlobalPrefs.h"
#import "HEXColour.h"

@interface TDEnableCell : PSTableCell {

  BOOL isEnabled;
  BOOL customIcon;
  UIColor *disabledColour;
  UIColor *enabledColour;
  float inset;
}

@property (nonatomic, retain) UIStackView *stackView;
@property (nonatomic, retain) UIView *disabledView;
@property (nonatomic, retain) UIImageView *disabledImage;
@property (nonatomic, retain) UILabel *disabledLabel;
@property (nonatomic, retain) UIView *disabledStateView;
@property (nonatomic, retain) UIView *enabledView;
@property (nonatomic, retain) UIImageView *enabledImage;
@property (nonatomic, retain) UILabel *enabledLabel;
@property (nonatomic, retain) UIView *enabledStateView;
@property (nonatomic, retain) UIColor *backgroundColour;

@end
