#import "UIColor+ChromaPicker_Internal.h"
#import "UIColor+ChromaPicker.h"

@implementation UIColor (ChromaPicker_Internal)

- (UIImage *)imageWithSize:(CGSize)size {
  return [[[UIGraphicsImageRenderer alloc] initWithSize:size] imageWithActions:^(UIGraphicsImageRendererContext *rendererContext) {
    [self setFill];
    [rendererContext fillRect:CGRectMake(0, 0, size.width, size.height)];
  }];
}

+ (NSArray *)hueColors {
  NSMutableArray *colors = [NSMutableArray new];
  for (NSInteger deg = 0; deg <= 360; deg += 5) {
    [colors addObject:(__bridge id)[UIColor colorWithHue:1.0f * deg / 360.0f saturation:1.0f brightness:1.0f alpha:1.0f].CGColor];
  }
  return colors.copy;
}

+ (NSArray *)someColors {
  NSMutableArray *colors = [NSMutableArray new];
  for (NSInteger deg = 0; deg <= 360; deg += 1) {
    [colors addObject:[UIColor colorWithHue:1.0f * deg / 360.0f saturation:1.0f brightness:1.0f alpha:1.0f]];
  }
  return colors.copy;
}

- (CGFloat)valueForType:(TDSliderType)sliderType {
  CGFloat value = 0;

  switch (sliderType) {
    case TDSliderTypeAlpha:        { [self getHue:nil saturation:nil brightness:nil alpha: &value]; } break;
    case TDSliderTypeHue:          { [self getHue:&value saturation:nil brightness:nil alpha:nil]; } break;
    case TDSliderTypeSaturation:   { [self getHue:nil saturation:&value brightness:nil alpha:nil]; } break;
    case TDSliderTypeBrightness:   { [self getHue:nil saturation:nil brightness:&value alpha:nil]; } break;
    case TDSliderTypeRed:          { [self getRed:&value green:nil blue:nil alpha:nil]; } break;
    case TDSliderTypeGreen:        { [self getRed:nil green:&value blue:nil alpha:nil]; } break;
    case TDSliderTypeBlue:         { [self getRed:nil green:nil blue:&value alpha:nil]; } break;
    case TDSliderTypeCyan:         { value = [self.CMYKAValues[0] doubleValue]; } break;
    case TDSliderTypeMagenta:      { value = [self.CMYKAValues[1] doubleValue]; } break;
    case TDSliderTypeYellow:       { value = [self.CMYKAValues[2] doubleValue]; } break;
    case TDSliderTypeBlack:        { value = [self.CMYKAValues[3] doubleValue]; } break;
  }

  return value;
}

- (UIColor *)colorByApplyingValue:(CGFloat)value sliderType:(TDSliderType)sliderType {
  UIColor *color;

  switch (sliderType) {
    case TDSliderTypeHue: {
      NSArray *components = self.HSBAValues;
      color = hsba(value, [components[1] doubleValue], [components[2] doubleValue], [components[3] doubleValue]);
    } break;
    case TDSliderTypeAlpha: {
      NSArray *components = self.HSBAValues;
      color = hsba([components[0] doubleValue], [components[1] doubleValue], [components[2] doubleValue], value);
    } break;
    case TDSliderTypeSaturation: {
      NSArray *components = self.HSBAValues;
      color = hsba([components[0] doubleValue], value, [components[2] doubleValue], [components[3] doubleValue]);
    } break;
    case TDSliderTypeBrightness: {
      NSArray *components = self.HSBAValues;
      color = hsba([components[0] doubleValue], [components[1] doubleValue], value, [components[3] doubleValue]);
    } break;
    case TDSliderTypeRed: {
      NSArray *components = self.RGBAValues;
      color = rgba(value, [components[1] doubleValue], [components[2] doubleValue], [components[3] doubleValue]);
    } break;
    case TDSliderTypeGreen: {
      NSArray *components = self.RGBAValues;
      color = rgba([components[0] doubleValue], value, [components[2] doubleValue], [components[3] doubleValue]);
    } break;
    case TDSliderTypeBlue: {
      NSArray *components = self.RGBAValues;
      color = rgba([components[0] doubleValue], [components[1] doubleValue], value, [components[3] doubleValue]);
    } break;
    case TDSliderTypeCyan: {
      NSArray *components = self.CMYKAValues;
      color = cmyka(value, [components[1] doubleValue], [components[2] doubleValue], [components[3] doubleValue], [components[4] doubleValue]);
    } break;
    case TDSliderTypeMagenta: {
      NSArray *components = self.CMYKAValues;
      color = cmyka([components[0] doubleValue], value, [components[2] doubleValue], [components[3] doubleValue], [components[4] doubleValue]);
    } break;
    case TDSliderTypeYellow: {
      NSArray *components = self.CMYKAValues;
      color = cmyka([components[0] doubleValue], [components[1] doubleValue], value, [components[3] doubleValue], [components[4] doubleValue]);
    } break;
    case TDSliderTypeBlack: {
      NSArray *components = self.CMYKAValues;
      color = cmyka([components[0] doubleValue], [components[1] doubleValue], [components[2] doubleValue], value, [components[4] doubleValue]);
    } break;
  }

  return color;
}

@end
