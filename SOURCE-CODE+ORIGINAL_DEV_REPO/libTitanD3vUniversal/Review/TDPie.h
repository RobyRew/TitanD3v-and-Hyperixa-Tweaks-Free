#import <Foundation/Foundation.h>
#import "TDGradient.h"

@interface TDPie : NSObject

- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                     gradient:(TDGradient *)gradient;

@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) TDGradient *gradient;

@end
