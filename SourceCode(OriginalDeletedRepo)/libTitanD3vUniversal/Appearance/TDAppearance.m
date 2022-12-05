#import "TDAppearance.h"

@implementation TDAppearance

+(instancetype)sharedInstance {
  static TDAppearance *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[TDAppearance alloc] init];
  });
  return sharedInstance;
}

- (id)init {
  return self;
}


// -(void)defaultNavigationBarColour:(NSString *)defaultColour {
//   navigationBarDefault = defaultColour;
// }

// -(void)defaultTintColour:(NSString *)defaultColour {
//   tintDefault = defaultColour;
// }

// -(void)defaultBackgroundColour:(NSString *)defaultColour {
//   backgroundDefault = defaultColour;
// }

// -(void)defaultCellColour:(NSString *)defaultColour {
//   cellDefault = defaultColour;
// }

// -(void)defaultLabelColour:(NSString *)defaultColour {
//   labelDefault = defaultColour;
// }

// -(void)defaultBannerColour:(NSString *)defaultColour {
//   bannerDefault = defaultColour;
// }

// -(void)defaultContainerColour:(NSString *)defaultColour {
//   containerDefault = defaultColour;
// }

// -(void)defaultBorderColour:(NSString *)defaultColour {
//   borderDefault = defaultColour;
// }


-(UIColor *)navigationBarColour {

  NSString *colourString = @"161616";
  UIColor *color = colorFromHexString(colourString);
  return color;
}

-(UIColor *)tintColour {

  NSString *colourString = @"F1462C";
  UIColor *color = colorFromHexString(colourString);
  return color;
}

-(UIColor *)backgroundColour {

  NSString *colourString = @"161616";
  UIColor *color = colorFromHexString(colourString);
  return color;
}

-(UIColor *)cellColour {

  NSString *colourString = @"1B1B1B";
  UIColor *color = colorFromHexString(colourString);
  return color;
}

-(UIColor *)labelColour {

  NSString *colourString = @"FFFFFF";
  UIColor *color = colorFromHexString(colourString);
  return color;
}

-(UIColor *)bannerColour {

  NSString *colourString = @"1B1B1B";
  UIColor *color = colorFromHexString(colourString);
  return color;
}

-(UIColor *)containerColour {

  NSString *colourString = @"1B1B1B";
  UIColor *color = colorFromHexString(colourString);
  return color;
}

-(UIColor *)borderColour {

  NSString *colourString = @"F1462C";
  UIColor *color = colorFromHexString(colourString);
  return color;
}

@end
