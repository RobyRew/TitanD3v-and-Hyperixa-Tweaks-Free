#import "TDButton.h"

@implementation TDButton

-(instancetype)initWithTitle:(NSString *)title colour:(UIColor *)colour fontColour:(UIColor *)fontColour fontSize:(CGFloat)size corner:(CGFloat)corner {

  self = [super init];
  if (self) {

    [self setTitle:title forState:UIControlStateNormal];
    self.backgroundColor = colour;
    [self setTitleColor:fontColour forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:size];
    self.layer.cornerRadius = corner;

  }
  return self;
}


-(instancetype)initWithImage:(UIImage *)image inset:(UIEdgeInsets)inset colour:(UIColor *)colour tint:(BOOL)tint tintColour:(UIColor *)tintColour corner:(CGFloat)corner {

  self = [super init];
  if (self) {

    if (tint) {
      self.tintColor = tintColour;
    }

    [self setImage:image forState:UIControlStateNormal];
    self.backgroundColor = colour;
    self.layer.cornerRadius = corner;
    self.imageEdgeInsets = inset;

  }
  return self;
}

@end
