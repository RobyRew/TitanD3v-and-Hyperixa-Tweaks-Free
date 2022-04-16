#import <UIKit/UIKit.h>

typedef enum BlurStyle : NSUInteger {
  Light,
  Dark,
  Dynamic
} BlurStyle;

@interface TDBlurView : UIView
@property (nonatomic, retain) UIVisualEffectView *blurEffectView;
-(instancetype)initWithFrame:(CGRect)frame style:(BlurStyle)blurStyle;
@end
