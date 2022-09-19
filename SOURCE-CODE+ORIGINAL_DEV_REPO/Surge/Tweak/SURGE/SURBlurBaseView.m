#import "SURBlurBaseView.h"

@implementation SURBlurBaseView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {

    loadPrefs();


    self.blurEffectView = [[UIVisualEffectView alloc] initWithFrame:CGRectZero];
    [self insertSubview:self.blurEffectView atIndex:0];


    self.blurEffectView.translatesAutoresizingMaskIntoConstraints = false;
    [self.blurEffectView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [self.blurEffectView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0].active = YES;
    [self.blurEffectView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = YES;
    [self.blurEffectView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;


    if([surgeInterfaceAppearance isEqualToString:@"surgeLight"]) {

      self.blurEffectView.alpha = 0;
      self.backgroundColor = UIColor.whiteColor;

    } else if([surgeInterfaceAppearance isEqualToString:@"surgeDark"]) {

      self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

    }


    if (toggleColourScheme) {
      self.blurEffectView.alpha = 0;
      self.backgroundColor = [UIColor surgeBackgroundColor];
    }


  }
  return self;
}

@end
