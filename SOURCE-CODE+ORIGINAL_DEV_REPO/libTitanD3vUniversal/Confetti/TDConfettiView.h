#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TDConfettiTypeConfetti,
    TDConfettiTypeTriangle,
    TDConfettiTypeStar,
    TDConfettiTypeDiamond,
    TDConfettiTypeCustom
} TDConfettiType;

@interface TDConfettiView : UIView

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, assign) CGFloat intensity;
@property (nonatomic, assign) CGFloat birthRate;
@property (nonatomic, assign) TDConfettiType type;
@property (nonatomic, strong) UIImage *customImage;
@property (nonatomic, assign, readonly) BOOL isRaining;
-(void)startConfetti;
-(void)stopConfetti;

@end