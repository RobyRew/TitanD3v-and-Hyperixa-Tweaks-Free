#import "RecordingButton.h"

@implementation RecordingButton

-(instancetype)initWithIcon:(NSString *)iconString accent:(UIColor *)accent action:(SEL)customAction {
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = accent;
        self.clipsToBounds = YES;
      
        self.icon = [[UIImageView alloc] init];
        self.icon.contentMode = UIViewContentModeScaleAspectFit;
        self.icon.tintColor = UIColor.whiteColor;
        self.icon.image = [UIImage systemImageNamed:iconString];
        [self addSubview:self.icon];
        
        [self.icon size:CGSizeMake(40, 40)];
        [self.icon x:self.centerXAnchor y:self.centerYAnchor];

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
