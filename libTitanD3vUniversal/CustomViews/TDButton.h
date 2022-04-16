#import <UIKit/UIKit.h>

@interface TDButton : UIButton
-(instancetype)initWithTitle:(NSString *)title colour:(UIColor *)colour fontColour:(UIColor *)fontColour fontSize:(CGFloat)size corner:(CGFloat)corner;
-(instancetype)initWithImage:(UIImage *)image inset:(UIEdgeInsets)inset colour:(UIColor *)colour tint:(BOOL)tint tintColour:(UIColor *)tintColour corner:(CGFloat)corner;
@end

