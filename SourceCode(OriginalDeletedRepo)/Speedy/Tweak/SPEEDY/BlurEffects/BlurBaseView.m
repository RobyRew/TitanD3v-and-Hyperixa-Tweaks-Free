#import "BlurBaseView.h"

@implementation BlurBaseView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {

    self.blurEffectView = [[UIVisualEffectView alloc] initWithFrame:CGRectZero];
    [self insertSubview:self.blurEffectView atIndex:0];

    self.blurEffectView.translatesAutoresizingMaskIntoConstraints = false;
    [self.blurEffectView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [self.blurEffectView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0].active = YES;
    [self.blurEffectView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = YES;
    [self.blurEffectView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;


    if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
      self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
    } else {
      self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialLight];
    }

  }

  return self;

}


- (void)traitCollectionDidChange:(UITraitCollection *) previousTraitCollection {

  if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
    self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
  } else {
    self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialLight];
  }

}

@end
