#import "CategoriesColourCell.h"

@implementation CategoriesColourCell

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

    [self.iconImage size:CGSizeMake(40, 40)];
    [self.iconImage x:self.baseView.centerXAnchor y:self.baseView.centerYAnchor];

  }
  return self;
}


-(void)prepareForReuse {
  [super prepareForReuse];

  self.iconImage.image = nil;
}


- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  self.backgroundColor = highlighted ? UIColor.secondarySystemBackgroundColor : UIColor.secondarySystemBackgroundColor;
}

@end
