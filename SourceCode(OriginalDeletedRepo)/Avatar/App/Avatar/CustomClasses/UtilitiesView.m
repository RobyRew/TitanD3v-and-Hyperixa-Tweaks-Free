#import "UtilitiesView.h"

@implementation UtilitiesView

-(instancetype)initWithFrame:(CGRect)frame icon:(UIImage *)icon {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor colorNamed:@"Secondary"];
        self.layer.cornerRadius = 20;
        self.layer.cornerCurve = kCACornerCurveContinuous;
        
        self.iconImage = icon;
        
        [self layoutViews];
        
    }
    return self;
}


-(void)layoutViews {
    
    self.iconView = [[UIView alloc] init];
    self.iconView.layer.cornerRadius = 20;
    [self addSubview:self.iconView];
    
    [self.iconView size:CGSizeMake(40, 40)];
    [self.iconView y:self.centerYAnchor];
    [self.iconView leading:self.leadingAnchor padding:15];
    
    
    self.icon = [[UIImageView alloc] init];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    self.icon.tintColor = UIColor.whiteColor;
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
    
    
    self.arrow = [[UIImageView alloc] init];
    self.arrow.contentMode = UIViewContentModeScaleAspectFit;
    self.arrow.tintColor = UIColor.tertiaryLabelColor;
    self.arrow.image = [UIImage systemImageNamed:@"chevron.compact.right"];
    [self addSubview:self.arrow];
    
    [self.arrow size:CGSizeMake(25, 25)];
    [self.arrow y:self.centerYAnchor];
    [self.arrow trailing:self.trailingAnchor padding:-5];
    
}

@end
