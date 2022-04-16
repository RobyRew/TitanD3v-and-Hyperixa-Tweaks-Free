#import <UIKit/UIKit.h>
#import "TDSliderType.h"
#import "UIColor+ChromaPicker.h"

#define rgba(r,g,b,a) [UIColor colorWithRed:r green:g blue:b alpha:a]
#define hsba(h,s,b,a) [UIColor colorWithHue:h saturation:s brightness:b alpha:a]
#define cmyka(c,m,y,k,a) [UIColor colorWithCyan:c magenta:m yellow:y black:k alpha:a]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ChromaPicker_Internal)

+ (NSArray *)hueColors;
+ (NSArray *)someColors;
- (UIImage *)imageWithSize:(CGSize)size;
- (CGFloat)valueForType:(TDSliderType)sliderType;
- (UIColor *)colorByApplyingValue:(CGFloat)value sliderType:(TDSliderType)slidetType;

@end

NS_ASSUME_NONNULL_END
