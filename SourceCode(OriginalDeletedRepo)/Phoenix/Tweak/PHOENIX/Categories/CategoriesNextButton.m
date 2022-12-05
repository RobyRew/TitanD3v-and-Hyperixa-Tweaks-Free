#import "CategoriesNextButton.h"

@implementation CategoriesNextButton

-(instancetype)initWithIcon:(NSString *)iconString title:(NSString *)titleString accent:(UIColor *)accent action:(SEL)customAction {

  self = [super init];
  if (self) {


    self.backgroundColor = accent;
    self.clipsToBounds = YES;


    self.icon = [[UIImageView alloc] init];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    self.icon.tintColor = UIColor.whiteColor;
    self.icon.image = [UIImage systemImageNamed:iconString];
    [self addSubview:self.icon];

    [self.icon size:CGSizeMake(30, 30)];
    [self.icon y:self.centerYAnchor];
    [self.icon trailing:self.trailingAnchor padding:-10];


    self.title = [[UILabel alloc] init];
    self.title.textAlignment = NSTextAlignmentLeft;
    self.title.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    self.title.textColor = UIColor.whiteColor;
    self.title.text = titleString;
    [self addSubview:self.title];

    [self.title y:self.centerYAnchor];
    [self.title leading:self.leadingAnchor padding:15];
    [self.title trailing:self.icon.leadingAnchor padding:-10];

    [self addTarget:self.superview action:customAction forControlEvents:UIControlEventTouchUpInside];

  }

  return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  [self touchAnimateWithHighlighted:YES];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  [self touchAnimateWithHighlighted:NO];
}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
  [self touchAnimateWithHighlighted:NO];
}


-(void)touchAnimateWithHighlighted:(BOOL)isHighlighted {

  [UIView animateWithDuration:0.3 animations:^{
    self.alpha = isHighlighted ? 0.8 : 1.0;
    CGAffineTransform transform = self.transform;
    transform = isHighlighted ? CGAffineTransformScale(transform, 0.96, 0.96) : CGAffineTransformIdentity;
    self.transform = transform;
  }];

}

@end
