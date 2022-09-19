#import "FloatingBlurView.h"

@implementation FloatingBlurView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {

    loadPrefs();

    self.layer.cornerRadius = 30;
    self.clipsToBounds = true;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowOffset = CGSizeMake(0.0,0.0);
    self.layer.shadowRadius = 3.0;
    self.layer.masksToBounds = false;


    self.blurEffectView = [[UIVisualEffectView alloc] initWithFrame:CGRectZero];
    self.blurEffectView.layer.cornerRadius = 30;
    self.blurEffectView.clipsToBounds = true;
    [self addSubview:self.blurEffectView];

    self.blurEffectView.translatesAutoresizingMaskIntoConstraints = false;
    [self.blurEffectView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [self.blurEffectView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0].active = YES;
    [self.blurEffectView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = YES;
    [self.blurEffectView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;


    self.scheduleImage = [[UIImageView alloc] init];
    self.scheduleImage.image = [[UIImage systemImageNamed:@"clock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self addSubview:self.scheduleImage];

    [self.scheduleImage size:CGSizeMake(40, 40)];
    [self.scheduleImage x:self.centerXAnchor y:self.centerYAnchor];


    if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {

      self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
      self.scheduleImage.tintColor = [UIColor whiteColor];
      self.layer.shadowColor = [UIColor colorWithRed: 0.28 green: 0.28 blue: 0.29 alpha: 1.00].CGColor;

    } else {

      self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
      self.scheduleImage.tintColor = [UIColor lightGrayColor];
      self.layer.shadowColor = UIColor.lightGrayColor.CGColor;

    }

    if (toggleCustomColour) {
      self.blurEffectView.alpha = 0;
      self.backgroundColor = [UIColor buttonColour];
      self.scheduleImage.tintColor = [UIColor iconColour];
      self.layer.shadowColor = UIColor.clearColor.CGColor;
    }

  }

  return self;

}


- (void) traitCollectionDidChange: (UITraitCollection *) previousTraitCollection {

  if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {

    self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.scheduleImage.tintColor = [UIColor whiteColor];
    self.layer.shadowColor = [UIColor colorWithRed: 0.28 green: 0.28 blue: 0.29 alpha: 1.00].CGColor;

  } else {

    self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.scheduleImage.tintColor = [UIColor lightGrayColor];
    self.layer.shadowColor = UIColor.lightGrayColor.CGColor;

  }

  if (toggleCustomColour) {
    self.blurEffectView.alpha = 0;
    self.backgroundColor = [UIColor buttonColour];
    self.scheduleImage.tintColor = [UIColor iconColour];
    self.layer.shadowColor = UIColor.clearColor.CGColor;
  }

}


@end
