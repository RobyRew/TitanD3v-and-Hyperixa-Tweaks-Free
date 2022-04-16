#import "TDView.h"

@implementation TDView

-(instancetype)initWithColour:(UIColor *)colour corner:(CGFloat)corner curve:(BOOL)curve clip:(BOOL)clip {

  self = [super init];
  if (self) {

    self.backgroundColor = colour;
    self.layer.cornerRadius = corner;
    if (curve) {
      if (@available(iOS 13.0, *)) {
        self.layer.cornerCurve = kCACornerCurveContinuous;
      }
    }

    if (clip) {
      self.clipsToBounds = true;
    }

  }
  return self;
}

@end
