#import "CDHeaderView.h"

@implementation CDHeaderView


-(instancetype)initWithTitle:(NSString *)title accent:(UIColor *)accent leftIcon:(NSString *)leftIconString leftAction:(SEL)leftAction {
    
    self = [super init];
    if (self) {
        
        self.clipsToBounds = YES;
        
        self.headerView = [[UIView alloc] init];
        [self addSubview:self.headerView];
        
        [self.headerView fill];
        
        
        self.grabberView = [[UIView alloc] init];
        self.grabberView.backgroundColor = [UIColor grabberColour];
        self.grabberView.layer.cornerRadius = 3;
        [self.headerView addSubview:self.grabberView];
        
        [self.grabberView size:CGSizeMake(40, 6)];
        [self.grabberView x:self.headerView.centerXAnchor];
        [self.grabberView top:self.headerView.topAnchor padding:10];
        
        
        self.leftButton = [[UIButton alloc] init];
        self.leftButton.backgroundColor = [UIColor navBarButtonColour];
        self.leftButton.layer.cornerRadius = 12;
        self.leftButton.layer.cornerCurve = kCACornerCurveContinuous;
        UIImage *leftIcon = [UIImage systemImageNamed:leftIconString];
        [self.leftButton setImage:leftIcon forState:UIControlStateNormal];
        self.leftButton.tintColor = accent;
        [self.leftButton addTarget:self.superview action:leftAction forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:self.leftButton];
        
        [self.leftButton size:CGSizeMake(40, 40)];
        [self.leftButton y:self.headerView.centerYAnchor padding:5];
        [self.leftButton leading:self.headerView.leadingAnchor padding:20];
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor fontColour];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
        self.titleLabel.text = title;
        [self.headerView addSubview:self.titleLabel];
        
        [self.titleLabel y:self.headerView.centerYAnchor padding:5];
        [self.titleLabel x:self.headerView.centerXAnchor];
        
    }
    
    return self;
}


-(instancetype)initWithTitle:(NSString *)title accent:(UIColor *)accent leftIcon:(NSString *)leftIconString leftAction:(SEL)leftAction rightIcon:(NSString *)rightIconString rightAction:(SEL)rightAction {
    
    self = [super init];
    if (self) {
        
        self.clipsToBounds = YES;
        
        self.headerView = [[UIView alloc] init];
        [self addSubview:self.headerView];
        
        [self.headerView fill];
        
        
        self.grabberView = [[UIView alloc] init];
        self.grabberView.backgroundColor = [UIColor grabberColour];
        self.grabberView.layer.cornerRadius = 3;
        [self.headerView addSubview:self.grabberView];
        
        [self.grabberView size:CGSizeMake(40, 6)];
        [self.grabberView x:self.headerView.centerXAnchor];
        [self.grabberView top:self.headerView.topAnchor padding:10];
        
        
        self.leftButton = [[UIButton alloc] init];
        self.leftButton.backgroundColor = [UIColor navBarButtonColour];
        self.leftButton.layer.cornerRadius = 12;
        self.leftButton.layer.cornerCurve = kCACornerCurveContinuous;
        UIImage *leftIcon = [UIImage systemImageNamed:leftIconString];
        [self.leftButton setImage:leftIcon forState:UIControlStateNormal];
        self.leftButton.tintColor = accent;
        [self.leftButton addTarget:self.superview action:leftAction forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:self.leftButton];
        
        [self.leftButton size:CGSizeMake(40, 40)];
        [self.leftButton y:self.headerView.centerYAnchor padding:5];
        [self.leftButton leading:self.headerView.leadingAnchor padding:20];
        
        
        self.rightButton = [[UIButton alloc] init];
        self.rightButton.backgroundColor = [UIColor navBarButtonColour];
        self.rightButton.layer.cornerRadius = 12;
        self.rightButton.layer.cornerCurve = kCACornerCurveContinuous;
        UIImage *rightIcon = [UIImage systemImageNamed:rightIconString];
        [self.rightButton setImage:rightIcon forState:UIControlStateNormal];
        [self.rightButton addTarget:self.superview action:rightAction forControlEvents:UIControlEventTouchUpInside];
        self.rightButton.tintColor = accent;
        [self.headerView addSubview:self.rightButton];
        
        [self.rightButton size:CGSizeMake(40, 40)];
        [self.rightButton y:self.headerView.centerYAnchor padding:5];
        [self.rightButton trailing:self.headerView.trailingAnchor padding:-20];
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor fontColour];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
        self.titleLabel.text = title;
        [self.headerView addSubview:self.titleLabel];
        
        [self.titleLabel y:self.headerView.centerYAnchor padding:5];
        [self.titleLabel x:self.headerView.centerXAnchor];
        
    }
    
    return self;
}


@end
