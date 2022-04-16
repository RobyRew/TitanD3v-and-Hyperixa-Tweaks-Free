#import "TDConstants.h"
#import "UIColor+Utils.h"
#import "TDAnimationFactory.h"

@implementation TDAnimationFactory

+ (CAAnimation *)mouthAnimationWithFrame:(CGRect)frame {
    CGPoint center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
    NSArray *mouthPaths = [TDAnimationFactory mouthPathsWithCenter:center];
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animation];
    pathAnimation.keyPath = @"path";
    pathAnimation.values = mouthPaths;
    pathAnimation.duration = 1;

    CAKeyframeAnimation *yAnimation = [CAKeyframeAnimation animation];
    yAnimation.keyPath = @"transform.translation.y";
    yAnimation.values = @[[NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:-5],
                          [NSNumber numberWithFloat:-8],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:-5],
                          [NSNumber numberWithFloat:-8],
                          [NSNumber numberWithFloat:0]];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1;
    group.animations = @[pathAnimation, yAnimation];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeBoth;
    return group;
}

+ (CAAnimation *)eyeCircleCoverAnimationWithOffset:(CGFloat)offset {
    CAKeyframeAnimation *xAnimation = [CAKeyframeAnimation animation];
    xAnimation.keyPath = @"transform.translation.x";
    xAnimation.values = @[[NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:offset],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:offset],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:0]];

    CAKeyframeAnimation *yAnimation = [CAKeyframeAnimation animation];
    yAnimation.keyPath = @"transform.translation.y";
    yAnimation.values = @[[NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:fabs(offset)],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:fabs(offset)],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:0]];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1;
    group.animations = @[xAnimation, yAnimation];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeBoth;
    return group;
}

+ (CAAnimation *)eyeRectCoverAnimationWithOffset:(CGFloat)offset {
    CAKeyframeAnimation *xAnimation = [CAKeyframeAnimation animation];
    xAnimation.keyPath = @"transform.translation.x";
    xAnimation.values = @[[NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:offset],
                          [NSNumber numberWithFloat:offset],
                          [NSNumber numberWithFloat:offset],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:offset],
                          [NSNumber numberWithFloat:offset],
                          [NSNumber numberWithFloat:offset],
                          [NSNumber numberWithFloat:0]];

    CAKeyframeAnimation *yAnimation = [CAKeyframeAnimation animation];
    yAnimation.keyPath = @"transform.translation.y";
    yAnimation.values = @[[NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:-fabs(offset)],
                          [NSNumber numberWithFloat:-fabs(offset)],
                          [NSNumber numberWithFloat:-fabs(offset)],
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:-fabs(offset)],
                          [NSNumber numberWithFloat:-fabs(offset)],
                          [NSNumber numberWithFloat:-fabs(offset)],
                          [NSNumber numberWithFloat:0]];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1;
    group.animations = @[xAnimation, yAnimation];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeBoth;
    return group;
}

+ (CAAnimation *)descriptionAnimationWithRate:(TDRate)rate offset:(CGFloat)offset {
    NSMutableArray *xAnimationValues = [NSMutableArray new];
    NSMutableArray *opacityAnimationValues = [NSMutableArray new];

    for (NSUInteger i = 0; i < 9; i++) {
        NSUInteger current = i % 4;
        NSUInteger prev = (i == 0 ? 8 : i - 1) % 4;
        NSNumber *xAnimationValue;
        NSNumber *opacityAnimationValue;
        if (current == rate) {
            xAnimationValue = [NSNumber numberWithFloat:0];
            opacityAnimationValue = [NSNumber numberWithFloat:1];
        } else {
            xAnimationValue = [NSNumber numberWithFloat:prev == rate ? -offset : offset];
            opacityAnimationValue = [NSNumber numberWithFloat:0];
        }
        [xAnimationValues addObject:xAnimationValue];
        [opacityAnimationValues addObject:opacityAnimationValue];
    }

    CAKeyframeAnimation *xAnimation = [CAKeyframeAnimation animation];
    xAnimation.keyPath = @"transform.translation.x";
    xAnimation.values = xAnimationValues;

    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animation];
    opacityAnimation.keyPath = @"opacity";
    opacityAnimation.values = opacityAnimationValues;

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1;
    group.animations = @[xAnimation, opacityAnimation];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeBoth;
    return group;
}

