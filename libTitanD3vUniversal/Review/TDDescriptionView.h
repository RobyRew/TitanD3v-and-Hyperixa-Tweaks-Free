#import <UIKit/UIKit.h>
#import "TDRate.h"

@interface TDDescriptionView : UIView

- (void)configureLabelWithRate:(TDRate)rate title:(NSString *)title color:(UIColor *)color;
- (void)updateLayers:(CGFloat)progress;

@end
