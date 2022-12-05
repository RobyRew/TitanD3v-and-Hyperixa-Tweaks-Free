#import "UIColor+Utils.h"

@implementation UIColor (Utils)

+ (UIColor *)colorWithHexString:(NSString *)hexstr {
    NSScanner *scanner;
    unsigned int rgbval;

    scanner = [NSScanner scannerWithString: hexstr];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt: &rgbval];

    return [UIColor colorWithHexValue: rgbval];
}

+ (UIColor *)colorWithHexValue:(NSInteger) rgbValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF))/255.0
                           alpha:1.0];

}


@end
