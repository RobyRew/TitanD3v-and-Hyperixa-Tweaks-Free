#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Hexadecimal string representation formats
typedef enum : NSUInteger {
  TDHexFormatAuto       = 0,
  TDHexFormatRGB        = 3,
  TDHexFormatRGBA       = 4,
  TDHexFormatRRGGBB     = 6,
  TDHexFormatRRGGBBAA   = 8
} TDHexFormat;

@interface UIColor (ChromaPicker)

//
// General
//

- (BOOL)isDarkColor;

- (NSArray *)HSBAValues;
- (NSArray *)RGBAValues;
- (NSArray *)CMYKAValues;

//
// Hex Support
//

/// Creates a color object using the specified hexadecimal string representation
/// @param hexString a hex string in one of the following formats (RGB, #RGB, 0xRGB, RGBA, #RGBA, 0xRGBA RRGGBB, #RRGGBB, 0xRRGGBB RRGGBBAA, #RRGGBBAA, 0xRRGGBBAA)
+ (UIColor *)colorByEvaluatingHexString:(NSString *)hexString;


/// Creates a hexadecimal string representation of the color in the specified format. output examples (#RGB, #RGBA, #RRGGBB, #RRGGBBAA)
/// @param color an instance of a UIColor object
/// @param format the desired output format
+ (NSString *)hexStringWithColor:(UIColor *)color format:(TDHexFormat)format;


/// Creates a hexadecimal string representation of the color instance #RRGGBB, or #RRGGBBAA if the color uses the alpha channel
- (NSString *)hexStringValue;

//
// CMYK Support
//

/// Creates a color object using the specified CMYKA values
/// @param cyan cyan value
/// @param magenta magenta value
/// @param yellow yellow value
/// @param black black value
/// @param alpha alpha value
+ (instancetype)colorWithCyan:(CGFloat)cyan magenta:(CGFloat)magenta yellow:(CGFloat)yellow black:(CGFloat)black alpha:(CGFloat)alpha;


/// Returns the components that make up the color in the CMYK color space.
/// @param cyan on return, the cyan component of the color object
/// @param magenta on return, the magents component of the color object
/// @param yellow on return, the yellow component of the color object
/// @param black on return, the black component of the color object
/// @param alpha on return, the alpha component of the color object
- (BOOL)getCyan:(nullable CGFloat *)cyan magenta:(nullable CGFloat *)magenta yellow:(nullable CGFloat *)yellow black:(nullable CGFloat *)black alpha:(nullable CGFloat *)alpha;

@end

NS_ASSUME_NONNULL_END
