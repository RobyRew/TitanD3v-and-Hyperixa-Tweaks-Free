#import "UIColor+ChromaPicker.h"

@implementation UIColor (ChromaPicker)

#pragma mark - General

- (BOOL)isDarkColor {
  NSArray *components = self.RGBAValues;
  return (0.2126 * [components[0] doubleValue] + 0.7152 * [components[1] doubleValue] + 0.0722 * [components[2] doubleValue]) < 0.50;
}

- (NSArray *)HSBAValues {
  CGFloat h, s, b, a;
  [self getHue:&h saturation:&s brightness:&b alpha:&a];
  return @[@(h), @(s), @(b), @(a)];
}

- (NSArray *)RGBAValues {
  CGFloat r, g, b, a;
  [self getRed:&r green:&g blue:&b alpha:&a];
  return @[@(r), @(g), @(b), @(a)];
}

- (NSArray *)CMYKAValues {
  CGFloat c, m, y, k, a;
  [self getCyan:&c magenta:&m yellow:&y black:&k alpha:&a];
  return @[@(c), @(m), @(y), @(k), @(a)];
}

#pragma mark - Hex Support

+ (UIColor *)colorByEvaluatingHexString:(NSString *)hexString {

  NSString *evalutationString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""]
  stringByReplacingOccurrencesOfString:@"0x" withString:@""];

  CGFloat a, r, b, g;
  unsigned hexadecimalValue;
  [[NSScanner scannerWithString:evalutationString] scanHexInt:&hexadecimalValue];

  CGFloat(^componentValue)(unsigned, unsigned, float) = ^(unsigned dec, unsigned shift, float devisor) {
    return (CGFloat)((hexadecimalValue & dec) >> shift) / devisor;
  };

  switch (evalutationString.length) {
    case TDHexFormatRGB:
    r = componentValue(0xF00, 8, 15);
    g = componentValue(0x0F0, 4, 15);
    b = componentValue(0x00F, 0, 15);
    a = 1.0f;
    break;
    case TDHexFormatRGBA:
    r = componentValue(0xF000, 12, 15);
    g = componentValue(0x0F00, 8,  15);
    b = componentValue(0x00F0, 4,  15);
    a = componentValue(0x000F, 0,  15);
    break;
    case TDHexFormatRRGGBB:
    r = componentValue(0xFF0000, 16, 255);
    g = componentValue(0x00FF00, 8,  255);
    b = componentValue(0x0000FF, 0,  255);
    a = 1.0f;
    break;
    case TDHexFormatRRGGBBAA:
    r = componentValue(0xFF000000, 24, 255);
    g = componentValue(0x00FF0000, 16, 255);
    b = componentValue(0x0000FF00, 8,  255);
    a = componentValue(0x000000FF, 0,  255);
    break;
    default:
    r = g = b = a = 1.0f;
    break;
  }

  return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

+ (NSString *)hexStringWithColor:(UIColor *)color format:(TDHexFormat)format {

  CGFloat r, g, b, a;
  [color getRed:&r green:&g blue:&b alpha:&a];

  switch (format) {
    case TDHexFormatRGB:
    return [[NSString stringWithFormat:@"#%03x", (unsigned)(r*15)<<8 | (unsigned)(g*15)<<4 | (unsigned)(b*15)<<0] uppercaseString];
    case TDHexFormatRGBA:
    return [[NSString stringWithFormat:@"#%08x", (unsigned)(r*15)<<12 | (unsigned)(g*15)<<8 | (unsigned)(b*15)<<4 | (unsigned)(a*15)<<0] uppercaseString];
    case TDHexFormatRRGGBB:
    return [[NSString stringWithFormat:@"#%06x", (unsigned)(r*255)<<16 | (unsigned)(g*255)<<8 | (unsigned)(b*255)<<0] uppercaseString];
    case TDHexFormatRRGGBBAA:
    return [[NSString stringWithFormat:@"#%08x", (unsigned)(r*255)<<24 | (unsigned)(g*255)<<16 | (unsigned)(b*255)<<8 | (unsigned)(a*255)<<0] uppercaseString];
    default: {
      return (a >= 1)
      ? [[NSString stringWithFormat:@"#%06x", (unsigned)(r*255)<<16 | (unsigned)(g*255)<<8 | (unsigned)(b*255)<<0] uppercaseString]
      : [[NSString stringWithFormat:@"#%08x", (unsigned)(r*255)<<24 | (unsigned)(g*255)<<16 | (unsigned)(b*255)<<8 | (unsigned)(a*255)<<0] uppercaseString];
    }
  }
}

- (NSString *)hexStringValue {
  return [UIColor hexStringWithColor:self format:TDHexFormatAuto];
}

#pragma mark - CMYK Support

+ (instancetype)colorWithCyan:(CGFloat)cyan magenta:(CGFloat)magenta yellow:(CGFloat)yellow black:(CGFloat)black alpha:(CGFloat)alpha {
  CGFloat red = (1 - cyan) * (1 - black);
  CGFloat green = (1 - magenta) * (1 - black);
  CGFloat blue = (1 - yellow) * (1 - black);
  return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (BOOL)getCyan:(CGFloat *)cyan magenta:(CGFloat *)magenta yellow:(CGFloat *)yellow black:(CGFloat *)black alpha:(CGFloat *)alpha {
  CGFloat r, g, b, a;
  if (![self getRed:&r green:&g blue:&b alpha:&a]) {
    return NO;
  }

  CGFloat k = 1 - MAX(MAX(r, g), b);
  if (k == 1) {
    if (cyan) *cyan = 0;
    if (magenta) *magenta = 0;
    if (yellow) *yellow = 0;
    if (black) *black = 1;
  } else {
    if (cyan) *cyan = (1 - r - k) / (1 - k);
    if (magenta) *magenta = (1 - g - k) / (1 - k);
    if (yellow) *yellow = (1 - b - k) / (1 - k);
    if (black) *black = k;
  }

  if (alpha) *alpha = a;

  return YES;
}


@end
