#import "CategoriesCell.h"

@implementation CategoriesCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIColor *primraryColour = [UIColor colorWithRed: 0.07 green: 0.09 blue: 0.11 alpha: 1.00];
        UIColor *secondaryColour = [UIColor colorWithRed: 0.11 green: 0.11 blue: 0.11 alpha: 1.00];
        
        self.baseView = [[UIView alloc] init];
        self.baseView.backgroundColor = UIColor.clearColor;
        self.baseView.clipsToBounds = true;
        [self.contentView addSubview:self.baseView];
        
        [self.baseView fill];
        
        
        self.selectedView = [[UIView alloc] init];
        self.selectedView.backgroundColor = [UIColor colorWithRed: 0.95 green: 0.27 blue: 0.17 alpha: 1.00];
        self.selectedView.layer.cornerRadius = 3;
        self.selectedView.layer.maskedCorners = 3;
        self.selectedView.clipsToBounds = true;
        [self.baseView addSubview:self.selectedView];
        
        [self.selectedView size:CGSizeMake(55, 5)];
        [self.selectedView x:self.baseView.centerXAnchor];
        [self.selectedView bottom:self.baseView.bottomAnchor padding:0];
        
        
        self.iconView = [[UIView alloc] init];
        self.iconView.backgroundColor = UIColor.clearColor;
        self.iconView.layer.cornerRadius = 15;
        self.iconView.layer.cornerCurve = kCACornerCurveContinuous;
        self.iconView.clipsToBounds = true;
        [self.baseView addSubview:self.iconView];
        
        [self.iconView size:CGSizeMake(55, 55)];
        [self.iconView x:self.baseView.centerXAnchor];
        [self.iconView top:self.baseView.topAnchor padding:0];
        
        
        self.gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
        self.gradientView.backgroundColor = UIColor.clearColor;
        [self.iconView addSubview:self.gradientView];
        
        
        self.gradient = [CAGradientLayer layer];
        self.gradient.frame = self.gradientView.bounds;
        self.gradient.colors = @[(id)primraryColour.CGColor, (id)secondaryColour.CGColor];
        [self.gradientView.layer insertSublayer:self.gradient atIndex:0];
        
        
        self.iconImage = [[UIImageView alloc] init];
        self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.iconView addSubview:self.iconImage];
        
        [self.iconImage size:CGSizeMake(40, 40)];
        [self.iconImage x:self.iconView.centerXAnchor y:self.iconView.centerYAnchor];
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.6];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
        [self.baseView addSubview:self.titleLabel];
        
        [self.titleLabel top:self.iconView.bottomAnchor padding:0];
        [self.titleLabel x:self.iconView.centerXAnchor];
        
        
    }
    return self;
}


@end
