#import "ThemeCell.h"

@implementation ThemeCell


- (id)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];
  if (self) {

    self.baseView = [[UIView alloc] init];
    self.baseView.backgroundColor = [UIColor colorWithRed: 0.20 green: 0.20 blue: 0.20 alpha: 0.5];
    self.baseView.clipsToBounds = YES;
    self.baseView.layer.cornerRadius = 15;
    if(@available(iOS 13.0, *)) {
      self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
    }
    [self.contentView addSubview:self.baseView];

    self.baseView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.baseView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [self.baseView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
    [self.baseView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;
    [self.baseView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;


    self.colourImage = [[UIImageView alloc] init];
    self.colourImage.image = [UIImage imageWithContentsOfFile:@"/usr/lib/TitanD3v/TitanD3v.bundle/Drawer/colour-wheel.png"];
    self.colourImage.layer.cornerRadius = 30;
    self.colourImage.clipsToBounds = true;
    [self.baseView addSubview:self.colourImage];

    self.colourImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.colourImage.widthAnchor constraintEqualToConstant:60.0].active = YES;
    [self.colourImage.heightAnchor constraintEqualToConstant:60.0].active = YES;
    [[self.colourImage centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor constant:-10].active = YES;
    [[self.colourImage centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = YES;


    self.colourView = [[UIView alloc] init];
    self.colourView.layer.cornerRadius = 27.5;
    self.colourView.clipsToBounds = true;
    [self.baseView addSubview:self.colourView];

    self.colourView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.colourView.widthAnchor constraintEqualToConstant:55.0].active = YES;
    [self.colourView.heightAnchor constraintEqualToConstant:55.0].active = YES;
    [[self.colourView centerYAnchor] constraintEqualToAnchor:self.baseView.centerYAnchor constant:-10].active = YES;
    [[self.colourView centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = YES;


    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.7];
    [self.baseView addSubview:self.titleLabel];

    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.titleLabel centerXAnchor] constraintEqualToAnchor:self.baseView.centerXAnchor].active = YES;
    [self.titleLabel.topAnchor constraintEqualToAnchor:self.colourImage.bottomAnchor constant:10].active = YES;


  }
  return self;
}


@end
