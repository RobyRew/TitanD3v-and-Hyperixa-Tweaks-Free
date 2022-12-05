#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"

static CGFloat colorComponentFrom(NSString *string, NSInteger start, NSInteger length) {
  NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
  NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
  unsigned hexComponent;
  [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
  return hexComponent / 255.0;
}

static UIColor *colorFromHexString(NSString *hexString) {
  CGFloat red, green, blue, alpha;
  switch(hexString.length) {
    case 3: // #RGB
    red = colorComponentFrom(hexString, 0, 1);
    green = colorComponentFrom(hexString, 1, 1);
    blue = colorComponentFrom(hexString, 2, 1);
    alpha = 1;
    break;
    case 4: // #RGBA
    red = colorComponentFrom(hexString, 0, 1);
    green = colorComponentFrom(hexString, 1, 1);
    blue = colorComponentFrom(hexString, 2, 1);
    alpha = colorComponentFrom(hexString, 3, 1);
    break;
    case 6: // #RRGGBB
    red = colorComponentFrom(hexString, 0, 2);
    green = colorComponentFrom(hexString, 2, 2);
    blue = colorComponentFrom(hexString, 4, 2);
    alpha = 1;
    break;
    case 8: // #RRGGBBAA
    red = colorComponentFrom(hexString, 0, 2);
    green = colorComponentFrom(hexString, 2, 2);
    blue = colorComponentFrom(hexString, 4, 2);
    alpha = colorComponentFrom(hexString, 6, 2);
    break;
    default: // Invalid color
    red = 0;
    green = 0;
    blue = 0;
    alpha = 0;
    break;
  }
  return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


static NSString *stringFromColor(UIColor *color) {
  CGColorSpaceModel colorSpace = CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor));
  const CGFloat *components = CGColorGetComponents(color.CGColor);

  CGFloat r = 0, g = 0, b = 0, a = 0;

  if (colorSpace == kCGColorSpaceModelMonochrome) {
    r = components[0];
    g = components[0];
    b = components[0];
    a = components[1];
  } else if (colorSpace == kCGColorSpaceModelRGB) {
    r = components[0];
    g = components[1];
    b = components[2];
    a = components[3];
  }

  return [NSString stringWithFormat:@"%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255)];
}
