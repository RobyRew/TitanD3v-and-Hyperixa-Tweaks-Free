#import <UIKit/UIKit.h>
#import "TDGradient.h"

@interface TDConfirmView : UIView
@property (nonatomic, retain) UIVisualEffectView *blurEffectView;  
@property (strong, nonatomic) UIButton *button;

- (void)configureWithBackgroundColor:(UIColor *)backgroundColor
                               title:(NSString *)title
                         badGradient:(TDGradient *)badGradient
                         ughGradient:(TDGradient *)ughGradient
                          okGradient:(TDGradient *)okGradient
                        goodGradient:(TDGradient *)goodGradient;
- (void)updateLayers:(CGFloat)progress;

@end
