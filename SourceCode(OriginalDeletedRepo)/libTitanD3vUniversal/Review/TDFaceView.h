#import <UIKit/UIKit.h>
#import "TDGradient.h"

@interface TDFaceView : UIView

- (void)configureWithBackgroundColor:(UIColor *)backgroundColor
                         badGradient:(TDGradient *)badGradient
                         ughGradient:(TDGradient *)ughGradient  
                          okGradient:(TDGradient *)okGradient
                        goodGradient:(TDGradient *)goodGradient;
- (void)updateLayers:(CGFloat)progress;

@end