+ (CAAnimation *)gradientAnimationWithBadGradient:(TDGradient *)badGradient
                                      ughGradient:(TDGradient *)ughGradient
                                       okGradient:(TDGradient *)okGradient
                                     goodGradient:(TDGradient *)goodGradient {
    NSArray *colors = @[@[(__bridge id) badGradient.startGradientColor.CGColor,
                          (__bridge id) badGradient.endGradientColor.CGColor],
                        @[(__bridge id) ughGradient.startGradientColor.CGColor,
                          (__bridge id) ughGradient.endGradientColor.CGColor],
                        @[(__bridge id) okGradient.startGradientColor.CGColor,
                          (__bridge id) okGradient.endGradientColor.CGColor],
                        @[(__bridge id) goodGradient.startGradientColor.CGColor,
                          (__bridge id) goodGradient.endGradientColor.CGColor],
                        @[(__bridge id) badGradient.startGradientColor.CGColor,
                          (__bridge id) badGradient.endGradientColor.CGColor],
                        @[(__bridge id) ughGradient.startGradientColor.CGColor,
                          (__bridge id) ughGradient.endGradientColor.CGColor],
                        @[(__bridge id) okGradient.startGradientColor.CGColor,
                          (__bridge id) okGradient.endGradientColor.CGColor],
                        @[(__bridge id) goodGradient.startGradientColor.CGColor,
                          (__bridge id) goodGradient.endGradientColor.CGColor],
                        @[(__bridge id) badGradient.startGradientColor.CGColor,
                          (__bridge id) badGradient.endGradientColor.CGColor]];
    CAKeyframeAnimation *colorsAnimation = [CAKeyframeAnimation animation];
    colorsAnimation.keyPath = @"colors";
    colorsAnimation.values = colors;
    colorsAnimation.duration = 1;

    CAKeyframeAnimation *startPointYAnimation = [CAKeyframeAnimation animation];
    startPointYAnimation.keyPath = @"startPoint.y";
    startPointYAnimation.values = @[[NSNumber numberWithFloat:.5],
                                    [NSNumber numberWithFloat:.5],
                                    [NSNumber numberWithFloat:0],
                                    [NSNumber numberWithFloat:0],
                                    [NSNumber numberWithFloat:.5],
                                    [NSNumber numberWithFloat:.5],
                                    [NSNumber numberWithFloat:0],
                                    [NSNumber numberWithFloat:0],
                                    [NSNumber numberWithFloat:.5]];
    startPointYAnimation.duration = 1;

    CAKeyframeAnimation *endPointYAnimation = [CAKeyframeAnimation animation];
    endPointYAnimation.keyPath = @"endPoint.y";
    endPointYAnimation.values = @[[NSNumber numberWithFloat:.5],
                                  [NSNumber numberWithFloat:.5],
                                  [NSNumber numberWithFloat:1],
                                  [NSNumber numberWithFloat:1],
                                  [NSNumber numberWithFloat:.5],
                                  [NSNumber numberWithFloat:.5],
                                  [NSNumber numberWithFloat:1],
                                  [NSNumber numberWithFloat:1],
                                  [NSNumber numberWithFloat:.5]];
    endPointYAnimation.duration = 1;

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1;
    group.animations = @[colorsAnimation, startPointYAnimation, endPointYAnimation];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeBoth;
    return group;
}

+ (NSArray *)mouthPathsWithCenter:(CGPoint)center {
    CGFloat width = center.x - 10;
    CGFloat height = center.y - 10;

    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(center.x - width, center.y)];
    [path1 addQuadCurveToPoint:CGPointMake(center.x, center.y - height)
                  controlPoint:CGPointMake(center.x - width * 0.7, center.y - height)];
    [path1 addQuadCurveToPoint:CGPointMake(center.x + width, center.y)
                  controlPoint:CGPointMake(center.x + width * 0.7, center.y - height)];

    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(center.x - width, center.y)];
    [path2 addQuadCurveToPoint:CGPointMake(center.x, center.y - height)
                  controlPoint:CGPointMake(center.x - width * 0.7, center.y - height)];
    [path2 addQuadCurveToPoint:CGPointMake(center.x + width, center.y - height)
                  controlPoint:CGPointMake(center.x + width / 2, center.y - height)];

    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(center.x - width, center.y)];
    [path3 addQuadCurveToPoint:CGPointMake(center.x, center.y)
                  controlPoint:CGPointMake(center.x - width / 2, center.y)];
    [path3 addQuadCurveToPoint:CGPointMake(center.x + width, center.y)
                  controlPoint:CGPointMake(center.x + width / 2, center.y)];

    UIBezierPath *path4 = [UIBezierPath bezierPath];
    [path4 moveToPoint:CGPointMake(center.x - width, center.y)];
    [path4 addQuadCurveToPoint:CGPointMake(center.x, center.y + height)
                  controlPoint:CGPointMake(center.x - width * 0.7, center.y + height)];
    [path4 addQuadCurveToPoint:CGPointMake(center.x + width, center.y)
                  controlPoint:CGPointMake(center.x + width * 0.7, center.y + height)];

    return @[(__bridge id) path1.CGPath, (__bridge id) path2.CGPath, (__bridge id) path3.CGPath, (__bridge id) path4.CGPath,
             (__bridge id) path1.CGPath, (__bridge id) path2.CGPath, (__bridge id) path3.CGPath, (__bridge id) path4.CGPath,
             (__bridge id) path1.CGPath];
}

@end
