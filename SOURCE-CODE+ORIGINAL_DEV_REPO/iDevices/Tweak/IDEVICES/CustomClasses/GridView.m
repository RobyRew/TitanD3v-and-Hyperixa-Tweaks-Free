#import "GridView.h"

@implementation GridView  

-(instancetype)initWithFrame:(CGRect)frame bg:(UIColor *)background icon:(UIImage *)icon iconSize:(CGFloat)size iconPadding:(CGFloat)iconPadding titleTop:(CGFloat)titleTop titleFont:(UIFont *)titleFont {

  self = [super initWithFrame:frame];
  if (self) {

      self.clipsToBounds = YES;
      self.backgroundColor = background;
      self.layer.cornerRadius = 20;
      self.layer.cornerCurve = kCACornerCurveContinuous;

      self.iconPadding = iconPadding;
      self.iconSize = size;
      self.iconImage = icon;
      self.titleTopPadding = titleTop;
      self.titleFont = titleFont;
      
      [self layoutViews];

  }
  return self;
}


-(void)layoutViews {
    
    self.icon = [[UIImageView alloc] init];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    self.icon.tintColor = UIColor.whiteColor;
    self.icon.image = self.iconImage;
    [self addSubview:self.icon];
    
    [self.icon size:CGSizeMake(self.iconSize, self.iconSize)];
    [self.icon top:self.topAnchor padding:self.iconPadding];
    [self.icon x:self.centerXAnchor];
    
    
    self.title = [[UILabel alloc] init];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.numberOfLines = 3;
    self.title.font = self.titleFont;
    self.title.textColor = UIColor.whiteColor;
    [self addSubview:self.title];
    
    [self.title x:self.centerXAnchor];
    [self.title top:self.icon.bottomAnchor padding:self.titleTopPadding];
    [self.title leading:self.leadingAnchor padding:20];
    [self.title trailing:self.trailingAnchor padding:-20];
 
}

@end
