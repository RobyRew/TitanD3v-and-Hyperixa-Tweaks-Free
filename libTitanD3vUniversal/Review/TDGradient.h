#import <Foundation/Foundation.h>

@interface TDGradient : NSObject

- (instancetype)initWithStartGradientColor:(UIColor *)startGradientColor
                          endGradientColor:(UIColor *)endGradientColor;

@property (strong, nonatomic) UIColor *startGradientColor;
@property (strong, nonatomic) UIColor *endGradientColor;

@end
