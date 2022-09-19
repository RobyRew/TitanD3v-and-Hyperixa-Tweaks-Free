#import "BlurBaseView.h"

@implementation BlurBaseView

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

    if (!toggleAppdataColour) {

      if([appdataAppearance isEqualToString:@"appdataLight"]) {

        if (toggleBlurEffect) {
          self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialLight];
          self.backgroundColor = UIColor.clearColor;
        } else {
          self.blurEffectView.alpha = 0;
          self.backgroundColor = UIColor.whiteColor;
        }
      } else if([appdataAppearance isEqualToString:@"appdataDark"]) {

        if (toggleBlurEffect) {
          self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
          self.backgroundColor = UIColor.clearColor;
        } else {
          self.blurEffectView.alpha = 0;
          self.backgroundColor = [UIColor colorWithRed: 0.11 green: 0.11 blue: 0.12 alpha: 1.00];
        }
      } else if([appdataAppearance isEqualToString:@"appdataDynamic"]) {

        if (toggleBlurEffect) {
          if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
            self.backgroundColor = UIColor.clearColor;
          } else {
            self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialLight];
            self.backgroundColor = UIColor.clearColor;
          }

        } else {

          self.blurEffectView.alpha = 0;

          if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.backgroundColor = [UIColor colorWithRed: 0.11 green: 0.11 blue: 0.12 alpha: 1.00];
          } else {
            self.backgroundColor = UIColor.whiteColor;
          }

        }

      }

    } else {

      self.blurEffectView.alpha = 0;
      self.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"appdataBackgroundColour" defaultValue:@"FFFFFF" ID:BID];

    }


    if (toggleAppdataBackgroundImage) {

      self.wallpaperImage = [[UIImageView alloc] init];
      self.wallpaperImage.image = [UIImage imageWithData:appdataBackgroundImage];
      self.wallpaperImage.contentMode = UIViewContentModeScaleAspectFill;
      [self addSubview:self.wallpaperImage];
      [self.wallpaperImage fill];

      self.blurEffectView.alpha = 0;
      self.backgroundColor = UIColor.clearColor;
    }

  }

  return self;

}


- (void)traitCollectionDidChange:(UITraitCollection *) previousTraitCollection {

  if (!toggleAppdataColour) {
    if([appdataAppearance isEqualToString:@"appdataDynamic"]) {

      if (toggleBlurEffect) {
        if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
          self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
          self.backgroundColor = UIColor.clearColor;
        } else {
          self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialLight];
          self.backgroundColor = UIColor.clearColor;
        }

      } else {

        self.blurEffectView.alpha = 0;

        if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
          self.backgroundColor = [UIColor colorWithRed: 0.11 green: 0.11 blue: 0.12 alpha: 1.00];
        } else {
          self.backgroundColor = UIColor.whiteColor;
        }

      }

    }
  }

}

@end
