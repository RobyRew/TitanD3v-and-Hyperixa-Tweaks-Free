#import <UIKit/UIKit.h>

@interface SingleHandGestureRecognizer : UIGestureRecognizer
@property (assign, nonatomic) CGFloat scale;
@property (assign, nonatomic) CGFloat rotation;
- (nonnull instancetype)initWithTarget:(nullable id)target action:(nullable SEL)action anchorView:(nonnull UIView *)anchorView;
- (void)reset;
@end
