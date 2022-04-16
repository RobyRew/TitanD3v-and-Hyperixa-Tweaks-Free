#import "AccessoriesCell.h"

static UIFontDescriptor *descriptor;

@implementation AccessoriesCell

- (id)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];
  if (self) {

    loadPrefs();
    descriptor = [NSKeyedUnarchiver unarchivedObjectOfClass:[UIFontDescriptor class] fromData:appdataCustomFont error:nil];

    self.baseView = [[UIView alloc] init];
    self.baseView.backgroundColor = UIColor.clearColor;
    self.baseView.clipsToBounds = true;
    self.baseView.layer.cornerRadius = 15;
    self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
    [self.contentView addSubview:self.baseView];

    [self.baseView fill];


    self.blurEffectView = [[UIVisualEffectView alloc] initWithFrame:CGRectZero];
    self.blurEffectView.alpha = 0.5;
    [self.baseView insertSubview:self.blurEffectView atIndex:0];

    [self.blurEffectView fill];


    self.accessoriesImage = [[UIImageView alloc] init];
    self.accessoriesImage.tintColor = [UIColor appdataIconColor];
    self.accessoriesImage.layer.cornerRadius = 15;
    self.accessoriesImage.clipsToBounds = true;
    [self.baseView addSubview:self.accessoriesImage];

    [self.accessoriesImage size:CGSizeMake(30, 30)];
    [self.accessoriesImage top:self.baseView.topAnchor padding:10];
    [self.accessoriesImage x:self.baseView.centerXAnchor];


    self.titleLabel = [[UILabel alloc] init];
    if (toggleAppdataCustomFont) {
      self.titleLabel.font = [UIFont fontWithDescriptor:descriptor size:12];
    } else {
      self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    }
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor appdataFontColor];
    self.titleLabel.numberOfLines = 2;
    [self.baseView addSubview:self.titleLabel];

    [self.titleLabel top:self.accessoriesImage.bottomAnchor padding:5];
    [self.titleLabel leading:self.baseView.leadingAnchor padding:5];
    [self.titleLabel trailing:self.baseView.trailingAnchor padding:-5];
    [self.titleLabel x:self.baseView.centerXAnchor];


    if (!toggleAppdataColour) {
      if([appdataAppearance isEqualToString:@"appdataLight"]) {

        self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialLight];

      } else if([appdataAppearance isEqualToString:@"appdataDark"]) {

        self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];

      } else if([appdataAppearance isEqualToString:@"appdataDynamic"]) {

        if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
          self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
        } else {
          self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialLight];
        }

      }

    } else {

      self.blurEffectView.alpha = 0;
      self.backgroundColor = [[TDTweakManager sharedInstance] colourForKey:@"appdataCellColour" defaultValue:@"FFFFFF" ID:BID];

    }


  }
  return self;
}


- (void)traitCollectionDidChange:(UITraitCollection *) previousTraitCollection {

  if (!toggleAppdataColour) {
    if([appdataAppearance isEqualToString:@"appdataDynamic"]) {

      if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
        self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
      } else {
        self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialLight];
      }

    }
  }

}


@end
