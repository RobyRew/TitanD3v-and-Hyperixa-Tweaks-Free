#ifndef TDSliderType_h
#define TDSliderType_h

typedef enum : NSUInteger {
  TDSliderTypeAlpha,
  TDSliderTypeHue,
  TDSliderTypeSaturation,
  TDSliderTypeBrightness,
  TDSliderTypeRed,
  TDSliderTypeGreen,
  TDSliderTypeBlue,
  TDSliderTypeCyan,
  TDSliderTypeMagenta,
  TDSliderTypeYellow,
  TDSliderTypeBlack
} TDSliderType;

NS_INLINE NSString *sliderTypeShortName(TDSliderType type) {
  switch (type) {
    case TDSliderTypeAlpha: return @"A";
    case TDSliderTypeHue: return @"H";
    case TDSliderTypeSaturation: return @"S";
    case TDSliderTypeBrightness: return @"B";
    case TDSliderTypeRed: return @"R";
    case TDSliderTypeGreen: return @"G";
    case TDSliderTypeBlue: return @"B";
    case TDSliderTypeCyan: return @"C";
    case TDSliderTypeMagenta: return @"M";
    case TDSliderTypeYellow: return @"Y";
    case TDSliderTypeBlack: return @"K";
  }
}

NS_INLINE CGFloat sliderTypeMaxValue(TDSliderType type) {
  switch (type) {
    case TDSliderTypeHue: return (CGFloat)360.0f;
    case TDSliderTypeRed:
    case TDSliderTypeGreen:
    case TDSliderTypeBlue: return (CGFloat)255.0f;
    case TDSliderTypeAlpha:
    case TDSliderTypeSaturation:
    case TDSliderTypeBrightness:
    case TDSliderTypeCyan:
    case TDSliderTypeMagenta:
    case TDSliderTypeYellow:
    case TDSliderTypeBlack: return (CGFloat)100.0f;
  }
}

#endif /* TDSliderType_h */
