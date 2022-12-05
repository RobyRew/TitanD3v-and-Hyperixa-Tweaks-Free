#import <UIKit/UIKit.h>

@interface TDLayerFactory : NSObject

+ (CALayer *)mouthLayer;
+ (CALayer *)eyeLayerWithSize:(CGSize)size;
+ (CALayer *)eyeCircleCoverLayerWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;
+ (CALayer *)eyeRectCoverLayerWithFrame:(CGRect)frame angleDegree:(CGFloat)angleDegree backgroundColor:(UIColor *)backgroundColor;
+ (CALayer *)faceLayerWithSize:(CGSize)size;
+ (CALayer *)gradientLayerWithMask:(CALayer *)mask frame:(CGRect)frame;
+ (CALayer *)gradientLayerWithMask:(CALayer *)mask
                             frame:(CGRect)frame
                            colors:(NSArray *)colors
                        startPoint:(CGPoint)startPoint
                          endPoint:(CGPoint)endPoint;
+ (CALayer *)pieLayerWithFrame:(CGRect)frame
              startAngleDegree:(CGFloat)startAngleDegree
                endAngleDegree:(CGFloat)endAngleDegree;
+ (CALayer *)pieTitleLayerWithTitle:(NSString *)title
                         titleColor:(UIColor *)titleColor
                              frame:(CGRect)frame
                        angleDegree:(CGFloat)angleDegree;
+ (CALayer *)pieLinesLayerWithFrame:(CGRect)frame
                   startAngleDegree:(CGFloat)startAngleDegree;

@end
