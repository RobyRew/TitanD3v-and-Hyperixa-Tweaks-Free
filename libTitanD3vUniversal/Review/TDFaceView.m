#import "TDAnimationFactory.h"
#import "TDLayerFactory.h"
#import "TDFaceView.h"

@implementation TDFaceView {
    NSMutableArray *layers;
}

- (void)configureMouthWithBadGradient:(TDGradient *)badGradient
                          ughGradient:(TDGradient *)ughGradient
                           okGradient:(TDGradient *)okGradient
                         goodGradient:(TDGradient *)goodGradient {
    CGPoint mouthCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 + 45);
    CGRect mouthFrame = CGRectMake(mouthCenter.x - 50, mouthCenter.y - 27.5, 100, 55);

    CAAnimation *mouthAnimation = [TDAnimationFactory mouthAnimationWithFrame:mouthFrame];
    CAAnimation *gradientAnimation = [TDAnimationFactory gradientAnimationWithBadGradient:badGradient
                                                                            ughGradient:ughGradient
                                                                             okGradient:okGradient
                                                                           goodGradient:goodGradient];

    CALayer *mouthLayer = [TDLayerFactory mouthLayer];
    CALayer *gradientLayer = [TDLayerFactory gradientLayerWithMask:mouthLayer frame:mouthFrame];

    [self.layer addSublayer:gradientLayer];

    [mouthLayer addAnimation:mouthAnimation forKey:@"animateMouth"];
    [gradientLayer addAnimation:gradientAnimation forKey:@"animateMouthGradient"];

    mouthLayer.speed = 0;
    gradientLayer.speed = 0;

    [layers addObjectsFromArray:@[mouthLayer, gradientLayer]];
}

- (void)configureEyesWithBackgroundColor:(UIColor *)backgroundColor
                             badGradient:(TDGradient *)badGradient
                             ughGradient:(TDGradient *)ughGradient
                              okGradient:(TDGradient *)okGradient
                            goodGradient:(TDGradient *)goodGradient {
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    CGRect leftEyeFrame = CGRectMake(center.x - 45, center.y - 35, 30, 30);
    CGRect leftEyeCircleCoverFrame = CGRectMake(center.x - 60, center.y - 52, 20, 20);
    CGRect leftEyeRectCoverFrame = CGRectMake(center.x - 48, center.y - 48, 40, 20);
    CGRect rightEyeFrame = CGRectMake(center.x + 15, center.y - 35, 30, 30);
    CGRect rightEyeCircleCoverFrame = CGRectMake(center.x + 40, center.y - 52, 20, 20);
    CGRect rightEyeRectCoverFrame = CGRectMake(center.x + 8, center.y - 48, 40, 20);
    CAAnimation *gradientAnimation = [TDAnimationFactory gradientAnimationWithBadGradient:badGradient
                                                                            ughGradient:ughGradient
                                                                             okGradient:okGradient
                                                                           goodGradient:goodGradient];
    [self configureEyeWithFrame:leftEyeFrame
               circleCoverFrame:leftEyeCircleCoverFrame
                 rectCoverFrame:leftEyeRectCoverFrame
                animationOffset:10
           rectCoverAngleDegree:15
              gradientAnimation:gradientAnimation
                backgroundColor:UIColor.clearColor];
    [self configureEyeWithFrame:rightEyeFrame
               circleCoverFrame:rightEyeCircleCoverFrame
                 rectCoverFrame:rightEyeRectCoverFrame
                animationOffset:-10
           rectCoverAngleDegree:-15
              gradientAnimation:gradientAnimation
                backgroundColor:UIColor.clearColor];
}

- (void)configureEyeWithFrame:(CGRect)frame
             circleCoverFrame:(CGRect)circleCoverFrame
               rectCoverFrame:(CGRect)rectCoverFrame
              animationOffset:(CGFloat)offset
         rectCoverAngleDegree:(CGFloat)rectCoverAngleDegree
            gradientAnimation:(CAAnimation *)gradientAnimation
              backgroundColor:(UIColor *)backgroundColor {
    CAAnimation *eyeCircleCoverAnimation = [TDAnimationFactory eyeCircleCoverAnimationWithOffset:offset];
    CAAnimation *eyeRectCoverAnimation = [TDAnimationFactory eyeRectCoverAnimationWithOffset:offset];

    CALayer *eyeLayer = [TDLayerFactory eyeLayerWithSize:frame.size];
    CALayer *gradientLayer = [TDLayerFactory gradientLayerWithMask:eyeLayer frame:frame];
    CALayer *eyeCircleCoverLayer = [TDLayerFactory eyeCircleCoverLayerWithFrame:circleCoverFrame
                                                              backgroundColor:backgroundColor];
    CALayer *eyeRectCoverLayer = [TDLayerFactory eyeRectCoverLayerWithFrame:rectCoverFrame
                                                              angleDegree:rectCoverAngleDegree
                                                          backgroundColor:backgroundColor];

    [self.layer addSublayer:gradientLayer];
    [self.layer addSublayer:eyeCircleCoverLayer];
    [self.layer addSublayer:eyeRectCoverLayer];

    [gradientLayer addAnimation:gradientAnimation forKey:@"animateEyeGradient"];
    [eyeCircleCoverLayer addAnimation:eyeCircleCoverAnimation forKey:@"animateEyeCircleCover"];
    [eyeRectCoverLayer addAnimation:eyeRectCoverAnimation forKey:@"animateEyeRectCover"];

    gradientLayer.speed = 0;
    eyeCircleCoverLayer.speed = 0;
    eyeRectCoverLayer.speed = 0;

    [layers addObjectsFromArray:@[gradientLayer, eyeCircleCoverLayer, eyeRectCoverLayer]];
}

- (void)configureFaceWithBadGradient:(TDGradient *)badGradient
                         ughGradient:(TDGradient *)ughGradient
                          okGradient:(TDGradient *)okGradient
                        goodGradient:(TDGradient *)goodGradient {
    CAAnimation *gradientAnimation = [TDAnimationFactory gradientAnimationWithBadGradient:badGradient
                                                                            ughGradient:ughGradient
                                                                             okGradient:okGradient
                                                                           goodGradient:goodGradient];

    CALayer *faceLayer = [TDLayerFactory faceLayerWithSize:self.bounds.size];
    CALayer *gradientLayer = [TDLayerFactory gradientLayerWithMask:faceLayer frame:self.bounds];

    [self.layer addSublayer:gradientLayer];

    [gradientLayer addAnimation:gradientAnimation forKey:@"animateFaceGradient"];

    gradientLayer.speed = 0;

    [layers addObjectsFromArray:@[gradientLayer]];
}

- (void)configureWithBackgroundColor:(UIColor *)backgroundColor
                         badGradient:(TDGradient *)badGradient
                         ughGradient:(TDGradient *)ughGradient
                          okGradient:(TDGradient *)okGradient
                        goodGradient:(TDGradient *)goodGradient {
    self.backgroundColor = UIColor.clearColor;
    layers = [NSMutableArray new];
    [self configureMouthWithBadGradient:badGradient ughGradient:ughGradient okGradient:okGradient goodGradient:goodGradient];
    [self configureEyesWithBackgroundColor:UIColor.clearColor
                               badGradient:badGradient
                               ughGradient:ughGradient
                                okGradient:okGradient
                              goodGradient:goodGradient];
    [self configureFaceWithBadGradient:badGradient ughGradient:ughGradient okGradient:okGradient goodGradient:goodGradient];
}

- (void)updateLayers:(CGFloat)progress {
    for (CALayer *layer in layers) {
        layer.timeOffset = progress;
    }
}

@end
