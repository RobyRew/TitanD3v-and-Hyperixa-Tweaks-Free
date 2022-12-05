#import "FavouriteFilterCell.h"

@implementation FavouriteFilterCell

- (instancetype)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];
  if (self) {

    self.layer.cornerRadius = 12;
    self.layer.cornerCurve = kCACornerCurveContinuous;
    self.clipsToBounds = true;

    self.baseView = [[UIView alloc] init];
    self.baseView.layer.cornerRadius = 12;
    self.baseView.clipsToBounds = true;
    self.baseView.layer.cornerCurve = kCACornerCurveContinuous;
    [self.contentView addSubview:self.baseView];

    [self.baseView fill];


    self.iconImage = [[UIImageView alloc] init];
    self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.baseView addSubview:self.iconImage];

    [self.iconImage size:CGSizeMake(35, 35)];
    [self.iconImage x:self.baseView.centerXAnchor];
    [self.iconImage top:self.baseView.topAnchor padding:10];


    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = UIColor.whiteColor;
    self.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    [self.baseView addSubview:self.titleLabel];

    [self.titleLabel x:self.baseView.centerXAnchor];
    [self.titleLabel bottom:self.baseView.bottomAnchor padding:-5];
    [self.titleLabel leading:self.baseView.leadingAnchor padding:3];
    [self.titleLabel trailing:self.baseView.trailingAnchor padding:-3];

  }
  return self;
}


-(void)prepareForReuse {
  [super prepareForReuse];

  self.iconImage.image = nil;
  self.titleLabel.text = nil;
}


- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  self.backgroundColor = highlighted ? UIColor.secondarySystemBackgroundColor : UIColor.secondarySystemBackgroundColor;
}

@end
