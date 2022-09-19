#import <UIKit/UIKit.h>

@interface TDAnimator : NSObject <UIViewControllerTransitioningDelegate>
- (instancetype)initWithCHeight:(CGFloat)cHeight andDimALpha:(CGFloat)dimAlpha;
@property (nonatomic, assign) CGFloat cHeight;
@property (nonatomic, assign) CGFloat dimAlpha;
@end
