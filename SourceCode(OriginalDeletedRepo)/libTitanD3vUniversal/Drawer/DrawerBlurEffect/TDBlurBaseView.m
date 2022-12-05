#import "TDBlurBaseView.h"

@implementation TDBlurBaseView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {


    self.blurEffectView = [[UIVisualEffectView alloc] init];
    self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    [self insertSubview:self.blurEffectView atIndex:0];

    self.blurEffectView.translatesAutoresizingMaskIntoConstraints = false;
    [self.blurEffectView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [self.blurEffectView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0].active = YES;
    [self.blurEffectView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = YES;
    [self.blurEffectView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;


  }

  return self;

}


@end
