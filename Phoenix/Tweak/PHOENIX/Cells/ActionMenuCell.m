#import "ActionMenuCell.h"

@implementation ActionMenuCell

- (instancetype)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];
  if (self) {

    self.baseView = [[UIView alloc] init];
    self.baseView.backgroundColor = UIColor.clearColor;
    [self addSubview:self.baseView];

    [self.baseView top:self.topAnchor padding:0];
    [self.baseView leading:self.leadingAnchor padding:0];
    [self.baseView trailing:self.trailingAnchor padding:0];
    [self.baseView bottom:self.bottomAnchor padding:0];


    self.iconView = [[UIView alloc] init];
    self.iconView.layer.cornerRadius = 10;
    self.iconView.layer.cornerCurve = kCACornerCurveContinuous;
    [self.baseView addSubview:self.iconView];

    [self.iconView size:CGSizeMake(50, 50)];
    [self.iconView x:self.baseView.centerXAnchor];
    [self.iconView top:self.baseView.topAnchor padding:0];


    self.iconImage = [[UIImageView alloc] init];
    self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.iconView addSubview:self.iconImage];

    [self.iconImage size:CGSizeMake(30, 30)];
    [self.iconImage x:self.iconView.centerXAnchor y:self.iconView.centerYAnchor];


    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = UIColor.labelColor;
    self.titleLabel.font = [UIFont systemFontOfSize:9 weight:UIFontWeightRegular];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.baseView addSubview:self.titleLabel];

    [self.titleLabel top:self.iconView.bottomAnchor padding:3];
    [self.titleLabel x:self.baseView.centerXAnchor];

  }

  return self;
}


-(void)prepareForReuse {
  [super prepareForReuse];
  self.iconImage.image = nil;
  self.titleLabel.text = nil;
}

@end
