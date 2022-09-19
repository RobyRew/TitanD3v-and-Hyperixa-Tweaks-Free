#import "UIFont+Utils.h"

@implementation UIFont (Utils)

+ (UIFont *)heavyFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightHeavy];
    }
    return [UIFont systemFontOfSize:fontSize];
}

@end
