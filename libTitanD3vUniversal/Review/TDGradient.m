#import "TDGradient.h"

@implementation TDGradient

- (instancetype)initWithStartGradientColor:(UIColor *)startGradientColor
                          endGradientColor:(UIColor *)endGradientColor {
    if (self = [super init]) {
        _startGradientColor = startGradientColor;
        _endGradientColor = endGradientColor;
    }
    return self;
}

@end
