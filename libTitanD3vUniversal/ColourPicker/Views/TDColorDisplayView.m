#import "TDColorDisplayView.h"
#import "UIColor+ChromaPicker_Internal.h"

@implementation TDColorDisplayView

- (instancetype)initWithColor:(UIColor *)color {

  if (self == [super init]) {
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize: 30 weight:UIFontWeightBold];
    self.adjustsFontSizeToFitWidth = YES;
    self.layer.cornerRadius = 12;
    self.layer.masksToBounds = YES;
    if (@available(iOS 13.0, *)) {
      self.layer.cornerCurve = kCACornerCurveContinuous;
    }
    self.color = color;

  }

  return self;
}

- (void)setColor:(UIColor *)color {
  _color = color;
  self.text = color.hexStringValue;
  self.backgroundColor = color;
  self.textColor = color.isDarkColor ? UIColor.lightTextColor : UIColor.darkTextColor;
}


@end
