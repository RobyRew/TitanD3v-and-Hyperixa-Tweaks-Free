#import "FavouriteCategoriesCell.h"

@implementation FavouriteCategoriesCell

- (instancetype)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];
  if (self) {


    if (iPhone_6_8) {
      iconSize = 30;
      iconTopPadding = 5;
      fontSize = 10;
      fontBottomPadding = 7;
    } else if (iPhone_6_8_Plus) {
      iconSize = 40;
      iconTopPadding = 5;
      fontSize = 12;
      fontBottomPadding = 7;
    } else if (iPhone_X_XS_11Pro) {
      iconSize = 35;
      iconTopPadding = 3;
      fontSize = 11;
      fontBottomPadding = 5;
    } else if (iPhone_XR_XS_11Pro) {
      iconSize = 45;
      iconTopPadding = 3;
      fontSize = 13;
      fontBottomPadding = 5;
    } else if (iPhone_12_Pro) {
      iconSize = 40;
      iconTopPadding = 3;
      fontSize = 11;
      fontBottomPadding = 5;
    } else if (iPhone_12_mini) {
      iconSize = 30;
      iconTopPadding = 5;
      fontSize = 10;
      fontBottomPadding = 7;
    } else if (iPhone_12_Pro_Max) {
      iconSize = 45;
      iconTopPadding = 3;
      fontSize = 13;
      fontBottomPadding = 5;
    } else {
      iconSize = 30;
      iconTopPadding = 5;
      fontSize = 10;
      fontBottomPadding = 7;
    }


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

    [self.iconImage size:CGSizeMake(iconSize, iconSize)];
    [self.iconImage x:self.baseView.centerXAnchor];
    [self.iconImage top:self.baseView.topAnchor padding:iconTopPadding];


    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = UIColor.whiteColor;
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
    [self.baseView addSubview:self.titleLabel];

    [self.titleLabel x:self.baseView.centerXAnchor];
    [self.titleLabel bottom:self.baseView.bottomAnchor padding:-fontBottomPadding];
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
