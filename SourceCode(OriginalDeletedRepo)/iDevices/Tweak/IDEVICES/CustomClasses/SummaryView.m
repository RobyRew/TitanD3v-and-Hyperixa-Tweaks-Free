#import "SummaryView.h"

@implementation SummaryView

-(instancetype)initWithFrame:(CGRect)frame icon:(UIImage *)icon {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor cellColour];
        self.layer.cornerRadius = 14;
        self.layer.cornerCurve = kCACornerCurveContinuous;
        
        self.iconImage = icon;
        
        [self layoutViews];
        
    }
    return self;
}


-(void)layoutViews {
    
    self.iconView = [[UIView alloc] init];
    self.iconView.layer.cornerRadius = 12.5;
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
    self.title.textColor = UIColor.titleColour;
    self.title.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    [self addSubview:self.title];
    
    [self.title top:self.iconView.topAnchor padding:2];
    [self.title leading:self.icon.trailingAnchor padding:15];
    
    
    self.subtitle = [[UILabel alloc] init];
    self.subtitle.textAlignment = NSTextAlignmentLeft;
    self.subtitle.textColor = UIColor.subtitleColour;
    self.subtitle.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [self addSubview:self.subtitle];
    
    [self.subtitle bottom:self.iconView.bottomAnchor padding:-2];
    [self.subtitle leading:self.icon.trailingAnchor padding:15];
    
}

@end
