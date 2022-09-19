#import <UIKit/UIKit.h>
#import "TDAlertViewControllerTransitionStyle.h"

@interface TDAlertViewPresentationAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property TDAlertViewControllerTransitionStyle transitionStyle;
@property CGFloat duration;

@end
