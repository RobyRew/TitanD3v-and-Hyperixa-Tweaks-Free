#import <QuartzCore/QuartzCore.h>
#import "TDSliderType.h"

NS_ASSUME_NONNULL_BEGIN

@class UIColor;
@interface TDGradientView : CAGradientLayer

- (instancetype)initWithColors:(NSArray *)colors;
- (void)setColorsForSliderType:(TDSliderType)type primaryColor:(UIColor *)primary;

@end

NS_ASSUME_NONNULL_END
