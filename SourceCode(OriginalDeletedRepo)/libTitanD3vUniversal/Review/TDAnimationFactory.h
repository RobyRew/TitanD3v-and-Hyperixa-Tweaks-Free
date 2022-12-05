#import <UIKit/UIKit.h>
#import "TDRate.h"
#import "TDGradient.h"

@interface TDAnimationFactory : NSObject

+ (CAAnimation *)mouthAnimationWithFrame:(CGRect)frame;
+ (CAAnimation *)eyeCircleCoverAnimationWithOffset:(CGFloat)offset;
+ (CAAnimation *)eyeRectCoverAnimationWithOffset:(CGFloat)offset;
+ (CAAnimation *)descriptionAnimationWithRate:(TDRate)rate offset:(CGFloat)offset;
+ (CAAnimation *)gradientAnimationWithBadGradient:(TDGradient *)badGradient
                                      ughGradient:(TDGradient *)ughGradient
                                       okGradient:(TDGradient *)okGradient
                                     goodGradient:(TDGradient *)goodGradient;

@end
