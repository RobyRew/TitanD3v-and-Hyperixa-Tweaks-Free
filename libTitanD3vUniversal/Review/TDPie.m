#import "TDPie.h"

@implementation TDPie

- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                     gradient:(TDGradient *)gradient {
    if (self = [super init]) {
        _title = title;
        _titleColor = titleColor;
        _gradient = gradient;
    }
    return self;
}

@end
