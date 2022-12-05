#import "TDGradientView.h"
#import "UIColor+ChromaPicker_Internal.h"

@implementation TDGradientView

- (instancetype)initWithColors:(NSArray *)colors {
  if (self == [super init]) {
    self.startPoint = CGPointMake(0, 0.5);
    self.endPoint = CGPointMake(1, 0.5);
    if (@available(iOS 13.0, *)) {
      self.cornerCurve = kCACornerCurveContinuous;
    }
    self.masksToBounds = YES;
    self.cornerRadius = 10;
    self.borderWidth = 1;
    if (@available(iOS 13.0, *)) {
      self.borderColor = UIColor.tertiarySystemFillColor.CGColor;
    } else {
      self.borderColor = UIColor.lightGrayColor.CGColor;
    }
    self.colors = colors;
  }

  return self;
}

- (void)setColorsForSliderType:(TDSliderType)type primaryColor:(UIColor *)primary {
  switch (type) {

    case TDSliderTypeHue: {
      self.colors = UIColor.hueColors;
    } break;
    case TDSliderTypeAlpha: {
      NSArray *components = primary.HSBAValues;
      self.colors = @[(__bridge id)hsba([components[0] doubleValue], [components[1] doubleValue], [components[2] doubleValue], 0).CGColor,
      (__bridge id)hsba([components[0] doubleValue], [components[1] doubleValue], [components[2] doubleValue], 1).CGColor];
    } break;
    case TDSliderTypeSaturation: {
      NSArray *components = primary.HSBAValues;
      self.colors = @[(__bridge id)hsba([components[0] doubleValue], 0, [components[2] doubleValue], [components[3] doubleValue]).CGColor,
      (__bridge id)hsba([components[0] doubleValue], 1, [components[2] doubleValue], [components[3] doubleValue]).CGColor];
    } break;
    case TDSliderTypeBrightness: {
      NSArray *components = primary.HSBAValues;
      self.colors = @[(__bridge id)hsba([components[0] doubleValue], [components[1] doubleValue], 0, [components[3] doubleValue]).CGColor,
      (__bridge id)hsba([components[0] doubleValue], [components[1] doubleValue], 1, [components[3] doubleValue]).CGColor];
    } break;
    case TDSliderTypeRed: {
      NSArray *components = primary.RGBAValues;
      self.colors = @[(__bridge id)rgba(0, [components[1] doubleValue], [components[2] doubleValue], [components[3] doubleValue]).CGColor,
      (__bridge id)rgba(1, [components[1] doubleValue], [components[2] doubleValue], [components[3] doubleValue]).CGColor];
    } break;
    case TDSliderTypeGreen: {
      NSArray *components = primary.RGBAValues;
      self.colors = @[(__bridge id)rgba([components[0] doubleValue], 0, [components[2] doubleValue], [components[3] doubleValue]).CGColor,
      (__bridge id)rgba([components[0] doubleValue], 1, [components[2] doubleValue], [components[3] doubleValue]).CGColor];
    } break;
    case TDSliderTypeBlue: {
      NSArray *components = primary.RGBAValues;
      self.colors = @[(__bridge id)rgba([components[0] doubleValue], [components[1] doubleValue], 0, [components[3] doubleValue]).CGColor,
      (__bridge id)rgba([components[0] doubleValue], [components[1] doubleValue], 1, [components[3] doubleValue]).CGColor];
    } break;
    case TDSliderTypeCyan: {
      NSArray *components = primary.CMYKAValues;
      self.colors = @[(__bridge id)cmyka(0, [components[1] doubleValue], [components[2] doubleValue], [components[3] doubleValue], [components[4] doubleValue]).CGColor,
      (__bridge id)cmyka(1, [components[1] doubleValue], [components[2] doubleValue], [components[3] doubleValue], [components[4] doubleValue]).CGColor];
    } break;
    case TDSliderTypeMagenta: {
      NSArray *components = primary.CMYKAValues;
      self.colors = @[(__bridge id)cmyka([components[0] doubleValue], 0, [components[2] doubleValue], [components[3] doubleValue], [components[4] doubleValue]).CGColor,
      (__bridge id)cmyka([components[0] doubleValue], 1, [components[2] doubleValue], [components[3] doubleValue], [components[4] doubleValue]).CGColor];
    } break;
    case TDSliderTypeYellow: {
      NSArray *components = primary.CMYKAValues;
      self.colors = @[(__bridge id)cmyka([components[0] doubleValue], [components[1] doubleValue], 0, [components[3] doubleValue], [components[4] doubleValue]).CGColor,
      (__bridge id)cmyka([components[0] doubleValue], [components[1] doubleValue], 1, [components[3] doubleValue], [components[4] doubleValue]).CGColor];
    } break;
    case TDSliderTypeBlack: {
      NSArray *components = primary.CMYKAValues;
      self.colors = @[(__bridge id)cmyka([components[0] doubleValue], [components[1] doubleValue], [components[2] doubleValue], 0, [components[4] doubleValue]).CGColor,
      (__bridge id)cmyka([components[0] doubleValue], [components[1] doubleValue], [components[2] doubleValue], 1, [components[4] doubleValue]).CGColor];
    } break;
  }
}

@end
