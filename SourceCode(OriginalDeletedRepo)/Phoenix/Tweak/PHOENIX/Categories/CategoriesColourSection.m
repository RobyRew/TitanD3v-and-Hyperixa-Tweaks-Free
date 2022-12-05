#import "CategoriesColourSection.h"

@implementation CategoriesColourSection

-(instancetype)initWithFrame:(CGRect)frame icon:(UIImage *)icon {

  self = [super initWithFrame:frame];
  if (self) {

    self.clipsToBounds = YES;
    self.backgroundColor = UIColor.secondarySystemBackgroundColor;
    self.layer.cornerRadius = 20;
    self.layer.cornerCurve = kCACornerCurveContinuous;

    self.iconImage = icon;

    [self layoutViews];

  }
  return self;
}


-(void)layoutViews {

  self.iconView = [[UIView alloc] init];
  self.iconView.layer.cornerRadius = 12;
  self.iconView.layer.cornerCurve = kCACornerCurveContinuous;
  [self addSubview:self.iconView];

  [self.iconView size:CGSizeMake(45, 45)];
  [self.iconView y:self.centerYAnchor];
  [self.iconView leading:self.leadingAnchor padding:15];


  self.icon = [[UIImageView alloc] init];
  self.icon.contentMode = UIViewContentModeScaleAspectFit;
  self.icon.image = self.iconImage;
  [self addSubview:self.icon];

  [self.icon size:CGSizeMake(30, 30)];
  [self.icon x:self.iconView.centerXAnchor y:self.iconView.centerYAnchor];


  self.title = [[UILabel alloc] init];
  self.title.textAlignment = NSTextAlignmentLeft;
  self.title.textColor = UIColor.labelColor;
  self.title.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
  [self addSubview:self.title];

  [self.title y:self.centerYAnchor];
  [self.title leading:self.icon.trailingAnchor padding:15];


  self.wheelImage = [[UIImageView alloc] init];
  self.wheelImage.contentMode = UIViewContentModeScaleAspectFill;
  self.wheelImage.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Phoenix.bundle/Assets/colour-wheel.png"];
  self.wheelImage.layer.cornerRadius = 20;
  self.wheelImage.clipsToBounds = YES;
  [self addSubview:self.wheelImage];

  [self.wheelImage size:CGSizeMake(40, 40)];
  [self.wheelImage y:self.centerYAnchor];
  [self.wheelImage trailing:self.trailingAnchor padding:-10];


  self.colourView = [[UIView alloc] init];
  self.colourView.layer.cornerRadius = 17.5;
  self.colourView.clipsToBounds = YES;
  [self addSubview:self.colourView];

  [self.colourView size:CGSizeMake(35, 35)];
  [self.colourView x:self.wheelImage.centerXAnchor y:self.wheelImage.centerYAnchor];

}

@end
