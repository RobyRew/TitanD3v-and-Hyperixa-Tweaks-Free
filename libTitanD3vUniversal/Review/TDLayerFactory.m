#import "TDLayerFactory.h"

@implementation TDLayerFactory

+ (CALayer *)mouthLayer {
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.strokeColor = UIColor.blackColor.CGColor;
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 10;
    layer.lineCap = @"round";
    layer.contentsScale = [[UIScreen mainScreen] scale];
    return layer;
}

+ (CALayer *)eyeLayerWithSize:(CGSize)size {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height)
                                                    cornerRadius:size.height / 2];
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.fillColor = UIColor.blackColor.CGColor;
    layer.path = path.CGPath;
    layer.contentsScale = [[UIScreen mainScreen] scale];
    return layer;
}

+ (CALayer *)eyeCircleCoverLayerWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, frame.size.width, frame.size.height)
                                                    cornerRadius:frame.size.height / 2];
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.frame = frame;
    layer.fillColor = backgroundColor.CGColor;
    layer.path = path.CGPath;
    layer.contentsScale = [[UIScreen mainScreen] scale];
    return layer;
}

+ (CALayer *)eyeRectCoverLayerWithFrame:(CGRect)frame angleDegree:(CGFloat)angleDegree backgroundColor:(UIColor *)backgroundColor {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.frame = frame;
    layer.fillColor = backgroundColor.CGColor;
    layer.path = path.CGPath;
    CGFloat angle = angleDegree / 180.0 * M_PI;
    layer.affineTransform = CGAffineTransformMakeRotation(angle);
    layer.contentsScale = [[UIScreen mainScreen] scale];
    return layer;
}

+ (CALayer *)faceLayerWithSize:(CGSize)size {
    CGFloat width = size.width - 10;
    CGFloat height = size.height - 10;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(5, 5, width, height)
                                                    cornerRadius:height / 2];
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.path = path.CGPath;
    layer.strokeColor = UIColor.blackColor.CGColor;
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 10;
    layer.contentsScale = [[UIScreen mainScreen] scale];
    return layer;
}

+ (CALayer *)gradientLayerWithMask:(CALayer *)mask frame:(CGRect)frame {
    return [self gradientLayerWithMask:mask
                                 frame:frame
                                colors:@[(__bridge id) UIColor.blackColor.CGColor, (__bridge id) UIColor.blackColor.CGColor]
                            startPoint:CGPointMake(0, .5)
                              endPoint:CGPointMake(1, .5)];
}

+ (CALayer *)gradientLayerWithMask:(CALayer *)mask
                             frame:(CGRect)frame
                            colors:(NSArray *)colors
                        startPoint:(CGPoint)startPoint
                        endPoint:(CGPoint)endPoint {
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.frame = frame;
    layer.colors = colors;
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    layer.mask = mask;
    layer.contentsScale = [[UIScreen mainScreen] scale];
    return layer;
}

+ (CALayer *)pieLayerWithFrame:(CGRect)frame
               startAngleDegree:(CGFloat)startAngleDegree
               endAngleDegree:(CGFloat)endAngleDegree {
    CGPoint center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
    CGFloat radius = frame.size.height / 2;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:center];
    [path addArcWithCenter:center
                    radius:radius
                startAngle:startAngleDegree / 180.0 * M_PI
                  endAngle:endAngleDegree / 180.0 * M_PI
                 clockwise:YES];
    [path addLineToPoint:center];
    [path closePath];
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.fillColor = UIColor.blackColor.CGColor;
    layer.path = path.CGPath;
    layer.contentsScale = [[UIScreen mainScreen] scale];
    return layer;
}

+ (CALayer *)pieLinesLayerWithFrame:(CGRect)frame
                   startAngleDegree:(CGFloat)startAngleDegree {
    CGPoint center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
    CGFloat radius = frame.size.height / 2;
    CGFloat longLength = radius * 0.7;
    CGFloat shortLength = radius * 0.66;
    CGFloat angleDegree = startAngleDegree;
    CGFloat degreeBetweenLines = 7.5;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:center];
    [path addLineToPoint:CGPointMake(center.x - sin(angleDegree / 180.0 * M_PI) * longLength,
                                     center.y + cos(angleDegree / 180.0 * M_PI) * longLength)];
    for (int i = 0; i < 2; i++) {
        angleDegree -= degreeBetweenLines;
        [path moveToPoint:center];
        [path addLineToPoint:CGPointMake(center.x - sin(angleDegree / 180.0 * M_PI) * shortLength,
                                         center.y + cos(angleDegree / 180.0 * M_PI) * shortLength)];
    }
    angleDegree -= degreeBetweenLines;
    [path moveToPoint:center];
    [path addLineToPoint:CGPointMake(center.x - sin(angleDegree / 180.0 * M_PI) * longLength,
                                     center.y + cos(angleDegree / 180.0 * M_PI) * longLength)];
    for (int i = 0; i < 2; i++) {
        angleDegree -= degreeBetweenLines;
        [path moveToPoint:center];
        [path addLineToPoint:CGPointMake(center.x - sin(angleDegree / 180.0 * M_PI) * shortLength,
                                         center.y + cos(angleDegree / 180.0 * M_PI) * shortLength)];
    }
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.strokeColor = UIColor.clearColor.CGColor;
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 0.5;
    layer.opacity = 0.6;
    layer.path = path.CGPath;
    layer.contentsScale = [[UIScreen mainScreen] scale];
    return layer;
}

+ (CALayer *)pieTitleLayerWithTitle:(NSString *)title
                         titleColor:(UIColor *)titleColor
                              frame:(CGRect)frame
                        angleDegree:(CGFloat)angleDegree {
    CATextLayer *layer = [CATextLayer new];
    layer.fontSize = 28;
    layer.frame = frame;
    layer.string = title;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = titleColor.CGColor;
    CGFloat angle = angleDegree / 180.0 * M_PI;
    layer.affineTransform = CGAffineTransformMakeRotation(angle);
    layer.contentsScale = [[UIScreen mainScreen] scale];
    return layer;
}

@end
