#import "TDColorCollection.h"

@implementation TDColorCollection

+ (instancetype)collectionWithTitle:(NSString *)title colors:(NSArray<UIColor *> *)colors {
  return [[TDColorCollection alloc] initWithTitle:title colors:colors];
}

- (instancetype)initWithTitle:(NSString *)title colors:(NSArray<UIColor *> *)colors {
  if (self = [super init]) {
    _title = title;
    _colors = colors;
  }

  return self;
}

- (NSInteger)count {
  return _colors.count;
}

+ (instancetype)defaultSystemColorsCollection {
  return [TDColorCollection collectionWithTitle:@"SYSTEM COLORS" colors:@[
  UIColor.systemRedColor,
  UIColor.systemOrangeColor,
  UIColor.systemYellowColor,
  UIColor.systemGreenColor,
  UIColor.systemTealColor,
  UIColor.systemBlueColor,
  [UIColor colorWithRed: 0.35 green: 0.34 blue: 0.84 alpha: 1.00],
  UIColor.systemPurpleColor,
  UIColor.systemPinkColor,
  UIColor.systemGrayColor,
  [UIColor colorWithRed: 0.68 green: 0.68 blue: 0.70 alpha: 1.00],
  [UIColor colorWithRed: 0.78 green: 0.78 blue: 0.84 alpha: 1.00],
  [UIColor colorWithRed: 0.82 green: 0.82 blue: 0.84 alpha: 1.00],
  [UIColor colorWithRed: 0.90 green: 0.90 blue: 0.92 alpha: 1.00],
  [UIColor colorWithRed: 0.95 green: 0.95 blue: 0.97 alpha: 1.00],
  UIColor.whiteColor,
  UIColor.blackColor
  ]];
}

+ (instancetype)defaultPrimaryColorsCollection {
  NSMutableArray *colors = [NSMutableArray new];
  for (NSInteger deg = 0; deg <= 360; deg += 30) {
    [colors addObject:[UIColor colorWithHue:1.0f * deg / 360.0f saturation:1.0f brightness:1.0f alpha:1.0f]];
  }
  return [TDColorCollection collectionWithTitle:@"PRIMARY COLORS" colors:colors];
}

+ (instancetype)defaultHueColorsCollection {
  NSMutableArray *colors = [NSMutableArray new];
  for (NSInteger deg = 0; deg <= 360; deg += 1) {
    [colors addObject:[UIColor colorWithHue:1.0f * deg / 360.0f saturation:1.0f brightness:1.0f alpha:1.0f]];
  }
  return [TDColorCollection collectionWithTitle:@"HUE COLORS" colors:colors];
}

@end
