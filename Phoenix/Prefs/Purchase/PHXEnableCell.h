#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "PHXHelper.m"

@interface PHXEnableCell : PSTableCell {

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
