#import <UIKit/UIKit.h>
#import "TDAlertViewControllerTransitionStyle.h"

@interface TDAlertViewDismissalAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property TDAlertViewControllerTransitionStyle transitionStyle;
@property CGFloat duration;

@end
