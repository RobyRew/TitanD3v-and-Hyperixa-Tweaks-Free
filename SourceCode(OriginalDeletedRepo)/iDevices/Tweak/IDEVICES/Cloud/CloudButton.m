#import "CloudButton.h"

@implementation CloudButton

-(instancetype)initWithAction:(SEL)customAction {
    
    self = [super init];
    if (self) {
        
        self.clipsToBounds = YES;

        
        self.title = [[UILabel alloc] init];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
        self.title.textColor = UIColor.whiteColor;
        self.title.numberOfLines = 2;
        [self addSubview:self.title];
        
        [self.title x:self.centerXAnchor];
        [self.title y:self.centerYAnchor];
        [self.title leading:self.leadingAnchor padding:5];
        [self.title trailing:self.trailingAnchor padding:-5];
        
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
    transform = isHighlighted ? CGAffineTransformScale(transform, 0.94, 0.94) : CGAffineTransformIdentity;
    self.transform = transform;
    }];
    
}

@end
