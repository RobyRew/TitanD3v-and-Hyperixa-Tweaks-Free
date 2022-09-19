#import "TDBlurView.h"

@implementation TDBlurView

-(instancetype)initWithFrame:(CGRect)frame style:(BlurStyle)blurStyle {

  self = [super initWithFrame:frame];
  if (self) {

    self.blurEffectView = [[UIVisualEffectView alloc] init];
    [self insertSubview:self.blurEffectView atIndex:0];

    self.blurEffectView.translatesAutoresizingMaskIntoConstraints = false;
    [self.blurEffectView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [self.blurEffectView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0].active = YES;
    [self.blurEffectView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = YES;
    [self.blurEffectView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;


    if(blurStyle == Light) {
      self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    } else if (blurStyle == Dark) {
      self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    }else if (blurStyle == Dynamic) {

      if (@available(iOS 13.0, *)) {
        self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterial];
      }
    }

  }
  return self;
}

@end
